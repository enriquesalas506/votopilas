//
//  customSourceTableViewCell.m
//  VotoPilas
//
//  Created by Jose on 6/23/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "customSourceTableViewCell.h"

@implementation customSourceTableViewCell{
    
    UILabel * titleLabel;
    UIImageView * check;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    
}

-(void)didMoveToSuperview{
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(50, 0, self.frame.size.width - 100, self.frame.size.height);
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    [titleLabel setMinimumScaleFactor:6.0/titleLabel.font.pointSize];
    titleLabel.text = _title;
    [self addSubview:titleLabel];
    
    
    //--------------------------------------
    
   // NSLog(@"VALUE %d",_isSelected);
    
    
    UIImage * image = [UIImage imageNamed:@"check.png"];
    image =  [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
   check = [[UIImageView alloc]initWithImage:image];
    check.frame = CGRectMake(15, 15, self.frame.size.height - 30, self.frame.size.height - 30);
    //43	102	222
    if (_isSelected == true){
    [check setTintColor:[UIColor colorWithRed:(43.0 / 255.0) green:(102.0 / 255.0) blue:(222.0 / 255.0) alpha:(1.0)]];
    }else{
        [check setTintColor:[UIColor colorWithWhite:(194.0 / 255.0) alpha:(1.0)]];

    }
    //194	194	194
    [self addSubview:check];
    
}

-(void)checkSelection:(BOOL)selection{
    
    _isSelected = selection;
    
    if (_isSelected == true){
    [check setTintColor:[UIColor colorWithRed:(43.0 / 255.0) green:(102.0 / 255.0) blue:(222.0 / 255.0) alpha:(1.0)]];
    }else{
    [check setTintColor:[UIColor colorWithWhite:(194.0 / 255.0) alpha:(1.0)]];
    
    }
//194	194	194

}
@end
