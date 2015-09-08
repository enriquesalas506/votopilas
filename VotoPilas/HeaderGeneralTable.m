//
//  HeaderGeneralTable.m
//  VotoPilas
//
//  Created by Jose on 7/31/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "HeaderGeneralTable.h"

@implementation HeaderGeneralTable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)didMoveToSuperview{
    
    UIView * line = [[UIView alloc]init];
    line.frame = CGRectMake(15, 1, self.frame.size.width - 30, 1);
    //208	210	213
    line.backgroundColor = [UIColor colorWithRed:(208.0 / 255.0) green:(210.0 / 255.0) blue:(213.0 / 255.0) alpha:1.0];
    
    [self addSubview:line];
    
    //------
    
    
    UILabel * label = [[UILabel alloc]init];
    label.text = _title;
    label.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    label.frame = CGRectMake(30, line.frame.origin.y + 7, self.frame.size.width - 60, 25);
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self addSubview:label];
    
}

@end
