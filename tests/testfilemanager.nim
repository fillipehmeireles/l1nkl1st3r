import unittest2
from ../src/filemanager import FileManager, writeReportFile
import std/tables
import std/options
import std/os
import ../src/logger

suite "Test FileManager":
    setup:
        const filename ="testfile.txt"
        var l = Logger()
        l.colored=true
 
        let links =  {
            "http://example.com/5": 1,
            "http://example.com/1": 2,
            "http://example.com/2": 1,
            }.toTable

    test "Test write report file":
        let fManager = FileManager(filename:filename, l: l)
        let res = fManager.writeReportFile(links)
        check res.isSome
        removeFile(filename)
