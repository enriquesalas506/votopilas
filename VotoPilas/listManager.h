//
//  listManager.h
//  VotoPilas
//
//  Created by Jose on 7/14/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface listManager : NSObject

typedef void(^myCompletion)(NSMutableArray *);

+(void )downloadListados:(myCompletion) compblock;


@end
