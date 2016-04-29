//
//  BodyParser.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

/// Basic implementation of BodyParseable that uses NSJSONSerialization to parse the dictionary into NSData.
class BodyParser: NSObject, BodyParseable {
  /**
   This method accepts a dictionary and returns NSData or nil. The return of this method is used as the http requests body.

   - parameter bodyDictionary: Dictionary containing values being sent in the body of an http request.
   
   - returns: NSData or nil.
   */
  func parsedBody(bodyDictionary: [String : AnyObject]?) -> NSData? {
    if let bodyDictionary = bodyDictionary, bodyData = try? NSJSONSerialization.dataWithJSONObject(bodyDictionary, options: .PrettyPrinted) {
      return bodyData
    } else {
      return nil
    }
  }
}
