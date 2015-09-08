//
//  customSourceTableViewCell.h
//  VotoPilas
//
//  Created by Jose on 6/23/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customSourceTableViewCell : UITableViewCell


@property (strong,nonatomic) NSString * title;
@property BOOL isSelected;
-(void)checkSelection:(BOOL)selection;



@end
