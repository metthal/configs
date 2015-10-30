import ycm_core

flags=[
    '-Wall',
    '-Wextra',
    '-std=c++14',
    '-xc++',
]

def FlagsForFile(filename, **kwargs):
    return {
        'flags':    flags,
        'do_cache': True
    }

