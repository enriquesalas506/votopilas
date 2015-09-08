//
//  itemsOfPartido.h
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface itemsOfPartido : NSObject




//------------------------------RELATIONS


@property (strong,nonatomic) PFRelation * laboralRelation;
@property (strong,nonatomic) PFRelation * educationRelation;
@property (strong,nonatomic) PFRelation * politicalRelation;


//------------------------------RELATIONS


@property (strong,nonatomic) PFObject * politicianObject;

@property (strong,nonatomic) NSString * nombre;
@property (strong,nonatomic) NSString * imagen;
@property  int  rating;


@property (strong,nonatomic) NSString * partido;
@property (strong,nonatomic) NSString * profesion;

@property (strong,nonatomic) NSMutableArray * experienciaPolitica;
@property (strong,nonatomic) NSMutableArray * experienciaLaboral;
@property (strong,nonatomic) NSMutableArray * educacion;
@property (strong,nonatomic) NSMutableArray * recomendaciones;
@property (strong,nonatomic) NSMutableArray * comentarios;


//--------recomendaciones
@property (strong,nonatomic) NSMutableArray * recomendacionesVIP;
@property (strong,nonatomic) NSMutableArray * recomendacionesNOVIP;
//--------recomendaciones



@property (strong,nonatomic) NSString * cargo;
@property (strong,nonatomic) NSString * listado;






@property int posicionListado ;
@property (strong,nonatomic) NSNumber * posicionKey ;

@property int edad ;


@property NSDate * fechaDeNaciomiento;



//------------------------------UPDATE FUNCTIONS

-(void)updateExperienciaLaboral:(PFRelation *)objectRelation;
-(void)updateExperienciaPolitica:(PFRelation *)objectRelation;
-(void)updateEducacion:(PFRelation *)objectRelation;
-(void)updateListado:(PFRelation *)objectRelation;

@end
