//
//  PartidosModel.h
//  VotoPilas
//
//  Created by Jose on 7/10/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PartidosModel : NSObject



@property (strong,nonatomic) NSString * address;
@property (strong,nonatomic) NSString * partido_description;
@property (strong,nonatomic) NSNumber * foundation;
@property (strong,nonatomic) PFFile * image;
@property (strong,nonatomic) NSNumber * number_of_offices;
@property (strong,nonatomic) NSString * phone;
@property (strong,nonatomic) NSString * shortname;
@property (strong,nonatomic) NSString * facebook;
@property (strong,nonatomic) NSString * president_name;
@property (strong,nonatomic) NSString * twitter;
@property (strong,nonatomic) NSString * website;



@property (strong,nonatomic) NSString * name;
@property (strong,nonatomic) NSString * acronym;
@property (strong,nonatomic) NSString * partidoID;

@end
