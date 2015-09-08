//
//  politicianManager.h
//  VotoPilas
//
//  Created by Jose on 7/10/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface politicianManager : NSObject

typedef void(^myCompletion)(NSMutableArray *);

+(void )downloadPoliticians:(NSMutableArray *)partidosArray :(myCompletion) compblock;

+(void )downloadPoliticians:(NSMutableArray *)partidosArray :(NSString *)list :(myCompletion) compblock;

+(void )downloadPoliticiansInParts:(NSMutableArray *)partidosArray;

+(void )downloadPoliticiansAllParts:(NSMutableArray *)partidosArray;


@end
