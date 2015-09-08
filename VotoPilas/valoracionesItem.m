//
//  valoracionesItem.m
//  VotoPilas
//
//  Created by Jose on 7/17/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "valoracionesItem.h"
#import "SDWebImage/UIImageView+WebCache.h"


@implementation valoracionesItem{
    
    UIButton * boton;
    UIImageView * img;
    BOOL selected;
    
    UIImageView * checkImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)didMoveToSuperview{
    
    selected = true;
    
    checkImage = [[UIImageView alloc]init];
    checkImage.image = [UIImage imageNamed: @"check.png"];
    checkImage.frame = CGRectMake(-15, -15, 30, 30);
    checkImage.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    boton = [[UIButton alloc]init];
    boton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview: boton];
    [boton addTarget:self action:@selector(selectItem) forControlEvents:UIControlEventTouchUpInside];
    
    [boton addTarget:self action:@selector(invertedTest) forControlEvents:UIControlEventTouchDown];
    [boton addTarget:self action:@selector(invertedTest) forControlEvents:UIControlEventTouchCancel];
    
    self.layer.cornerRadius = self.frame.size.width / 10;
    self.layer.borderWidth = 1;
    //186	187	192
    self.layer.borderColor = [UIColor colorWithWhite:(186.0 / 255.0) alpha:1].CGColor;
    
    [self testItem];
    
    //Helvetica
    
    
    
    UILabel * label = [[UILabel alloc]init];
    label.text = [_name capitalizedString];
    label.adjustsFontSizeToFitWidth = true;
    label.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
    label.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    label.minimumScaleFactor = 6.0 / label.font.pointSize;

    label.textAlignment = NSTextAlignmentCenter;
    //label.backgroundColor = [UIColor redColor];
    label.frame = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30);
    [self addSubview:label];
    
    
    img = [[UIImageView alloc]init];
    img.frame = CGRectMake(20, 10, self.frame.size.width - 40, self.frame.size.height - 40);
    if ([_facebookId isEqualToString: @"todos"]){
        img.image = [UIImage imageNamed:@"todos-placeholder.png"];
    }else{
        NSString *urlString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", _facebookId];
        
        
        [img sd_setImageWithURL:[NSURL URLWithString:urlString]];
        

    }
    img.contentMode = UIViewContentModeScaleAspectFill;
    img.layer.cornerRadius = img.frame.size.width /2;
    img.clipsToBounds = true;
    [self addSubview: img];
    
    
    
    
}

-(void)selectItem{
    
    selected = !selected;
    
    if (!selected){
        
        NSLog(@"REMOVING %@",_facebookId);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // to store
        [defaults setObject:[NSNumber numberWithInt:0] forKey:_facebookId];
        [defaults synchronize];
    }else{
        
        NSLog(@"ADDING %@",_facebookId);

        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // to store
        [defaults setObject:nil forKey:_facebookId];
        [defaults synchronize];
    }
    
    [self testItem];
    
}
-(void)testItem{
    if ( selected == true){
        
        
        self.layer.cornerRadius = self.frame.size.width / 10;
        self.layer.borderWidth = 2;
        //186	187	192
        //61	216	94
        self.layer.borderColor = [UIColor colorWithRed:(61.0 / 255.0) green:(216.0 / 255.0) blue:(94.0 / 255.0) alpha:1.0].CGColor;
        
        [self addSubview:checkImage];
        
        
    }
    if ( selected != true){
        
        
        
        self.layer.cornerRadius = self.frame.size.width / 10;
        self.layer.borderWidth = 1;
        //186	187	192
        self.layer.borderColor = [UIColor colorWithWhite:(186.0 / 255.0) alpha:1].CGColor;
        
        
        [checkImage removeFromSuperview];
        
        
    }

}

-(void)invertedTest{
    if ( selected != true){
        
        
        self.layer.cornerRadius = self.frame.size.width / 10;
        self.layer.borderWidth = 2;
        //186	187	192
        //61	216	94
        self.layer.borderColor = [UIColor colorWithRed:(61.0 / 255.0) green:(216.0 / 255.0) blue:(94.0 / 255.0) alpha:1.0].CGColor;
        
        
        
    }
    if ( selected == true){
        
        
        
        self.layer.cornerRadius = self.frame.size.width / 10;
        self.layer.borderWidth = 1;
        //186	187	192
        self.layer.borderColor = [UIColor colorWithWhite:(186.0 / 255.0) alpha:1].CGColor;
        
        
        
        
    }
    
}


@end
