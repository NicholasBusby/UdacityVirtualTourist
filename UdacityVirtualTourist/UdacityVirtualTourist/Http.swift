//
//  Http.swift
//  UdacityVirtualTourist
//
//  Created by Nicholas Busby on 7/1/15.
//  Copyright (c) 2015 CareerBuilder. All rights reserved.
//

import Foundation

class Http {
    static let JSON = "application/json"
    static var session = NSURLSession.sharedSession()
    
    static func getRequest(url: String, headers: [String: String], queryString: [String: String]) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: buildURLAndQueryString(url, queryString: queryString))
        request.timeoutInterval = 15
        request.addValue(JSON, forHTTPHeaderField: "Accept")
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    static func buildTask(request: NSMutableURLRequest, completionHandler: (result: NSData!, error: NSError?) -> Void) -> NSURLSessionDataTask{
        if !isConnectedToNetwork() { completionHandler(result: nil, error: NSError(domain: "No Network Connection", code: 404, userInfo: nil)) }
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            if let error = downloadError {
                completionHandler(result: nil, error: error)
            } else {
                completionHandler(result: data, error: nil)
            }
        }
        task.resume()
        return task
    }
    
    static func buildURLAndQueryString(baseUrl: String, queryString: [String: String]) -> NSURL {
        var url = NSURL(string: baseUrl + escapedParameters(queryString))
        
        return url!
    }
    
    static func escapedParameters(parameters: [String : AnyObject]) -> String {
        var urlVars = [String]()
        for (key, value) in parameters {
            let stringValue = "\(value)"
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (!urlVars.isEmpty ? "?" : "") + join("&", urlVars)
    }
    
    static func isConnectedToNetwork() -> Bool {
        var status:Bool = false
        
        let url = NSURL(string: "http://careerbuilder.com")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var response:NSURLResponse?
        
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
        
        if let httpResponse = response as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 {
                status = true
            }
        }
        
        return status
    }
}
