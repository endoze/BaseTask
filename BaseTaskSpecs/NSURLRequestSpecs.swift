//
//  NSURLRequestSpecs.swift
//  BaseTask
//
//  Created by Endoze on 4/29/16.
//  Copyright © 2016 Chris Stephan. All rights reserved.
//

import Quick
import Nimble

@testable import BaseTask

class NSURLRequestSpecs: QuickSpec {
  override func spec() {
    describe("NSURLRequest") {
      describe("getRequest") {
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/posts/1")!

        it("returns a get request") {
          let request = NSURLRequest.getRequest(url, headers: [HTTPHeader]())

          expect(request.HTTPMethod).to(equal(NSURLRequest.HTTPMethod.GET.rawValue))
        }

        it("configures the correct url") {
          let request = NSURLRequest.getRequest(url, headers: [HTTPHeader]())

          expect(request.URL).to(equal(url))
        }
      }

      describe("deleteRequest") {
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/posts/1")!

        it("returns a delete request") {
          let request = NSURLRequest.deleteRequest(url, headers: [HTTPHeader]())

          expect(request.HTTPMethod).to(equal(NSURLRequest.HTTPMethod.DELETE.rawValue))
        }

        it("configures the correct url") {
          let request = NSURLRequest.deleteRequest(url, headers: [HTTPHeader]())

          expect(request.URL).to(equal(url))
        }
      }
      
      describe("postRequest") {
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/posts/1")!

        it("returns a post request") {
          let request = NSURLRequest.postRequest(url, body: nil, headers: [HTTPHeader]())

          expect(request.HTTPMethod).to(equal(NSURLRequest.HTTPMethod.POST.rawValue))
        }

        it("configures the correct url") {
          let request = NSURLRequest.postRequest(url, body: nil, headers: [HTTPHeader]())

          expect(request.URL).to(equal(url))
        }
      }
      
      describe("patchRequest") {
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/posts/1")!

        it("returns a patch request") {
          let request = NSURLRequest.patchRequest(url, body: nil, headers: [HTTPHeader]())

          expect(request.HTTPMethod).to(equal(NSURLRequest.HTTPMethod.PATCH.rawValue))
        }

        it("configures the correct url") {
          let request = NSURLRequest.patchRequest(url, body: nil, headers: [HTTPHeader]())

          expect(request.URL).to(equal(url))
        }
      }
      
      describe("putRequest") {
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/posts/1")!

        it("returns a put request") {
          let request = NSURLRequest.putRequest(url, body: nil, headers: [HTTPHeader]())

          expect(request.HTTPMethod).to(equal(NSURLRequest.HTTPMethod.PUT.rawValue))
        }

        it("configures the correct url") {
          let request = NSURLRequest.putRequest(url, body: nil, headers: [HTTPHeader]())

          expect(request.URL).to(equal(url))
        }
      }
    }
  }
}