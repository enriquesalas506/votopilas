//
//  politicianManager.m
//  VotoPilas
//
//  Created by Jose on 7/10/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "politicianManager.h"
#import "PartidosModel.h"
#import "PoliticianModel.h"
#import  "itemsOfPartido.h"
#import "infoSourceModel.h"
#import "politicalExperienceModel.h"


@interface NSUserDefaults (JRAdditions)
- (void)removeObjectsWithKeysMatchingPredicate:(NSPredicate *)predicate;
@end

@implementation NSUserDefaults (JRAdditions)

- (void)removeObjectsWithKeysMatchingPredicate:(NSPredicate *)predicate {
    NSArray *keys = [[self dictionaryRepresentation] allKeys];
    for(NSString *key in keys) {
        if([predicate evaluateWithObject:key]) {
            [self removeObjectForKey:key];
        }
    }
}

@end

@implementation politicianManager


+(void )downloadPoliticians:(NSMutableArray *)partidosArray :(myCompletion) compblock
{
    
    //--------NO QUITAR ESTO ESTO CACHEA LOS LISTADOS DE LOS USUARIOS
    
    PFQuery *listquery = [PFQuery queryWithClassName:@"List"];
    
    

    
    NSMutableArray * listadoDeListados = [listquery findObjects];
    
    
    //---Party
    
    PFQuery * partyQuery = [PFQuery queryWithClassName:@"Party"];
    NSArray * partyArray = [partyQuery findObjects];
    
    //---Charge
    
    PFQuery * chargeQuery = [PFQuery queryWithClassName:@"Charge"];
    NSArray * chargeArray = [chargeQuery findObjects];
   
    //------NO QUITAR ESTO CACHE LOS LISTADO DE LOS USUARIOS
 //   NSLog(@"LIST QUERY %@",listadoDeListados);

    
    
    NSMutableArray * partidosInfo =[[NSMutableArray alloc]init];
    
    
    NSArray * preArray;
    NSMutableArray * objectsInArray = [[NSMutableArray alloc]init];
    
    for (int ii =0; ii < 2; ii++){
    
    PFQuery *query = [PFQuery queryWithClassName:@"Politician"];
    
    [query setLimit: 1000];
    [query setSkip:ii * 1000];

    
    //[query includeKey:@"party"];
    //[query includeKey:@"charge"];
    [query includeKey:@"list_position"];
    //[query includeKey:@"links"];


    [query orderByAscending:@"createdAt"];

    
    preArray = [query findObjects];
        
     objectsInArray = [NSMutableArray arrayWithArray:   [objectsInArray arrayByAddingObjectsFromArray:preArray]];
    
    
    }
    
            

            
            

            
            for (int xx=0; xx < partidosArray.count; xx++) {
                
                
                
                PartidosModel * partido = partidosArray[xx];
                NSMutableArray * itemsInsidePartido =[[NSMutableArray alloc]init];
                
               // NSLog(@"PARTIDO %@",partido.partidoID);
                
                
                for (PFObject *object in objectsInArray) {
                    
                    
                    //--------------------------PFOBJECT
                    
                    
                    
                    
                    
                    //------------------------------------------------------
                    
                    
                    PoliticianModel * model = [[PoliticianModel alloc]init];
                   //----------------CASTING
                    
                    model.birthday = [object objectForKey:@"birthday"];
                    model.charge = [object objectForKey:@"charge"];
                    model.obj_description = [object objectForKey:@"description"];
                    //education
                    model.education = [object objectForKey:@"education"];
                    model.image = [object objectForKey:@"image"];
                    model.laboral_experience = [object objectForKey:@"laboral_experience"];
                    model.lastname = [object objectForKey:@"lastname"];
                    if ([object objectForKey:@"list_position"] != nil) {
                        model.list_position = [object objectForKey:@"list_position"];

                    }
                    model.name=  [object objectForKey:@"name"]; //nombre;
                    model.party=  [object objectForKey:@"party"]; //nombre;
                   // NSLog(@"party %@",model.party);
                    model.political_experience = [object relationForKey:@"political_experience"];
                    
                    
                    
                    if ([partido.partidoID isEqualToString:[model.party objectId]]){
                        
                        
                        itemsOfPartido * itemPolitico = [[itemsOfPartido alloc]init];
                        itemPolitico.politicianObject = object;
                        itemPolitico.nombre = [NSString stringWithFormat:@"%@ %@",model.name,model.lastname];
                        itemPolitico.imagen = model.image.url;
                        itemPolitico.partido = [model.party objectForKey:@"shortname"];
                        if (model.birthday != nil){
                        itemPolitico.edad = [self getBirthday:model.birthday];
                        }
                        itemPolitico.fechaDeNaciomiento = model.birthday;
                        itemPolitico.cargo = [model.charge objectForKey:@"name"];
                        
                        if ([[model.charge objectForKey:@"name"]  isEqual: @"Presidente"]|| [[model.charge objectForKey:@"name"]  isEqual: @"Presidente"]) {
                            itemPolitico.cargo = @"Presidencial";
                        }
                        
                        
                        //----------AGREGAR RELACIONES PARA DESCARGAR DESPUES
                        
                        itemPolitico.politicalRelation = model.political_experience;
                        itemPolitico.laboralRelation = model.laboral_experience;
                        itemPolitico.educationRelation = model.education;
                        
                        //----------AGREGAR RELACIONES PARA DESCARGAR DESPUES
                        
                       // [itemPolitico updateExperienciaPolitica:model.political_experience];
                       // [itemPolitico updateExperienciaLaboral:model.laboral_experience];
                       // [itemPolitico updateEducacion:model.education];
                        
                        
                        
                        if (model.list_position != nil){
                            
                        NSNumber * listNumber =[model.list_position valueForKey:@"position"];
                        itemPolitico.posicionListado = listNumber.intValue;
                        itemPolitico.posicionKey = listNumber;
                            
                            PFObject * listadoInsde = [model.list_position objectForKey:@"list"];

                            
                            
                            NSString * listadoPolitico = [listadoInsde valueForKey:@"name"];
                            
                           // NSLog(listadoPolitico);
                            
                           

                            
                            itemPolitico.listado = listadoPolitico;

                        }
                        

                        
                        //--------QUERY LIST NAME
                        
                        /*
                        
                        
                        */


                        
                        
                        
                        
                        
                        [itemsInsidePartido addObject:itemPolitico];
                    }
                    
                    
                   
 
                    }
                 
                
                

                    //--------------------------------------------------------------------
                
                    [partidosInfo addObject:itemsInsidePartido];
                
                
            }
        
        
        
    
           // NSLog(@"%@",partidosInfo);
    
            NSLog(@"FINISH JOB");
            compblock(partidosInfo);

            
            
            
    
    
    
    
    
}

