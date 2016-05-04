//
//  BaseTaskObjCSpecs.swift
//  BaseTask
//
//  Created by Endoze on 5/4/16.
//  Copyright © 2016 Chris Stephan. All rights reserved.
//

import Quick
import Nimble

import BaseTask

class BaseTaskObjCSpecs: QuickSpec {
  override func spec() {
    describe("BaseTaskObjC") {
      describe("makeHTTPRequest") {
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/posts/1")!

        context("when httpHeaders are passed in") {
          it("sets headers on the returned NSURLRequest") {
            let headers = [HTTPHeader(key: "Accept", value: "application/json")]

            let expectedHeaders = ["Accept": "application/json"]
            let task = BaseTaskObjC().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: HTTPMethod.Get.rawValue,
              httpHeaders: headers,
              bodyParser: nil,
              responseParsers: nil,
              dispatchQueue: dispatch_get_main_queue(),
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.allHTTPHeaderFields).to(equal(expectedHeaders))
          }
        }

        context("when httpHeaders are not passed in") {
          it("does not set headers on the returns NSURLRequest") {
            let headers = [HTTPHeader]()
            let expectedHeaders = [String: String]()
            let task = BaseTaskObjC().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: HTTPMethod.Get.rawValue,
              httpHeaders: headers,
              bodyParser: nil,
              responseParsers: nil,
              dispatchQueue: dispatch_get_main_queue(),
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.allHTTPHeaderFields).to(equal(expectedHeaders))
          }
        }

        context("when bodyParser is passed in") {
          it("should use it to parse the body data") {
            var dictionary = ["blah": "yup"]
            let task = BaseTaskObjC().makeHTTPRequest(url,
              bodyDictionary: dictionary,
              httpMethod: HTTPMethod.Post.rawValue,
              httpHeaders: nil,
              bodyParser: FakeBodyParser(),
              responseParsers: nil,
              dispatchQueue: dispatch_get_main_queue(),
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
            let task = BaseTaskObjC().makeHTTPRequest(url,
              bodyDictionary: dictionary,
              httpMethod: HTTPMethod.Post.rawValue,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              dispatchQueue: dispatch_get_main_queue(),
              completion: { object, response, error in }
            )

            let expectedData = try? NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)

            expect(task.originalRequest!.HTTPBody).to(equal(expectedData))
          }
        }

        context("when httpMethod is GET") {
          it("should configure the request for a GET") {
            let task = BaseTaskObjC().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: HTTPMethod.Get.rawValue,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              dispatchQueue: dispatch_get_main_queue(),
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.HTTPMethod).to(equal("GET"))
          }
        }

        context("when httpMethod is PUT") {
          it("should configure the request for a PUT") {
            let task = BaseTaskObjC().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: HTTPMethod.Put.rawValue,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              dispatchQueue: dispatch_get_main_queue(),
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.HTTPMethod).to(equal("PUT"))
          }
        }

        context("when httpMethod is PATCH") {
          it("should configure the request for a PATCH") {
            let task = BaseTaskObjC().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: HTTPMethod.Patch.rawValue,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              dispatchQueue: dispatch_get_main_queue(),
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.HTTPMethod).to(equal("PATCH"))
          }
        }

        context("when httpMethod is DELETE") {
          it("should configure the request for a DELETE") {
            let task = BaseTaskObjC().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: HTTPMethod.Delete.rawValue,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              dispatchQueue: dispatch_get_main_queue(),
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.HTTPMethod).to(equal("DELETE"))
          }
        }

        context("when httpMethod is POST") {
          it("should configure the request for a POST") {
            let task = BaseTaskObjC().makeHTTPRequest(url,
              bodyDictionary: nil,
              httpMethod: HTTPMethod.Post.rawValue,
              httpHeaders: nil,
              bodyParser: nil,
              responseParsers: nil,
              dispatchQueue: dispatch_get_main_queue(),
              completion: { object, response, error in }
            )

            expect(task.originalRequest!.HTTPMethod).to(equal("POST"))
          }
        }
      }
    }
  }
}