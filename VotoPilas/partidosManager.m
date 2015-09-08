//
//  partidos.m
//  VotoPilas
//
//  Created by Jose on 7/9/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "partidosManager.h"
#import "PartidosModel.h"

@implementation partidosManager


+(void )downloadPartidosList:(myCompletion) compblock
{
    
  //  NSLog(@"DOWNLOADING PARTIDOS LIST");
    
    NSMutableArray * objectsArray =[[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Party"];
    // [query selectKeys:@[@"name"]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * objectsInArray, NSError *error) {
        if (!error) {
            
            
            
            
            for (PFObject *object in objectsInArray) {
                

                PartidosModel * model = [[PartidosModel alloc]init];
                
                
                model.address = [object objectForKey:@"address"];
                model.partido_description = [object objectForKey:@"description"];
                
                
                model.foundation = [object objectForKey:@"foundation"];
                model.image = [object objectForKey:@"image"];
                model.name = [object objectForKey:@"name"];
                
                model.number_of_offices = [object objectForKey:@"number_of_offices"];
                model.phone = [object objectForKey:@"phone"];
                model.shortname = [object objectForKey:@"shortname"];
                model.facebook = [object objectForKey:@"facebook"];
                model.president_name = [object objectForKey:@"president_name"];
                model.twitter = [object objectForKey:@"twitter"];
                model.website = [object objectForKey:@"website"];
                
                
                
                
                
                
                
                
                
                model.acronym = [object objectForKey:@"shortname"];
                model.partidoID = [object objectId];
                
                [objectsArray addObject:model];
                
            }
            
            compblock(objectsArray);
           // NSLog(@"Array %@",objectsInArray);
            
            
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            compblock(objectsArray);
        }
    }];
    
    
    
    
}

@end
