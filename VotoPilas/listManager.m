//
//  listManager.m
//  VotoPilas
//
//  Created by Jose on 7/14/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "listManager.h"

@implementation listManager

+(void )downloadListados:(myCompletion) compblock
{
    
    //  NSLog(@"DOWNLOADING PARTIDOS LIST");
    
    NSMutableArray * objectsArray =[[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"List"];
    [query orderByAscending:@"createdAt"];
    // [query selectKeys:@[@"name"]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * objectsInArray, NSError *error) {
        if (!error) {
            
            
            
            for (PFObject *object in objectsInArray) {
                
                
                NSString * listName = [object objectForKey:@"name"];
                

                
                [objectsArray addObject:listName];
                
            }
            
            compblock(objectsArray);
            // NSLog(@"Array %@",objectsInArray);
            
            
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
    
}
@end
