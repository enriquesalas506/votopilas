//
//  PartidosSelector.h
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartidosSelector : UIView


@property (strong,nonatomic) NSMutableArray * itemsList;

@property int currentItem;

-(void) highLightItem:(int) itemToHightLight;

-(void)clearSelector;



-(void)refreshItems;


@end
