//
//  BodyParser.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

/// <#Description#>
class BodyParser: NSObject, BodyParseable {
  /**
   <#Description#>

   - parameter bodyDictionary: <#bodyDictionary description#>

   - returns: <#return value description#>
   */
  func parsedBody(bodyDictionary: [String : AnyObject]?) -> NSData? {
    if let bodyDictionary = bodyDictionary, bodyData = try? NSJSONSerialization.dataWithJSONObject(bodyDictionary, options: .PrettyPrinted) {
      return bodyData
    } else {
      return nil
    }
  }
}
