import std/parseopt
import std/options
import std/strutils

type 
    ArgOptions* = object
        url* :string
        output* : string
        colorMode*: bool

proc runCli*(): Option[ArgOptions] =
    var
        url: string
        output: string
        colorMode: bool
    for kind,key,value in getOpt():
        case kind:
        of cmdArgument:
            discard
        of cmdLongOption, cmdShortOption:
            case key:
            of "h", "help":
                echo "help!"
            of "u", "url":
                url = value
            of "o", "output":
                output = value
            of "c", "colorMode":
                case value.toLower:
                of "true":
                    colorMode = true
                of "false":
                    colorMode = false
                else:
                    echo "Please provide a valid option (true|false) for `color`."
                    result = none(ArgOptions)
            else:
                echo "Unknown option: ", key
                result = none(ArgOptions)
        of cmdEnd:
            discard
    result = some(ArgOptions(url: url, output: output, colorMode: colorMode))