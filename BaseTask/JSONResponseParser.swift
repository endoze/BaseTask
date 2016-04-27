//
//  JSONResponseParser.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//
//

import Foundation

/// <#Description#>
public class JSONResponseParser: NSObject, ResponseParseable {
  /**
   <#Description#>

   - parameter jsonData: <#jsonData description#>

   - returns: <#return value description#>
   */
  public func parsedObject(jsonData: AnyObject?) -> AnyObject? {
    if let jsonData = jsonData as? NSData, parsedObject = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) {
      return parsedObject
    } else {
      return nil
    }
  }
}
