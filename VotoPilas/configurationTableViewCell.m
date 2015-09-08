
//
//  configurationTableViewCell.m
//  VotoPilas
//
//  Created by Jose on 7/23/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "configurationTableViewCell.h"

@implementation configurationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


-(void)didMoveToSuperview{
    // Configure the view for the selected state
    
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(20, 0, self.frame.size.width / 2, self.frame.size.height);
    label.text = _titulo;
    label.textColor = [UIColor colorWithWhite:(0.1) alpha:1.0];
    [self addSubview:label];
    
    
    UIImage * arrowImage = [UIImage imageNamed:@"arrowr.png"];
    arrowImage =  [arrowImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImageView * arrow = [[UIImageView alloc]initWithImage:arrowImage];
    arrow.frame = CGRectMake(self.frame.size.width - 30, (self.frame.size.height / 2) - (15.0 /2) , 15, 15 );
    //186	185	192
    [arrow setTintColor:[UIColor colorWithWhite:(186.0 /255.0) alpha:1.0]];
    [self addSubview:arrow];
    


}
@end
