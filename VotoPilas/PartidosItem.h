//
//  PartidosItem.h
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartidosItem : UIView

@property (strong,nonatomic) NSString * title;

@property int index;

@property (strong,nonatomic)UIButton * button;

@property BOOL selected;

-(void)deselectItem;

@end
