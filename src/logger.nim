import std/tables

type
    ColorCodes = string

const 
    ColorCodeGreen = ColorCodes("32")
    ColorCodeRed =  ColorCodes("31")

type 
    ColoredMeta = object
        beginMeta: string
        endMeta: string = "\x1b[0m"

proc errorMetaColor(self: var ColoredMeta)  =
    self.beginMeta = "\x1b[" &  ColorCodeRed & "m"

proc successMetaColor(self: var ColoredMeta)  =
    self.beginMeta = "\x1b[" & ColorCodeGreen & "m"

type
    Logger* = ref object of RootObj
        c: bool = false
        coloredMeta: ColoredMeta = ColoredMeta()
    
proc `colored=`*(l: var Logger, v: bool) {.inline.} =
    l.c = v

proc printCapturedLinks*(self: Logger, links: Table[string, int])  =
    if self.c: self.coloredMeta.successMetaColor()
    for l, o in links:
        echo self.coloredMeta.beginMeta, "link: " ,l, "\t","ocurrences: ", o ,  self.coloredMeta.endMeta

proc printError*(self: Logger, text: string) =
    if self.c: self.coloredMeta.errorMetaColor()
    echo self.coloredMeta.beginMeta, text , self.coloredMeta.endMeta

proc printSuccess*(self: Logger, text: string) =
    if self.c: self.coloredMeta.successMetaColor()
    echo self.coloredMeta.beginMeta, text , self.coloredMeta.endMeta
