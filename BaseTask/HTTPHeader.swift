//
//  HTTPHeader.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

/// This class is used to represent an HTTP header name and value.
public class HTTPHeader: NSObject {
    /// HTTP header name.
  public let key: String

    /// HTTP header value.
  public let value: String

  /**
   Default constructor for creating a new HTTPHeader.

   - parameter key:   HTTP header name.
   - parameter value: HTTP header value.

   - returns: An instance of the HTTPHeader class.
   */
  public init(key: String, value: String) {
    self.key = key
    self.value = value
  }
}
