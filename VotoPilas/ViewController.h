//
//  ViewController.h
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSMutableArray * hideName;
@property (strong,nonatomic) NSMutableArray * hideList;


-(void)updateTabWhenScroll:(int) page;
@end

