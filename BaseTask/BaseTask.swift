//
//  BaseTask.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

/**
 Enum representing the different types of HTTP methods.
 */
@objc public enum HTTPMethod: Int {
  /**
   *  HTTP Get
   */
  case Get

  /**
   *  HTTP Post
   */
  case Post

  /**
   *  HTTP Put
   */
  case Put

  /**
   *  HTTP Patch
   */
  case Patch

  /**
   *  HTTP Delete
   */
  case Delete
}

/**
 *  Protocol that describes an object that can parse a dictionary into the correct format for an http request body.
 */
@objc public protocol BodyParseable {
  /**
   This method accepts a dictionary and returns NSData or nil. The return of this method is used as the http requests body.

   - parameter bodyDictionary: Dictionary containing values being sent in the body of an http request.
   
   - returns: NSData or nil.
   */
  func parsedBody(bodyDictionary: [String: AnyObject]?) -> NSData?
}

/**
 *  Protocol that describes an object that can parse a response from an http request into another form. Objects that implment this protocol can be chained together to do multistep processing of values returned from an http request.
 */
@objc public protocol ResponseParseable {
  /**
   This method accepts an object and returns another object or nil. An example could be transforming NSData into an NSDictionary.

   - parameter data: Data from the http response or from another ResponseParseable.

   - returns: Returns an object or nil.
   */
  func parsedObject(data: AnyObject?) -> AnyObject?
}

/// BaseTask is a class designed to be subclassed. It helps in defining an API interface to a web service.
public class BaseTask: NSObject {
    /// Closure that captures what to do when an http request completes and a response sent back.
  public typealias CompletionHandler = (parsedObject: AnyObject?, response: NSURLResponse?, error: NSError?) -> Void

    /// Closure that captures logic on how to validate an http response sent back from a server.
  public typealias ValidationHandler = (response: NSURLResponse, data: NSData?, error: NSErrorPointer) -> Bool

    /// The session to use when making requests.
  var session: NSURLSession

    /// The default body parser to use when sending requests.
  var defaultBodyParser: BodyParseable = BodyParser()

    /// The default chain of response parsers to use when parsing an http response body.
  var defaultResponseParsers: [ResponseParseable] = []

    /// The closure to use when validating http response bodies.
  var validationHandler: ValidationHandler = { response, data, error in
    return true
  }

  /**
   This is the default initializer for BaseTask. It defaults to using a session created from the standard shared session configuration.

   - parameter session: NSURLSession to use when making requests. Defaults to using a session created from the standard shared session configuration.

   - returns: An instance of BaseTask.
   */
  public init(session: NSURLSession = NSURLSession(configuration: NSURLSession.sharedSession().configuration)) {
    self.session = session
  }

  /**
   This is the workhorse method that creates new instances of NSURLSessionDataTask created based on the parameters passed in.

   - parameter url:             URL that you are sending your requests to.
   - parameter bodyDictionary:  Dictionary representing the data send in the http request body.
   - parameter httpMethod:      HTTP method to use when making the request.
   - parameter httpHeaders:     HTTP headers to use when making the request.
   - parameter bodyParser:      Body parser to use when parsing the bodyDictionary.
   - parameter responseParsers: Chain of response parsers to use when parsing an http response body.
   - parameter dispatchQueue:   Dispatch queue to run the completion handler on.
   - parameter completion:      Closure that captures logic to execute after completion of the request/response cycle.

   - returns: Returns a ready to go NSURLSessionDataTask configured based on the parameters passed in. Calling resume on it starts your request.
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
      var internalError: NSError? = error

      if let response = response, data = data {
        if internalError == nil {
          let isValidated = self.validationHandler(response: response, data: data, error: &internalError)

          if internalError == nil && isValidated {
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