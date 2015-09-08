//
//  politicaTableViewCell.h
//  VotoPilas
//
//  Created by Jose on 6/24/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface politicaTableViewCell : UITableViewCell

@property (strong,nonatomic) NSString * title;

@property (strong,nonatomic) NSString * job_description;



@property (strong,nonatomic) NSDate * beginDate;
@property (strong,nonatomic) NSDate * endDate;


@end
