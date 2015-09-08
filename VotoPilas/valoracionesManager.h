//
//  valoracionesManager.h
//  VotoPilas
//
//  Created by Jose on 7/17/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface valoracionesManager : NSObject

typedef void(^myCompletion)(NSMutableArray *);

+(void )downloadUsers:(myCompletion) compblock;


@end
