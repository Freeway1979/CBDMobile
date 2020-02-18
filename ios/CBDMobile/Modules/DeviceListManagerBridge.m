//
//  DeviceListManagerBridge.m
//  CBDMobile
//
//  Created by Fei Song on 2020/2/14.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>

@interface RCT_EXTERN_MODULE(DeviceListManager, NSObject)

RCT_EXTERN_METHOD(popMessage:(nonnull NSNumber *)reactTag message: (NSString *)message)
RCT_EXTERN_METHOD(refreshData)

@end
