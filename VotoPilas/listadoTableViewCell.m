//
//  listadoTableViewCell.m
//  VotoPilas
//
//  Created by Jose on 6/23/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "listadoTableViewCell.h"

@implementation listadoTableViewCell{
    
    UILabel * titleLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)didMoveToSuperview{
    
    self.backgroundColor = [UIColor colorWithRed:(43.0 / 255.0) green:(47.0 / 255.0) blue:(61.0 / 255.0) alpha:(1.0)];
    
    titleLabel = [[UILabel alloc]init];
    
    titleLabel.frame = CGRectMake(24, 0, self.frame.size.width, self.frame.size.height);
    
    titleLabel.text = _title;
    
    //113	124	154
    titleLabel.textColor = [UIColor colorWithRed:(113.0 / 255.0) green:(124.0 / 255.0) blue:(154.0 / 255.0) alpha:1.0];
    
    [self addSubview:titleLabel];
}



@end
