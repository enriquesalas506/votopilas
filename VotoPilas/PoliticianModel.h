//
//  PoliticianModel.h
//  VotoPilas
//
//  Created by Jose on 7/10/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PoliticianModel : NSObject



@property (strong,nonatomic) NSString * objectId;
@property (strong,nonatomic) NSDate * birthday;
@property (strong,nonatomic) NSString *  obj_description;
@property (strong,nonatomic) PFObject * charge;
@property (strong,nonatomic) PFRelation * education;//relational
@property (strong,nonatomic) PFFile * image;
@property (strong,nonatomic) PFRelation * laboral_experience;//relational
@property (strong,nonatomic) NSString * lastname;
@property (strong,nonatomic) PFObject * list_position;//relational
@property (strong,nonatomic) NSString * name;
@property (strong,nonatomic) PFObject * party;//relational
@property (strong,nonatomic) PFRelation * political_experience;//relational














@end

