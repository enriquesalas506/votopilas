//
//  recomendacionCellTableViewCell.h
//  VotoPilas
//
//  Created by Jose on 6/24/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recomendacionCellTableViewCell : UITableViewCell

@property BOOL direction;

@property (strong,nonatomic) NSString * Title;
@property (strong,nonatomic) NSString * message;
@property (strong,nonatomic) NSString * fbId;


@property int rating;

@end
