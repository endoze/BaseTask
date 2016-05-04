//
//  JSONKeyResponseParser.swift
//  BaseTask
//
//  Created by Endoze on 4/28/16.
//  Copyright © 2016 Chris Stephan. All rights reserved.
//

import Quick
import Nimble

import BaseTask

class JSONKeyResponseParserSpecs: QuickSpec {
  override func spec() {
    describe("JSONKeyResponseParser") {
      describe("parsedObject") {
        context("when data is nil") {
          it("returns nil") {
            let parser = JSONKeyResponseParser(responseKey: "test")
            let value = parser.parsedObject(nil)

            expect(value).to(beNil())
          }
        }

        context("when data is not nil") {
          it("returns a value for the given response key") {
            let parser = JSONKeyResponseParser(responseKey: "test")
            let wooo: [NSString: NSString] = ["wooooo": "hooo"]
            let dictionary: [NSString: [NSString: NSString]] = ["test": wooo]
            let value = parser.parsedObject(dictionary) as! [NSString: NSString]

            expect(value).to(equal(wooo))
          }
        }
      }
    }
  }
}