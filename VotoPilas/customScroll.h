//
//  customScroll.h
//  VotoPilas
//
//  Created by Jose on 7/3/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface customScroll : UIScrollView <UIScrollViewDelegate>


@property (strong,nonatomic) ViewController * controller;

-(void)moveToScroll:(int)item;

@end
