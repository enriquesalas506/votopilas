//
//  AppDelegate.h
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
#import <Chartboost/Chartboost.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, ChartboostDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

