//
//  BodyParserSpecs.swift
//  BaseTask
//
//  Created by Endoze on 4/29/16.
//  Copyright © 2016 Chris Stephan. All rights reserved.
//

import Quick
import Nimble

import BaseTask

class BodyParserSpecs: QuickSpec {
  override func spec() {
    describe("BodyParser") {
      describe("parsedBody") {
        context("when body is not nil") {
          it("should return data") {
            let parser = BodyParser()
            let value = parser.parsedBody(["blah": "blaaaah"])

            expect(value).toNot(beNil())
          }
        }

        context("when body is nil") {
          it("should return nil") {
            let parser = BodyParser()
            let value = parser.parsedBody(nil)

            expect(value).to(beNil())
          }
        }
      }
    }
  }
}