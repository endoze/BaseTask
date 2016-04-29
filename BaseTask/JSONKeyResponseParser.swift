//
//  JSONKeyResponseParser.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//
//

import Foundation

/// This response parser is used to pull values from a JSON dictionary for a given key.
public class JSONKeyResponseParser: NSObject, ResponseParseable {
    /// Key to use when returning values from a dictionary.
  var responseKey: String

  /**
   Default constructor for creating a new JSONKeyResponseParser.

   - parameter responseKey: Key to use when returning values from a dictionary.

   - returns: A new instance of JSONKeyResponseParser.
   */
  public init(responseKey: String) {
    self.responseKey = responseKey
  }

  /**
   This method accepts a dictionary and returns the value for the given responseKey or nil.

   - parameter data: A dictionary from another ResponseParseable.

   - returns: Returns an object or nil.
   */
  public func parsedObject(data: AnyObject?) -> AnyObject? {
    if let data = data as? [String: AnyObject] {
      return data[responseKey]
    } else {
      return nil
    }
  }
}
