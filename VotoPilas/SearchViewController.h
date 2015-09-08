//
//  SearchViewController.h
//  VotoPilas
//
//  Created by Jose on 7/27/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSMutableArray * searchArray;

-(void)refreshSearch;

@end
