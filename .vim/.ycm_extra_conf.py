from os.path import abspath, dirname, join, exists

DIR_OF_THIS_SCRIPT = abspath( dirname( __file__ ) )

def Settings( **kwargs ):
    cmake_commands = join( DIR_OF_THIS_SCRIPT, '.' )
    if exists( cmake_commands ):
      return {
        'ls': {
          'compilationDatabasePath': dirname( cmake_commands )
        }
      }
