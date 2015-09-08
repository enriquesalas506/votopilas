//
//  itemsOfPartido.m
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "itemsOfPartido.h"
#import "politicalExperienceModel.h"
#import "laboralExperienceModel.h"

@implementation itemsOfPartido

-(void)updateExperienciaPolitica:(PFRelation *)objectRelation{
    
    _experienciaPolitica = [[NSMutableArray alloc]init];
    
    PFQuery *query1 = [objectRelation query];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        
        for (int rr = 0; rr < results.count; rr++){
            
            PFObject * object= results[rr];
            
            politicalExperienceModel * model = [[politicalExperienceModel alloc]init];
            model.puesto = [object valueForKey:@"charge"];
            model.startDate = [object valueForKey:@"year_start"];
            model.endDate = [object valueForKey:@"year_end"];
            model.job_description = [object objectForKey:@"description"];
            
            [_experienciaPolitica addObject:model];
            
        }
        
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"endDate"
                                                     ascending:false];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray;
        sortedArray = [_experienciaPolitica sortedArrayUsingDescriptors:sortDescriptors];
        
        _experienciaPolitica = [NSMutableArray arrayWithArray:sortedArray];
        
        
        
        // _experienciaPolitica = [results valueForKey:@"charge"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // update some UI
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"refreshLayoutNotification"
             object:nil];// refresca los listados
            
        });
        

    }];
    
        
       // NSLog(@"EXPERIENCIA POLITICA %@",[results valueForKey:@"charge"]);
        
        
}

-(void)updateExperienciaLaboral:(PFRelation *)objectRelation{
    
    _experienciaLaboral = [[NSMutableArray alloc]init];

    
    PFQuery *query1 = [objectRelation query];
      [query1 findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        for (int rr = 0; rr < results.count; rr++){
            
            PFObject * object= results[rr];
            
            laboralExperienceModel * model = [[laboralExperienceModel alloc]init];
            model.puesto = [object valueForKey:@"charge"];
            model.startDate = [object valueForKey:@"year_start"];
            model.endDate = [object valueForKey:@"year_end"];
            model.job_description = [object objectForKey:@"description"];
            model.place = [object objectForKey:@"place"];
            
            
            [_experienciaLaboral addObject:model];
            
        }
        
        
          
          
          NSSortDescriptor *sortDescriptor;
          sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"endDate"
                                                       ascending:false];
          NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
          NSArray *sortedArray;
          sortedArray = [_experienciaLaboral sortedArrayUsingDescriptors:sortDescriptors];
          
          _experienciaLaboral = [NSMutableArray arrayWithArray:sortedArray];
          

        // _experienciaPolitica = [results valueForKey:@"charge"];
        
          dispatch_async(dispatch_get_main_queue(), ^{
              // update some UI
              [[NSNotificationCenter defaultCenter]
               postNotificationName:@"refreshLayoutNotification"
               object:nil];// refresca los listados

          });
        
        
      
      
      }];
    
        
        
    
    

    
}

-(void)updateEducacion:(PFRelation *)objectRelation{
    
    _educacion = [[NSMutableArray alloc]init];
    
    
    PFQuery *query1 = [objectRelation query];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        for (int rr = 0; rr < results.count; rr++){
            
            PFObject * object= results[rr];
            
            laboralExperienceModel * model = [[laboralExperienceModel alloc]init];
            model.puesto = [object valueForKey:@"title"];
            model.startDate = [object valueForKey:@"year_start"];
            model.endDate = [object valueForKey:@"year_end"];
            model.job_description = [object objectForKey:@"description"];
            model.place = [object objectForKey:@"place"];
            
            
            [_educacion addObject:model];
            
        }
        
        
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"endDate"
                                                     ascending:false];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray;
        sortedArray = [_educacion sortedArrayUsingDescriptors:sortDescriptors];
        
        _educacion = [NSMutableArray arrayWithArray:sortedArray];

        
       
        dispatch_async(dispatch_get_main_queue(), ^{
            // update some UI
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"refreshLayoutNotification"
             object:nil];// refresca los listados
            
        });
    
    
    
    }];
    
    
    
    
    
    
}

-(void)updateListado:(PFRelation *)objectRelation{
    
    NSLog(@"LISTADO !!");
    
    PFQuery *query1 = [objectRelation query];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        
        
        //  NSLog(@"EXPERIENCIA POLITICA %@",[results valueForKey:@"charge"]);
        
        
        
       // _listado = [results valueForKey:@"list"];
        
        
    }];
    
}



@end
