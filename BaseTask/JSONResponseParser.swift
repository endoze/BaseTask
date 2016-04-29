//
//  JSONResponseParser.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//
//

import Foundation

/// This response parser is used to parse NSData from an http response body into JSON.
public class JSONResponseParser: NSObject, ResponseParseable {
  /**
   This method accepts NSData and returns a JSON dictionary or nil.

   - parameter data: A dictionary from another ResponseParseable.

   - returns: Returns an object or nil.
   */
  public func parsedObject(data: AnyObject?) -> AnyObject? {
    if let jsonData = data as? NSData, parsedObject = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) {
      return parsedObject
    } else {
      return nil
    }
  }
}
