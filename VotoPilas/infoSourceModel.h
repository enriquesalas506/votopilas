//
//  infoSourceModel.h
//  VotoPilas
//
//  Created by Jose on 6/24/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface infoSourceModel : NSObject

@property (strong,nonatomic) NSString * title;
@property (strong,nonatomic) NSString * message;

@property (strong,nonatomic) NSString * fbId;



@property (strong,nonatomic) NSNumber * isVip;



@property (strong,nonatomic) NSString * name;


@property  int rating;

- (id)init:(NSString *)title rate:(int)rating;
@end
