//
//  CustomMiembroCell.h
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "itemsOfPartido.h"
#import "infoSourceModel.h"

@interface CustomMiembroCell : UITableViewCell


@property (strong,nonatomic) NSString * urlImage;
@property (strong,nonatomic) NSString * Title;
@property (strong,nonatomic) itemsOfPartido * item;
@property int rating;
@property int listPosition;


@property int indexTab;


@property int currentTab;



- (void)configCell;
@end
