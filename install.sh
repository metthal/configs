#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LLVM_VERSION="7.0.1"

function backup() {
	if [ -h "$1" ]; then
		unlink "$1"
	elif [ -f "$1" ]; then
		mv "$1" "$1.backup"
	fi
}

function install() {
	backup "${HOME}/$1"
	ln -s "${SCRIPT_DIR}/$1" "${HOME}/$1"
}

function download_llvm_archive() {
	mkdir -p ~/clang/${LLVM_VERSION}
	if [ ! -f ~/clang/${LLVM_VERSION}/$1-${LLVM_VERSION}.src.tar.xz ]; then
		curl -o ~/clang/${LLVM_VERSION}/$1-${LLVM_VERSION}.src.tar.xz "http://releases.llvm.org/${LLVM_VERSION}/$1-${LLVM_VERSION}.src.tar.xz"
	fi
}

function build_command_t() {
	pushd ~/.vim/bundle/command-t/ruby/command-t/ext/command-t && \
	ruby extconf.rb && \
	make -j$(nproc) && \
	popd
}

function build_llvm() {
	if [ ! -d ~/clang/${LLVM_VERSION}/llvm-install ]; then
		bash ${SCRIPT_DIR}/llvm_build_script.sh ${LLVM_VERSION} ~/clang
	fi
}

function build_ycm() {
	pushd ~/.vim/bundle/YouCompleteMe && \
	mkdir -p ycm_build && \
	pushd ycm_build && \
	cmake -DPATH_TO_LLVM_ROOT=~/clang/${LLVM_VERSION}/llvm-install -DEXTERNAL_LIBCLANG_PATH=~/clang/${LLVM_VERSION}/llvm-install/lib/libclang.so -DUSE_PYTHON2=OFF -G"Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp && \
	cmake --build . --target ycm_core --config Release && \
	popd && \
	popd
}

if [ -f /etc/fedora-release ]; then
	sudo dnf install -y cmake curl git gcc make powerline-fonts python3 python3-devel redhat-rpm-config ruby ruby-devel tmux vim
fi

install .bashrc
install .gitconfig
install .tmux.conf
install .vimrc
install .ycm_extra_conf.py
install git-prompt.sh

download_llvm_archive llvm
download_llvm_archive cfe
build_llvm

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim --clean +'silent! source ~/.vimrc' +PluginInstall +PluginUpdate +qa && \
build_command_t && \
build_ycm

if [ ! -d ~/.tmux/plugins/tpm ]; then
	git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
fi

~/.tmux/plugins/tpm/bin/install_plugins && \
~/.tmux/plugins/tpm/bin/update_plugins all
