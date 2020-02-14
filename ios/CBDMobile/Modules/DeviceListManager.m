//
//  DeviceListManager.m
//  CBDMobile
//
//  Created by Fei Song on 2020/2/14.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "DeviceListManager.h"
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>

@implementation DeviceListManager

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(DeviceListManager);

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

RCT_EXPORT_METHOD(
  popMessage:(nonnull NSNumber *)reactTag
 greetings:(NSString *)greetings
  resolver:(RCTPromiseResolveBlock)resolve
  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSLog(@"Greetings:%@",greetings);
  RCTUIManager *uiManager = _bridge.uiManager;
  dispatch_async(uiManager.methodQueue, ^{
    [uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *view = viewRegistry[reactTag];
            UIViewController *viewController = (UIViewController *)view.reactViewController;
            // It's now ok to do something with the viewController
            // which is in charge of the component.
              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message from JS" message:greetings preferredStyle:UIAlertControllerStyleAlert];
              UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  
              }];
              [alertController addAction:action];
              [viewController presentViewController:alertController animated:YES completion:nil];

        });
    }];
  });
    
  resolve(nil);
}

@end
