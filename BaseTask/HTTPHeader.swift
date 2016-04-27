//
//  HTTPHeader.swift
//  BaseTask
//
//  Created by Endoze on 4/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

/// <#Description#>
public class HTTPHeader: NSObject {
  let key: String
  let value: String

  init(key: String, value: String) {
    self.key = key
    self.value = value
  }
}
