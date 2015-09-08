//
//  reviewViewController.h
//  VotoPilas
//
//  Created by Jose on 7/23/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface reviewViewController : UIViewController <UITextViewDelegate,UIAlertViewDelegate>

@property (strong,nonatomic) PFObject * politicalObject;

@end
