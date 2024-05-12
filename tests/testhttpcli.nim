import unittest2
import std/httpclient
from ../src/httpcli import HttpCli, makeGetRequest
import ../src/logger

suite "Test HTTP Client service":
    setup:
        const targetUrl = "https://api.sampleapis.com/beers/ale"
        var l = Logger()
        l.colored=true
    test "Make GET request":
        var httpCli = HttpCli(l:l)
        check: httpCli.makeGetRequest(targetUrl).status == Http200