+(void )downloadPoliticiansInParts:(NSMutableArray *)partidosArray
{
    
    //--------NO QUITAR ESTO ESTO CACHEA LOS LISTADOS DE LOS USUARIOS
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       
        
        PFQuery *listquery = [PFQuery queryWithClassName:@"List"];
        
        
        
        
        NSMutableArray * listadoDeListados = [listquery findObjects];
        
        
        //---Party
        
        PFQuery * partyQuery = [PFQuery queryWithClassName:@"Party"];
        NSArray * partyArray = [partyQuery findObjects];
        
        //---Charge
        
        PFQuery * chargeQuery = [PFQuery queryWithClassName:@"Charge"];
        NSArray * chargeArray = [chargeQuery findObjects];
        
        //------NO QUITAR ESTO CACHE LOS LISTADO DE LOS USUARIOS
        //   NSLog(@"LIST QUERY %@",listadoDeListados);
        
        
        
        
        
        NSArray * preArray;
        NSMutableArray * objectsInArray = [[NSMutableArray alloc]init];
        
        NSArray * lastDataToSend;
        
        
        
        
        for (int ii =0; ii < 3; ii++){
            
            
            NSMutableArray * partidosInfo =[[NSMutableArray alloc]init];

            
            PFQuery *query = [PFQuery queryWithClassName:@"Politician"];
            
            if (ii == 0){
            [query setLimit: 500];
            [query setSkip:ii * 500];
            }else{
            
            [query setLimit: 1000];
            [query setSkip: ((ii - 1) * 1000) + 500];
                
            }
            
            
            //[query includeKey:@"party"];
            //[query includeKey:@"charge"];
            [query includeKey:@"list_position"];
            //[query includeKey:@"links"];
            
            
            [query orderByAscending:@"createdAt"];
            
            
            preArray = [query findObjects];
            
            objectsInArray = [NSMutableArray arrayWithArray:   [objectsInArray arrayByAddingObjectsFromArray:preArray]];
            
            
            
            
            
            
            
            for (int xx=0; xx < partidosArray.count; xx++) {
                
                
                
                PartidosModel * partido = partidosArray[xx];
                NSMutableArray * itemsInsidePartido =[[NSMutableArray alloc]init];
                
                // NSLog(@"PARTIDO %@",partido.partidoID);
                
                
                for (PFObject *object in objectsInArray) {
                    
                    
                    //--------------------------PFOBJECT
                    
                    
                    
                    
                    
                    //------------------------------------------------------
                    
                    
                    PoliticianModel * model = [[PoliticianModel alloc]init];
                    //----------------CASTING
                    
                    model.birthday = [object objectForKey:@"birthday"];
                    model.charge = [object objectForKey:@"charge"];
                    model.obj_description = [object objectForKey:@"description"];
                    //education
                    model.education = [object objectForKey:@"education"];
                    model.image = [object objectForKey:@"image"];
                    model.laboral_experience = [object objectForKey:@"laboral_experience"];
                    model.lastname = [object objectForKey:@"lastname"];
                    if ([object objectForKey:@"list_position"] != nil) {
                        model.list_position = [object objectForKey:@"list_position"];
                        
                    }
                    model.name=  [object objectForKey:@"name"]; //nombre;
                    model.party=  [object objectForKey:@"party"]; //nombre;
                    // NSLog(@"party %@",model.party);
                    model.political_experience = [object relationForKey:@"political_experience"];
                    
                    
                    
                    if ([partido.partidoID isEqualToString:[model.party objectId]]){
                        
                        
                        itemsOfPartido * itemPolitico = [[itemsOfPartido alloc]init];
                        itemPolitico.politicianObject = object;
                        itemPolitico.nombre = [NSString stringWithFormat:@"%@ %@",model.name,model.lastname];
                        itemPolitico.imagen = model.image.url;
                        itemPolitico.partido = [model.party objectForKey:@"shortname"];
                        if (model.birthday != nil){
                            itemPolitico.edad = [self getBirthday:model.birthday];
                        }
                        itemPolitico.fechaDeNaciomiento = model.birthday;
                        itemPolitico.cargo = [model.charge objectForKey:@"name"];
                        
                        if ([[model.charge objectForKey:@"name"]  isEqual: @"Presidente"]|| [[model.charge objectForKey:@"name"]  isEqual: @"Presidente"]) {
                            itemPolitico.cargo = @"Presidencial";
                        }
                        
                        
                        //----------AGREGAR RELACIONES PARA DESCARGAR DESPUES
                        
                        itemPolitico.politicalRelation = model.political_experience;
                        itemPolitico.laboralRelation = model.laboral_experience;
                        itemPolitico.educationRelation = model.education;
                        
                        //----------AGREGAR RELACIONES PARA DESCARGAR DESPUES
                        
                        // [itemPolitico updateExperienciaPolitica:model.political_experience];
                        // [itemPolitico updateExperienciaLaboral:model.laboral_experience];
                        // [itemPolitico updateEducacion:model.education];
                        
                        
                        
                        if (model.list_position != nil){
                            
                            NSNumber * listNumber =[model.list_position valueForKey:@"position"];
                            itemPolitico.posicionListado = listNumber.intValue;
                            itemPolitico.posicionKey = listNumber;
                            
                            PFObject * listadoInsde = [model.list_position objectForKey:@"list"];
                            
                            
                            
                            NSString * listadoPolitico = [listadoInsde valueForKey:@"name"];
                            
                            // NSLog(listadoPolitico);
                            
                            
                            
                            
                            itemPolitico.listado = listadoPolitico;
                            
                        }
                        
                        
                        
                        //--------QUERY LIST NAME
                        
                        
                        
                        
                        
                        
                        
                        
                        [itemsInsidePartido addObject:itemPolitico];
                    }
                    
                    
                    
                    
                }
                
                
                
                
                //--------------------------------------------------------------------
                
                [partidosInfo addObject:itemsInsidePartido];
                
                
            }
            
            if (ii == 0){
            
            dispatch_async(dispatch_get_main_queue(), ^{

            [[NSNotificationCenter defaultCenter] postNotificationName:@"incomeData" object:partidosInfo];

             });
            
            }else{
                
                lastDataToSend = partidosInfo;
            }

            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //------------DELETE CACHED RATING
            
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", @"rating"];
            [[NSUserDefaults standardUserDefaults] removeObjectsWithKeysMatchingPredicate:pred];
            
            //------------DELETE CACHED RATING
            
            
            NSLog(@"Politician Count %d",objectsInArray.count);
        
          [[NSNotificationCenter defaultCenter] postNotificationName:@"incomeData" object:lastDataToSend];

         [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedDownloading" object:nil];
            
        });
        
        
        
    });
    
   
    
    
    
    
    
    
    
    
}

