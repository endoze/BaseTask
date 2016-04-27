//
//  BaseTask.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

/**
 <#Description#>

 - Get:    <#Get description#>
 - Post:   <#Post description#>
 - Put:    <#Put description#>
 - Patch:  <#Patch description#>
 - Delete: <#Delete description#>
 */
@objc public enum HTTPMethod: Int {
  /**
   *  <#Description#>
   */
  case Get

  /**
   *  <#Description#>
   */
  case Post

  /**
   *  <#Description#>
   */
  case Put

  /**
   *  <#Description#>
   */
  case Patch

  /**
   *  <#Description#>
   */
  case Delete
}

/**
 *  <#Description#>
 */
public protocol BodyParseable {
  /**
   <#Description#>

   - parameter bodyDictionary: <#bodyDictionary description#>

   - returns: <#return value description#>
   */
  func parsedBody(bodyDictionary: [String: AnyObject]?) -> NSData?
}

/**
 *  <#Description#>
 */
public protocol ResponseParseable {
  /**
   <#Description#>

   - parameter jsonData: <#jsonData description#>

   - returns: <#return value description#>
   */
  func parsedObject(jsonData: AnyObject?) -> AnyObject?
}

/// <#Description#>
public class BaseTask: NSObject {
    /// <#Description#>
  public typealias CompletionHandler = (parsedObject: AnyObject?, response: NSURLResponse?, error: NSError?) -> Void
    /// <#Description#>
  public typealias ValidationHandler = (response: NSURLResponse, data: NSData?, inout error: NSError?) -> Bool

    /// <#Description#>
  var session: NSURLSession

    /// <#Description#>
  var defaultBodyParser = BodyParser()

    /// <#Description#>
  var defaultResponseParsers: [ResponseParseable] = []

    /// <#Description#>
  var validationHandler: ValidationHandler?

  /**
   <#Description#>

   - parameter session: <#session description#>

   - returns: <#return value description#>
   */
  public init(session: NSURLSession = NSURLSession(configuration: NSURLSession.sharedSession().configuration)) {
    self.session = session
  }

  /**
   <#Description#>

   - parameter url:             <#url description#>
   - parameter bodyDictionary:  <#bodyDictionary description#>
   - parameter httpMethod:      <#httpMethod description#>
   - parameter httpHeaders:     <#httpHeaders description#>
   - parameter bodyParser:      <#bodyParser description#>
   - parameter responseParsers: <#responseParsers description#>
   - parameter dispatchQueue:   <#dispatchQueue description#>
   - parameter completion:      <#completion description#>

   - returns: <#return value description#>
   */
  public func makeHTTPRequest(url: NSURL,
    bodyDictionary: [String: AnyObject]?,
    httpMethod: HTTPMethod,
    httpHeaders: [HTTPHeader]?,
    bodyParser: BodyParseable?,
    responseParsers: [ResponseParseable]?,
    dispatchQueue: dispatch_queue_t = dispatch_get_main_queue(),
    completion: CompletionHandler) -> NSURLSessionDataTask {

    let request: NSURLRequest
    let bodyData: NSData?

    let bodyParserToUse = bodyParser ?? defaultBodyParser
    let responseParsersToUse = responseParsers ?? defaultResponseParsers

    if let bodyDictionary = bodyDictionary {
      bodyData = bodyParserToUse.parsedBody(bodyDictionary)
    } else {
      bodyData = nil
    }

    switch httpMethod {
      case .Get: request = NSURLRequest.getRequest(url, headers: httpHeaders)
      case .Put: request = NSURLRequest.putRequest(url, body: bodyData)
      case .Patch: request = NSURLRequest.patchRequest(url, body: bodyData)
      case .Delete: request = NSURLRequest.deleteRequest(url, headers: httpHeaders)
      case .Post: request = NSURLRequest.postRequest(url, body: bodyData)
    }

    return session.dataTaskWithRequest(request, completionHandler: { data, response, error in
      var parsedObject: AnyObject?
      var internalError = error

      if let response = response, data = data {
        if internalError == nil {
          if let validationHandler = self.validationHandler {
            validationHandler(response: response, data: data, error: &internalError)
          }

          if internalError == nil {
            parsedObject = responseParsersToUse.reduce(data as AnyObject) { $1.parsedObject($0) }
          }
        }
      }

      dispatch_async(dispatchQueue, { () -> Void in
        completion(parsedObject: parsedObject, response: response, error: internalError)
      })
    })
  }
}