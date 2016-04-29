//
//  BaseTaskSpecs.swift
//  BaseTaskSpecs
//
//  Created by Endoze on 4/27/16.
//  Copyright © 2016 Chris Stephan. All rights reserved.
//

import Quick
import Nimble

import Foundation
import BaseTask

class FakeBodyParser: NSObject, BodyParseable {
  func parsedBody(bodyDictionary: [String : AnyObject]?) -> NSData? {
    if bodyDictionary != nil {
      var newDictionary = bodyDictionary!
      newDictionary["testing"] = "yes"

      return try? NSJSONSerialization.dataWithJSONObject(newDictionary, options: .PrettyPrinted)
    }

    return nil
  }
}

class FakeResponseParser: NSObject, ResponseParseable {
  func parsedObject(data: AnyObject?) -> AnyObject? {
    var objectToReturn: [String: AnyObject]
    if let data = data as? NSData, parsedObject = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) {
      objectToReturn = parsedObject as! [String : AnyObject]
      objectToReturn["testing"] = "yes"
      return parsedObject
    } else {
      return nil
    }
  }
}

class BaseTaskSpecs: QuickSpec {
  override func spec() {
    describe("BaseTask") {
      describe("makeHTTPRequest") {
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/posts/1")!

        context("when httpHeaders are passed in") {
          it("sets headers on the returned NSURLRequest") {
            let headers = [HTTPHeader(key: "Accept", value: "application/json")]

            let expectedHeaders = ["Accept": "application/json"]
            let task = BaseTask().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: .Get,
              httpHeaders: headers,
              bodyParser: nil,
              responseParsers: nil,
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.allHTTPHeaderFields).to(equal(expectedHeaders))
          }
        }

        context("when httpHeaders are not passed in") {
          it("does not set headers on the returns NSURLRequest") {
            let headers = [HTTPHeader]()
            let expectedHeaders = [String: String]()
            let task = BaseTask().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: .Get,
              httpHeaders: headers,
              bodyParser: nil,
              responseParsers: nil,
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.allHTTPHeaderFields).to(equal(expectedHeaders))
          }
        }

        context("when bodyParser is passed in") {
          it("should use it to parse the body data") {
            var dictionary = ["blah": "yup"]
            let task = BaseTask().makeHTTPRequest(url,
              bodyDictionary: dictionary,
              httpMethod: .Post,
              httpHeaders: nil,
              bodyParser: FakeBodyParser(),
              responseParsers: nil,
              completion: { object, response, error in }
            )

            dictionary["testing"] = "yes"
            let expectedData = try? NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)

            expect(task.originalRequest!.HTTPBody).to(equal(expectedData))
          }
        }

        context("when bodyParser is not passed in") {
          it("should use the default body parser") {
            let dictionary = ["blah": "yup"]
            let task = BaseTask().makeHTTPRequest(url,
              bodyDictionary: dictionary,
              httpMethod: .Post,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              completion: { object, response, error in }
            )

            let expectedData = try? NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)

            expect(task.originalRequest!.HTTPBody).to(equal(expectedData))
          }
        }

        context("when httpMethod is GET") {
          it("should configure the request for a GET") {
            let task = BaseTask().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: .Get,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.HTTPMethod).to(equal("GET"))
          }
        }

        context("when httpMethod is PUT") {
          it("should configure the request for a PUT") {
            let task = BaseTask().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: .Put,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.HTTPMethod).to(equal("PUT"))
          }
        }

        context("when httpMethod is PATCH") {
          it("should configure the request for a PATCH") {
            let task = BaseTask().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: .Patch,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.HTTPMethod).to(equal("PATCH"))
          }
        }

        context("when httpMethod is DELETE") {
          it("should configure the request for a DELETE") {
            let task = BaseTask().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: .Delete,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.HTTPMethod).to(equal("DELETE"))
          }
        }

        context("when httpMethod is POST") {
          it("should configure the request for a POST") {
            let task = BaseTask().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: .Post,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.HTTPMethod).to(equal("POST"))
          }
        }
      }
    }
  }
}