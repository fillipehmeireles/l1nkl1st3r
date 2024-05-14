import std/tables
import std/options
import logger

type
  FileResult* = Option[string]

type
    FileManager* = object
        filename*: string
        l*: Logger

proc writeReportFile*(self: FileManager, links: Table[string, int]): FileResult=
    try:
        let f = open(self.filename, fmWrite)
        defer: f.close()
        for l,o in links:
            var line = "link: " & l & "\t" & "ocurrences: " & $o
            f.writeLine(line)
        result = some("File sucessfully written")
    except IOError:
         self.l.printError("Error: Unable to write to file " & self.filename)
         result = none(string)

        
