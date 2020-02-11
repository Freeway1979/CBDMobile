//
//  NativeHelper.swift
//  CBDMobile
//
//  Created by andyli2 on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

@objc(NativeHelper)
class NativeHelper: NSObject {
   @objc(sayHello:)
   func sayHello(greetings: String) {
      print("\(greetings) from JS")
    

   }
}
