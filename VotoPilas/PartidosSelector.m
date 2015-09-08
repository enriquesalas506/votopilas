//
//  PartidosSelector.m
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "PartidosSelector.h"
#import "PartidosItem.h"
#import "PartidosModel.h"

@implementation PartidosSelector{
    
    UIColor * blueSky;
    UIScrollView * scroll;
    CGFloat itemsWidth;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)didMoveToSuperview{
    
    [super didMoveToSuperview];
    
    //---Set Up View
    
    //34	175	241
    self.backgroundColor = [UIColor colorWithRed:(34.0 / 255.0) green:(175.0 / 255.0) blue:(241.0 / 255.0) alpha:1.0];
    blueSky = [UIColor colorWithRed:(34.0 / 255.0) green:(175.0 / 255.0) blue:(241.0 / 255.0) alpha:1.0];
    
    scroll = [[UIScrollView alloc]init];
    
    scroll.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    scroll.delaysContentTouches = true;
    
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setShowsVerticalScrollIndicator:NO];
    scroll.bounces = NO;
    
    [self addSubview:scroll];
    
    itemsWidth = 125;
    
   // [self debugItems];
    [self refreshItems];
    
    //---Set UP View
    
    
    //----------------------------------------
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ChangePartidoNotification" object:nil];

    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(changeNotification:)
     name:@"ChangePartidoNotification"
     object:nil];
    
    
}


-(void)changeNotification:(NSNotification *)notifcation{
    
    NSNumber * index = notifcation.object;
    
    
    [self highLightItem:index.intValue];
    
}

-(void)debugItems{
    
    _itemsList = [NSMutableArray arrayWithObjects: @"Juan Perez",@"Sancho Panza",@"Don Quijote",@"Barack Obama",@"Mickey Mouse",@"Barney",nil];
    
    
}


-(void)clearSelector{
    NSArray *viewsToRemove = [scroll subviews];

    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
}

-(void)refreshItems{
    

    
    scroll.alpha = 1;
  
    
    //----FIRST ANIMATION
    
    //----FIRST ANIMATION
    
    
    
    NSArray *viewsToRemove = [scroll subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
        [self addSubview:v];
        v.alpha = 1;
        
        [UIView animateWithDuration:0
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             
                             v.alpha = 0;
                             
                         }
                         completion:^(BOOL finished){
                             
                             [v removeFromSuperview];
                         }];
    }
    
  

    
    //------ADDING ITEMS 
    for (int ss = 0; ss <  _itemsList.count ; ss++) {
        

        
        PartidosItem * item = [[PartidosItem alloc]init];
        item.frame = CGRectMake((CGFloat) ss * itemsWidth, 0, itemsWidth, self.frame.size.height);
        item.index = ss;
        //item.title = _itemsList[ss];
        PartidosModel * partido = _itemsList[ss];
        
        item.title = partido.acronym;
        
        [scroll addSubview:item];
        
    }
    
    scroll.contentSize = CGSizeMake((CGFloat)_itemsList.count * itemsWidth , self.frame.size.height);
    
    
    
}


-(void) highLightItem:(int) itemToHightLight{
    
    if (itemToHightLight >= _itemsList.count){
        return;
    }
    
    if (itemToHightLight < 0){
     
        return;//en caso de un valor menor que 0 terminar todo para evitar errores
    }
    
  
    NSArray * viewsToRemove = [scroll subviews];
    for (int ss = 0 ; ss< viewsToRemove.count ; ss++) {
        
        if (ss != itemToHightLight){
            PartidosItem * v = viewsToRemove[ss];
            v.backgroundColor = blueSky;
            v.selected = false;
            [v deselectItem];
            
        }else{
            PartidosItem * v = viewsToRemove[ss];
            v.selected = true;
        }
        
    }
    
    
    
    
    
    PartidosItem * highView = scroll.subviews[itemToHightLight];
    //131	172	238
    
   
    
    [UIView animateWithDuration:0.2
                          delay:0
                     options: UIViewAnimationCurveEaseOut
                     animations:^{
                         [highView.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                         
                     }
                     completion:^(BOOL finished){
                                             }];
    
    //--------------RESIZE IF FEW
    
    
    UIView * last = scroll.subviews[_itemsList.count-1];//revisar que por lo menos pase el scrollview
    
    if (last.frame.origin.x + last.frame.size.width < scroll.frame.size.width){
        
        
        for (int ss = 0 ; ss< _itemsList.count ; ss++){
            
            
            CGFloat spacing = scroll.frame.size.width / (CGFloat)_itemsList.count;
            
            PartidosItem * first = scroll.subviews[ss];
            
            
            
            
            first.button.frame = CGRectMake(10, 5, itemsWidth - 20, 44);

            
           
            first.button.frame = CGRectMake(10, 5, spacing - 20,45);
            
            
            
            first.frame = CGRectMake(spacing * (CGFloat)ss, first.frame.origin.y, spacing , first.frame.size.height);
            
            
            first.alpha = 0;
            
            [UIView animateWithDuration:0.10
                                  delay:0
             
                                options: UIViewAnimationCurveEaseOut
                             animations:^{
                                 
                                 
                                 
                                 first.alpha = 1;
                              
                                 
                                 
                             }
                             completion:^(BOOL finished){
                                 NSLog(@"SizeAnimation");
                                
                                 
                                 
                             }];
            
        }
        
        
        scroll.contentSize = CGSizeMake(scroll.frame.size.width, scroll.frame.size.height);
        
        
        
    }
    
    
 
        
    
    

    
    //---------------RESIZE IF FEW
 
    
    if (itemToHightLight>0 && itemToHightLight< _itemsList.count -1){
    
    CGPoint position = CGPointMake(highView.frame.origin.x + (highView.frame.size.width / 2) - (scroll.frame.size.width / 2) , 0);
    //[scroll setContentOffset:position animated:true];
        
        [UIView animateWithDuration:0.2
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                            
                             scroll.contentOffset = position;
                             
                         }
                         completion:^(BOOL finished){
                           //  NSLog(@"Done!");
                         }];
    }
        
        
    
    
    if (itemToHightLight == 0){
        
        CGPoint position = CGPointMake(0 , 0);

        [UIView animateWithDuration:0.2
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             scroll.contentOffset = position;
                             
                         }
                         completion:^(BOOL finished){
                            // NSLog(@"Done!");
                         }];

    
    }
    if (itemToHightLight == _itemsList.count - 1){
        
        CGPoint position = CGPointMake(scroll.contentSize.width - scroll.frame.size.width , 0);

        [UIView animateWithDuration:0.2
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             scroll.contentOffset = position;
                             
                         }
                         completion:^(BOOL finished){
                            // NSLog(@"Done!");
                         }];

    
    }
    
    
   
        
        
    
    
    
    
}


@end
