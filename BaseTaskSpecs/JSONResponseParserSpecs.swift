//
//  JSONResponseParserSpecs.swift
//  BaseTask
//
//  Created by Endoze on 4/28/16.
//  Copyright © 2016 Chris Stephan. All rights reserved.
//

import Quick
import Nimble

import BaseTask

class JSONResponseParserSpecs: QuickSpec {
  override func spec() {
    describe("JSONResponseParser") {
      describe("parsedObject") {
        context("when data is nil") {
          it("returns nil") {
            let parser = JSONResponseParser()
            let value = parser.parsedObject(nil)

            expect(value).to(beNil())
          }
        }

        context("when data is not nil") {
          it("returns a dictionary from the NSData") {
            let parser = JSONResponseParser()
            let dictionary = ["woooo": "hoooo"]
            let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
            let value = parser.parsedObject(data) as! [String: String]

            expect(value).to(equal(dictionary))
          }
        }
      }
    }
  }
}