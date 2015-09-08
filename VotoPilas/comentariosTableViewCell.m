//
//  comentariosTableViewCell.m
//  VotoPilas
//
//  Created by Jose on 6/24/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "comentariosTableViewCell.h"

@implementation comentariosTableViewCell{
    
    UILabel * infoLabel;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)didMoveToSuperview{
    
    [super didMoveToSuperview];
    
    
    //-------------------------
    
    infoLabel = [[UILabel alloc]init];
    infoLabel.frame = CGRectMake(15, 0, self.frame.size.width - 15, self.frame.size.height);
    infoLabel.text = _title;
    infoLabel.textColor = [UIColor colorWithWhite:(44.0/ 255.0) alpha:(1.0)];
    infoLabel.numberOfLines = 0;
    infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self addSubview:infoLabel];
    
    
    
}

@end
