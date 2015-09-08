//
//  partidos.h
//  VotoPilas
//
//  Created by Jose on 7/9/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface partidosManager : NSObject

typedef void(^myCompletion)(NSMutableArray *);

+(void )downloadPartidosList:(myCompletion) compblock;


@end
