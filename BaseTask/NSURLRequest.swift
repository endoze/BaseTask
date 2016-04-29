//
//  NSURLRequest.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//
//

import Foundation

// MARK: - NSURLRequest Extension
extension NSURLRequest {
  /**
   HTTP request method options

   - GET:    Get request
   - PUT:    Put request
   - POST:   Post request
   - DELETE: Delete request
   - PATCH:  Patch request
   */
  enum HTTPMethod: String {
    case GET
    case PUT
    case POST
    case DELETE
    case PATCH
  }

  /**
   Method used to create a GET NSURLRequest.

   - parameter url:     URL to request.
   - parameter headers: Headers to set on NSURLRequest.

   - returns: Returns an NSURLRequest instance.
   */
  class func getRequest(url: NSURL, headers: [HTTPHeader]?) -> NSURLRequest {
    return _request(url, httpMethod: .GET, body: nil, headers: headers)
  }

  /**
   Method used to create a DELETE NSURLRequest.

   - parameter url:     URL to request.
   - parameter headers: Headers to set on NSURLRequest.

   - returns: Returns an NSURLRequest instance.
   */
  class func deleteRequest(url: NSURL, headers: [HTTPHeader]?) -> NSURLRequest {
    return _request(url, httpMethod: .DELETE, body: nil, headers: headers)
  }

  /**
   Method used to create a POST NSURLRequest.

   - parameter url:     URL to request.
   - parameter body:    Body of HTTP Request.
   - parameter headers: Headers to set on NSURLRequest.

   - returns: Returns an NSURLRequest instance.
   */
  class func postRequest(url: NSURL, body: NSData?, headers: [HTTPHeader]? = nil) -> NSURLRequest {
    return _request(url, httpMethod: .POST, body: body, headers: headers)
  }

  /**
   Method used to create a PATCH NSURLRequest.

   - parameter url:     URL to request.
   - parameter body:    Body of HTTP Request.
   - parameter headers: Headers to set on NSURLRequest.

   - returns: Returns an NSURLRequest instance.
   */
  class func patchRequest(url: NSURL, body: NSData?, headers: [HTTPHeader]? = nil) -> NSURLRequest {
    return _request(url, httpMethod: .PATCH, body: body, headers: headers)
  }

  /**
   Method used to create a PUT NSURLRequest.

   - parameter url:     URL to request.
   - parameter body:    Body of HTTP Request.
   - parameter headers: Headers to set on NSURLRequest.

   - returns: Returns an NSURLRequest instance.
   */
  class func putRequest(url: NSURL, body: NSData?, headers: [HTTPHeader]? = nil) -> NSURLRequest {
    return _request(url, httpMethod: .PUT, body: body, headers: headers)
  }

  /**
   Method used to create a new NSURLRequest configured based on the method paramaters passed in.

   - parameter url:        URL to request.
   - parameter httpMethod: HTTP method for request.
   - parameter body:       Body of HTTP Request.
   - parameter headers:    Headers to set on NSURLRequest.

   - returns: Returns an NSURLRequest instance.
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
