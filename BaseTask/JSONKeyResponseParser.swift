//
//  JSONKeyResponseParser.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//
//

import Foundation

/// <#Description#>
public class JSONKeyResponseParser: NSObject, ResponseParseable {
    /// <#Description#>
  var responseKey: String?

  /**
   <#Description#>

   - returns: <#return value description#>
   */
  override init() {
    self.responseKey = nil
  }

  /**
   <#Description#>

   - parameter responseKey: <#responseKey description#>

   - returns: <#return value description#>
   */
  init(responseKey: String) {
    self.responseKey = responseKey
  }

  /**
   <#Description#>

   - parameter jsonData: <#jsonData description#>

   - returns: <#return value description#>
   */
  public func parsedObject(jsonData: AnyObject?) -> AnyObject? {
    if let jsonData = jsonData as? [String: AnyObject], responseKey = responseKey {
      return jsonData[responseKey]
    } else {
      return nil
    }
  }
}
