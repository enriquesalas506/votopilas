//
//  infoSourceModel.m
//  VotoPilas
//
//  Created by Jose on 6/24/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "infoSourceModel.h"

@implementation infoSourceModel

- (id)init:(NSString *)title rate:(int)rating  {
    self = [super init];
    if (self) {
        
        _title = title;
        _rating = rating;
        
    }
    return self;
}



@end
