//
//  valoracionesManager.m
//  VotoPilas
//
//  Created by Jose on 7/17/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "valoracionesManager.h"

@implementation valoracionesManager

+(void )downloadUsers:(myCompletion) compblock
{
    
    //  NSLog(@"DOWNLOADING PARTIDOS LIST");
    
      
    [PFCloud callFunctionInBackground:@"getVIPUsers" withParameters:@{}
                                block:^(NSArray *users, NSError *error) { 
                                    if (!error) 
                                    {
                                        
                                       // NSLog(@"USERS %@",users)
                                        
                                        compblock(users);
                                        
                                    } }];
    
    
    
    
    /*
    [query findObjectsInBackgroundWithBlock:^(NSArray * objectsInArray, NSError *error) {
        if (!error) {
            
            
            NSLog(@"USERS %@",objectsArray);
            
            for (PFObject *object in objectsInArray) {
                
                
                
            }
            
            compblock(objectsArray);
            // NSLog(@"Array %@",objectsInArray);
            
            
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            compblock(objectsArray);
        }
    }];*/
    
    
    
    
}
@end
