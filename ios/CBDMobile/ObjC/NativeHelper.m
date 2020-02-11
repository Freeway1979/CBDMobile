//
//  NativeHelper.m
//  CBDMobile
//
//  Created by andyli2 on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(NativeHelper, NSObject)

RCT_EXTERN_METHOD(sayHello:(NSString *)greetings)

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

@end
