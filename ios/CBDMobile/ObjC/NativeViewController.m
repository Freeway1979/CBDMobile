//
//  RNViewController.m
//  CBDMobile
//
//  Created by andyli2 on 2020/1/14.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <React/RCTBridge.h>
#import "NativeViewController.h"
#import <React/RCTUIManager.h>

@interface NativeViewController ()

@end


@implementation NativeViewController

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(NativeViewController);

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

// Component 对象的 reactTag
RCT_EXPORT_METHOD(
  sayHello:(nonnull NSNumber *)reactTag
 greetings:(NSString *)greetings
  resolver:(RCTPromiseResolveBlock)resolve
  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSLog(@"Greetings:%@",greetings);
  RCTUIManager *uiManager = _bridge.uiManager;
  dispatch_async(uiManager.methodQueue, ^{
    [uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,UIView *> *viewRegistry) {
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
    }];
  });
}

//RCT_EXPORT_METHOD(sayHello:(NSString *)greetings) {
//    NSLog(@"Greetings:%@",greetings);
//     
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
////        id rootViewController = UIApplication.sharedApplication.windows.firstObject.rootViewController;
////
////        if([rootViewController isKindOfClass:[UINavigationController class]])
////        {
////            rootViewController = ((UINavigationController *)rootViewController).viewControllers.firstObject;
////        }
////        if([rootViewController isKindOfClass:[UITabBarController class]])
////        {
////            rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
////        }
////        //...
////        [rootViewController presentViewController:alertController animated:YES completion:nil];
//
//        UIViewController *rootVC = ViewController.
//        [self presentViewController:alertController animated:YES completion:nil];
//    });
//}

@end
