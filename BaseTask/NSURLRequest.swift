//
//  NSURLRequest.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//
//

import Foundation

// MARK: - <#Description#>
extension NSURLRequest {
  /**
   <#Description#>

   - GET:    <#GET description#>
   - PUT:    <#PUT description#>
   - POST:   <#POST description#>
   - DELETE: <#DELETE description#>
   - PATCH:  <#PATCH description#>
   */
  enum HTTPMethod: String {
    
    case GET
    case PUT
    case POST
    case DELETE
    case PATCH
  }

  /**
   <#Description#>

   - parameter url:     <#url description#>
   - parameter headers: <#headers description#>

   - returns: <#return value description#>
   */
  class func getRequest(url: NSURL, headers: [HTTPHeader]?) -> NSURLRequest {
    return _request(url, httpMethod: .GET, body: nil, headers: headers)
  }

  /**
   <#Description#>

   - parameter url:     <#url description#>
   - parameter headers: <#headers description#>

   - returns: <#return value description#>
   */
  class func deleteRequest(url: NSURL, headers: [HTTPHeader]?) -> NSURLRequest {
    return _request(url, httpMethod: .DELETE, body: nil, headers: headers)
  }

  /**
   <#Description#>

   - parameter url:     <#url description#>
   - parameter body:    <#body description#>
   - parameter headers: <#headers description#>

   - returns: <#return value description#>
   */
  class func postRequest(url: NSURL, body: NSData?, headers: [HTTPHeader]? = nil) -> NSURLRequest {
    return _request(url, httpMethod: .POST, body: body, headers: headers)
  }

  /**
   <#Description#>

   - parameter url:     <#url description#>
   - parameter body:    <#body description#>
   - parameter headers: <#headers description#>

   - returns: <#return value description#>
   */
  class func patchRequest(url: NSURL, body: NSData?, headers: [HTTPHeader]? = nil) -> NSURLRequest {
    return _request(url, httpMethod: .PATCH, body: body, headers: headers)
  }

  /**
   <#Description#>

   - parameter url:     <#url description#>
   - parameter body:    <#body description#>
   - parameter headers: <#headers description#>

   - returns: <#return value description#>
   */
  class func putRequest(url: NSURL, body: NSData?, headers: [HTTPHeader]? = nil) -> NSURLRequest {
    return _request(url, httpMethod: .PUT, body: body, headers: headers)
  }

  /**
   <#Description#>

   - parameter url:        <#url description#>
   - parameter httpMethod: <#httpMethod description#>
   - parameter body:       <#body description#>
   - parameter headers:    <#headers description#>

   - returns: <#return value description#>
   */
  private class func _request(url: NSURL, httpMethod: HTTPMethod, body: NSData?, headers: [HTTPHeader]?) -> NSURLRequest {
    let request = NSMutableURLRequest(URL: url)

    request.HTTPMethod = httpMethod.rawValue

    if let body = body {
      request.HTTPBody = body
    }

    if let headers = headers {
      for header in headers {
        request.setValue(header.value, forHTTPHeaderField: header.key)
      }
    }

    return request.copy() as! NSURLRequest
  }
}
