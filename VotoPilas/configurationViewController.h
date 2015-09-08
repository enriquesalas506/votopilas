//
//  configurationViewController.h
//  VotoPilas
//
//  Created by Jose on 6/23/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface configurationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>



@property (strong,nonatomic) NSMutableArray * sourcesList;

@end
