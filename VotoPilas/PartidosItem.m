//
//  PartidosItem.m
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "PartidosItem.h"

@implementation PartidosItem{
    
    UIColor * blueSky;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)didMoveToSuperview{
    
    blueSky = [UIColor colorWithRed:(34.0 / 255.0) green:(175.0 / 255.0) blue:(241.0 / 255.0) alpha:1.0];

    self.backgroundColor = blueSky;
    //self.layer.borderWidth = 1.0;
    //self.layer.borderColor = [UIColor colorWithWhite:0.4 alpha:1.0].CGColor;
    
    _button = [[UIButton alloc] init];
    _button.frame = CGRectMake(10, 5, self.frame.size.width - 20, self.frame.size.height - 5);
    _button.titleLabel.adjustsFontSizeToFitWidth = YES;
    _button.titleLabel.minimumScaleFactor = 10.0 / _button.titleLabel.font.pointSize;
    [_button setTitle:_title forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor colorWithWhite:1.0 alpha:1.0] forState:UIControlStateHighlighted];
    
    [self addSubview:_button];
    
    [_button addTarget:self action:@selector(selectItem) forControlEvents:UIControlEventTouchUpInside];
    
    [_button addTarget:self action:@selector(hoverItem) forControlEvents:UIControlEventTouchDown];

    [_button addTarget:self action:@selector(unhoverItem) forControlEvents:UIControlEventTouchDragOutside];

    [_button addTarget:self action:@selector(unhoverItem) forControlEvents:UIControlEventTouchCancel];
    
    [_button addTarget:self action:@selector(unhoverItem) forControlEvents:UIControlEventTouchUpInside];
    
    [_button addTarget:self action:@selector(unhoverItem) forControlEvents:UIControlEventTouchUpOutside];

    [_button addTarget:self action:@selector(unhoverItem) forControlEvents:UIControlEventTouchDragExit];


    
}

-(void) selectItem{
         

   // self.backgroundColor = [UIColor colorWithWhite:1 alpha:1];;
    
    NSNumber * number = [NSNumber numberWithInt:_index];
  
    NSLog(@"SELECTED %d",number.intValue);
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ChangePartidoNotification"
     object:number];
    

    
}

-(void) hoverItem{
    
    [_button setTitleColor:[UIColor colorWithWhite:1.0 alpha:1.0] forState:UIControlStateNormal];
    
    
}

-(void) unhoverItem{
    
    if (_selected == false){
        [_button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];

    }else{

        [_button setTitleColor:[UIColor colorWithWhite:1.0 alpha:1.0] forState:UIControlStateNormal];

    }
    
    
}
     

-(void)deselectItem{
    
    [_button setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateNormal];

}

@end
