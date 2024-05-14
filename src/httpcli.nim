import std/httpclient
import std/options
from logger import Logger, printError

type ResponseStats* = object
    status*: HttpCode
    content*: Option[string]

type 
    HttpCli* = object
        l*: Logger

proc makeGetRequest*(self: HttpCli, url: string): Option[ResponseStats] = 
    try:
        let client: HttpClient = newHttpClient()
        defer: client.close() 
        var response = client.get(url)
        if response.code != Http200:
            self.l.printError("Error on make http request to target ")
            return some(ResponseStats(status: response.code, content: none(string)))
        result = some(ResponseStats(status: response.code, content: some(response.body)))
    except OSError as e:
        self.l.printError("HTTP request failed with OSError:")
        self.l.printError("Error code: " & $e.errorCode)
        result = none(ResponseStats)
    
   
        