+(void )downloadPoliticiansAllParts:(NSMutableArray *)partidosArray
{
    
    //--------NO QUITAR ESTO ESTO CACHEA LOS LISTADOS DE LOS USUARIOS
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        
        PFQuery *listquery = [PFQuery queryWithClassName:@"List"];
        
        
        
        
        NSMutableArray * listadoDeListados = [listquery findObjects];
        
        
        //---Party
        
        PFQuery * partyQuery = [PFQuery queryWithClassName:@"Party"];
        NSArray * partyArray = [partyQuery findObjects];
        
        //---Charge
        
        PFQuery * chargeQuery = [PFQuery queryWithClassName:@"Charge"];
        NSArray * chargeArray = [chargeQuery findObjects];
        
        //------NO QUITAR ESTO CACHE LOS LISTADO DE LOS USUARIOS
        //   NSLog(@"LIST QUERY %@",listadoDeListados);
        
        
        
        
        
        NSArray * preArray;
        NSMutableArray * objectsInArray = [[NSMutableArray alloc]init];
        
        NSArray * lastDataToSend;
        
        
        
        
        for (int ii =0; ii < 3; ii++){
            
            
            NSMutableArray * partidosInfo =[[NSMutableArray alloc]init];
            
            
            PFQuery *query = [PFQuery queryWithClassName:@"Politician"];
            
            if (ii == 0){
                [query setLimit: 500];
                [query setSkip:ii * 500];
            }else{
                
                [query setLimit: 1000];
                [query setSkip: ((ii - 1) * 1000) + 500];
                
            }
            
            
            //[query includeKey:@"party"];
            //[query includeKey:@"charge"];
            [query includeKey:@"list_position"];
            //[query includeKey:@"links"];
            
            
            [query orderByAscending:@"createdAt"];
            
            
            preArray = [query findObjects];
            
            objectsInArray = [NSMutableArray arrayWithArray:   [objectsInArray arrayByAddingObjectsFromArray:preArray]];
            
            
            
            
            
            
            
            for (int xx=0; xx < partidosArray.count; xx++) {
                
                
                
                PartidosModel * partido = partidosArray[xx];
                NSMutableArray * itemsInsidePartido =[[NSMutableArray alloc]init];
                
                // NSLog(@"PARTIDO %@",partido.partidoID);
                
                
                for (PFObject *object in objectsInArray) {
                    
                    
                    //--------------------------PFOBJECT
                    
                    
                    
                    
                    
                    //------------------------------------------------------
                    
                    
                    PoliticianModel * model = [[PoliticianModel alloc]init];
                    //----------------CASTING
                    
                    model.birthday = [object objectForKey:@"birthday"];
                    model.charge = [object objectForKey:@"charge"];
                    model.obj_description = [object objectForKey:@"description"];
                    //education
                    model.education = [object objectForKey:@"education"];
                    model.image = [object objectForKey:@"image"];
                    model.laboral_experience = [object objectForKey:@"laboral_experience"];
                    model.lastname = [object objectForKey:@"lastname"];
                    if ([object objectForKey:@"list_position"] != nil) {
                        model.list_position = [object objectForKey:@"list_position"];
                        
                    }
                    model.name=  [object objectForKey:@"name"]; //nombre;
                    model.party=  [object objectForKey:@"party"]; //nombre;
                    // NSLog(@"party %@",model.party);
                    model.political_experience = [object relationForKey:@"political_experience"];
                    
                    
                    
                    if ([partido.partidoID isEqualToString:[model.party objectId]]){
                        
                        
                        itemsOfPartido * itemPolitico = [[itemsOfPartido alloc]init];
                        itemPolitico.politicianObject = object;
                        itemPolitico.nombre = [NSString stringWithFormat:@"%@ %@",model.name,model.lastname];
                        itemPolitico.imagen = model.image.url;
                        itemPolitico.partido = [model.party objectForKey:@"shortname"];
                        if (model.birthday != nil){
                            itemPolitico.edad = [self getBirthday:model.birthday];
                        }
                        itemPolitico.fechaDeNaciomiento = model.birthday;
                        itemPolitico.cargo = [model.charge objectForKey:@"name"];
                        
                        if ([[model.charge objectForKey:@"name"]  isEqual: @"Presidente"]|| [[model.charge objectForKey:@"name"]  isEqual: @"Presidente"]) {
                            itemPolitico.cargo = @"Presidencial";
                        }
                        
                        
                        //----------AGREGAR RELACIONES PARA DESCARGAR DESPUES
                        
                        itemPolitico.politicalRelation = model.political_experience;
                        itemPolitico.laboralRelation = model.laboral_experience;
                        itemPolitico.educationRelation = model.education;
                        
                        //----------AGREGAR RELACIONES PARA DESCARGAR DESPUES
                        
                        // [itemPolitico updateExperienciaPolitica:model.political_experience];
                        // [itemPolitico updateExperienciaLaboral:model.laboral_experience];
                        // [itemPolitico updateEducacion:model.education];
                        
                        
                        
                        if (model.list_position != nil){
                            
                            NSNumber * listNumber =[model.list_position valueForKey:@"position"];
                            itemPolitico.posicionListado = listNumber.intValue;
                            itemPolitico.posicionKey = listNumber;
                            
                            PFObject * listadoInsde = [model.list_position objectForKey:@"list"];
                            
                            
                            
                            NSString * listadoPolitico = [listadoInsde valueForKey:@"name"];
                            
                            // NSLog(listadoPolitico);
                            
                            
                            
                            
                            itemPolitico.listado = listadoPolitico;
                            
                        }
                        
                        
                        
                        //--------QUERY LIST NAME
                        
                        
                        
                        
                        
                        
                        
                        
                        [itemsInsidePartido addObject:itemPolitico];
                    }
                    
                    
                    
                    
                }
                
                
                
                
                //--------------------------------------------------------------------
                
                [partidosInfo addObject:itemsInsidePartido];
                
                
            }
            
            if (ii == 0){
                
                                
            }else{
                
                lastDataToSend = partidosInfo;
            }
            
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //------------DELETE CACHED RATING
            
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", @"rating"];
            [[NSUserDefaults standardUserDefaults] removeObjectsWithKeysMatchingPredicate:pred];
            
            //------------DELETE CACHED RATING
            
            
            NSLog(@"Politician Count %d",objectsInArray.count);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"incomeData" object:lastDataToSend];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedDownloading" object:nil];
            
        });
        
        
        
    });
    
    
    
    
    
    
    
    
    
    
}


