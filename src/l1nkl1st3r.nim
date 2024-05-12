import std/htmlparser
import std/xmltree 
import std/strtabs 
import std/os       
import std/tables
import std/options
import std/httpclient
from cli import runCli
from filemanager import FileManager, writeReportFile
from httpcli import HttpCli, makeGetRequest
import logger


when isMainModule:
  if paramCount() == 0:
      echo "Please provide arguments"
      quit(1)
  let argOpts = runCli()
  if argOpts.isNone:
    quit(1)
  let args = argOpts.get()
  var l = Logger()
  l.colored=args.colorMode
  var httpCl = HttpCli(l:l)
  let response = httpCl.makeGetRequest(args.url)
  if response.isSome:
    if response.get().status != Http200:
      quit(1)
  else:
    quit(1)
  let content = response.get().content.get()
  var
    links = Table[string, int]()
  let html = parseHtml(content)
  for l in html.findAll("a"):
    var href = l.attrs["href"]
    if not links.contains(href):
      links[href] = 0
    inc(links[href])
  l.printCapturedLinks(links)
  if len(args.output) != 0:
    let fManager = FileManager(filename:args.output, l: l)
    let fResult = fManager.writeReportFile(links)
    l.printSuccess(fResult.get())