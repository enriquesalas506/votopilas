//
//  listPosition.h
//  VotoPilas
//
//  Created by Jose on 6/30/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listPosition : NSObject

@property (strong,nonatomic) NSString * id;
@property (strong,nonatomic) NSString * charge;
@property (strong,nonatomic) NSString * politician;
@property  int position;
@property (strong,nonatomic) NSMutableArray * list;




@end