+(void )downloadPoliticians:(NSMutableArray *)partidosArray :(NSString *)list :(myCompletion) compblock
{
    
    //--------NO QUITAR ESTO ESTO CACHEA LOS LISTADOS DE LOS USUARIOS
    
    PFQuery *listquery = [PFQuery queryWithClassName:@"Meme"];
    
    [listquery whereKey:@"name" equalTo:list];
    
    
    
    NSMutableArray * listadoDeListados = [listquery findObjects];
    
    // NSLog(@"LISR QUERY %@",listadoDeListados);
    
    PFObject * objectOfListado = listadoDeListados[0];
    //---Party
    
    PFQuery * partyQuery = [PFQuery queryWithClassName:@"Party"];
    NSArray * partyArray = [partyQuery findObjects];
    
    //---Charge
    
    PFQuery * chargeQuery = [PFQuery queryWithClassName:@"Charge"];
    NSArray * chargeArray = [chargeQuery findObjects];
    
    
    
    
    //------NO QUITAR ESTO CACHE LOS LISTADO DE LOS USUARIOS
    
    
    //--------------------
    
    
    PFQuery * innerlistquery = [PFQuery queryWithClassName:@"List_position"];
    
    
    [innerlistquery setLimit: 1000];
    
    [innerlistquery includeKey:@"politician"];
    
    
    [innerlistquery whereKey:@"list" equalTo:objectOfListado];
    
    NSArray * itemsofinner = [innerlistquery findObjects];
    
    NSMutableArray * objectsInArray = [itemsofinner valueForKey:@"politician"];
    
    
    
    // NSLog(@"ITEMS OF INNER %@",objectsInArray);
    
    
    
    
    
    
    NSMutableArray * partidosInfo =[[NSMutableArray alloc]init];
    
    
    NSArray * preArray;
        
    
    
    
    
    for (int xx=0; xx < partidosArray.count; xx++) {
        
        
        
        PartidosModel * partido = partidosArray[xx];
        NSMutableArray * itemsInsidePartido =[[NSMutableArray alloc]init];
        
        // NSLog(@"PARTIDO %@",partido.partidoID);
        
        
        for (PFObject *object in objectsInArray) {
            
            
            //--------------------------PFOBJECT
            
            
            
            
            
            //------------------------------------------------------
            
            
            PoliticianModel * model = [[PoliticianModel alloc]init];
            //----------------CASTING
            
            model.birthday = [object objectForKey:@"birthday"];
            model.charge = [object objectForKey:@"charge"];
            model.obj_description = [object objectForKey:@"description"];
            //education
            model.education = [object objectForKey:@"education"];
            model.image = [object objectForKey:@"image"];
            model.laboral_experience = [object objectForKey:@"laboral_experience"];
            model.lastname = [object objectForKey:@"lastname"];
            if ([object objectForKey:@"list_position"] != nil) {
                model.list_position = [object objectForKey:@"list_position"];
                
            }
            model.name=  [object objectForKey:@"name"]; //nombre;
            model.party=  [object objectForKey:@"party"]; //nombre;
            // NSLog(@"party %@",model.party);
            model.political_experience = [object relationForKey:@"political_experience"];
            
            
            
            if ([partido.partidoID isEqualToString:[model.party objectId]]){
                
                
                itemsOfPartido * itemPolitico = [[itemsOfPartido alloc]init];
                itemPolitico.politicianObject = object;
                itemPolitico.nombre = [NSString stringWithFormat:@"%@ %@",model.name,model.lastname];
                itemPolitico.imagen = model.image.url;
                itemPolitico.partido = [model.party objectForKey:@"shortname"];
                if (model.birthday != nil){
                    itemPolitico.edad = [self getBirthday:model.birthday];
                }
                itemPolitico.fechaDeNaciomiento = model.birthday;
                itemPolitico.cargo = [model.charge objectForKey:@"name"];
                
                if ([[model.charge objectForKey:@"name"]  isEqual: @"Presidente"]|| [[model.charge objectForKey:@"name"]  isEqual: @"Presidente"]) {
                    itemPolitico.cargo = @"Presidencial";
                }
                
                
                //----------AGREGAR RELACIONES PARA DESCARGAR DESPUES
                
                itemPolitico.politicalRelation = model.political_experience;
                itemPolitico.laboralRelation = model.laboral_experience;
                itemPolitico.educationRelation = model.education;
                
                //----------AGREGAR RELACIONES PARA DESCARGAR DESPUES
                
                // [itemPolitico updateExperienciaPolitica:model.political_experience];
                // [itemPolitico updateExperienciaLaboral:model.laboral_experience];
                // [itemPolitico updateEducacion:model.education];
                
                
                
                if (model.list_position != nil){
                    
                    NSNumber * listNumber =[model.list_position valueForKey:@"position"];
                    itemPolitico.posicionListado = listNumber.intValue;
                    itemPolitico.posicionKey = listNumber;
                    
                    PFObject * listadoInsde = [model.list_position objectForKey:@"list"];
                    
                    
                    
                    NSString * listadoPolitico = [listadoInsde valueForKey:@"name"];
                    
                    // NSLog(listadoPolitico);
                    
                    
                    
                    
                    itemPolitico.listado = listadoPolitico;
                    
                }
                
                
                
                //--------QUERY LIST NAME
                
                /*
                 
                 
                 */
                
                
                
                
                
                
                
                [itemsInsidePartido addObject:itemPolitico];
            }
            
            
            
            
        }
        
        
        
        
        //--------------------------------------------------------------------
        
        [partidosInfo addObject:itemsInsidePartido];
        
        
    }
    
    
    
    
    //  NSLog(@"%@",partidosInfo);
    
    NSLog(@"FINISH JOB");
    compblock(partidosInfo);
    
    
    
    
    
    
    
    
    
    
    
    
    
}

+(NSInteger)getBirthday:(NSDate *)birthday{
    
    
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthday
                                       toDate:now
                                       options:0];
    NSInteger age = [ageComponents year];
    
    return age;
}

@end
