//
//  ReactNativeHelper.m
//  CBDMobile
//
//  Created by andyli2 on 2020/1/15.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ReactNativeHelper.h"
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>

@implementation ReactNativeHelper

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(ReactNativeHelper);

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

RCT_EXPORT_METHOD(
  sayHello:(nonnull NSNumber *)reactTag // Component 对象的 reactTag
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


RCT_EXPORT_METHOD(
  presentScreen:(nonnull NSNumber *)reactTag
 screen:(NSString *)screenName)
{
     [self navigateToScreen:NO reactTag:reactTag screen:screenName];
}

RCT_EXPORT_METHOD(
  pushScreen:(nonnull NSNumber *)reactTag
 screen:(NSString *)screenName)
{
    [self navigateToScreen:YES reactTag:reactTag screen:screenName];
}

- (void) navigateToScreen:(BOOL)push
                 reactTag:(nonnull NSNumber *)reactTag // Component 对象的 reactTag
                   screen:(NSString *)screenName
{
  NSLog(@"Screen:%@",screenName);
  RCTUIManager *uiManager = _bridge.uiManager;
  dispatch_queue_t methodQueue = uiManager.methodQueue;
  if (methodQueue == nil) {
    methodQueue = uiManager.methodQueue;
  }
  dispatch_async(methodQueue, ^{
    [uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *view = viewRegistry[reactTag];
            UIViewController *viewController = (UIViewController *)view.reactViewController;
            // It's now ok to do something with the viewController
                 // which is in charge of the component.
                   UIViewController *destVC =
                   [[UIStoryboard storyboardWithName:@"Main"
                                              bundle:NULL] instantiateViewControllerWithIdentifier:screenName];
            if (push) {
                [viewController.navigationController pushViewController:destVC animated:YES];
            } else {
                [viewController presentViewController:destVC animated:YES completion:nil];
            }
        });
    }];
  });
}


@end
