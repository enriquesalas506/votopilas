//
//  recomendacionCellTableViewCell.m
//  VotoPilas
//
//  Created by Jose on 6/24/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "recomendacionCellTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation recomendacionCellTableViewCell{
    
    UIImageView * image;
    UILabel * nombre;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)didMoveToSuperview{
    
    

    
    UIImageView * img = [[UIImageView alloc]init];
    if (_direction){
        img.frame = CGRectMake(10, 10, 55, 55);

    }else{
        img.frame = CGRectMake(self.frame.size.width - 55 - 10, 10, 55, 55);
        
    }
    
    img.clipsToBounds = true;
    img.contentMode = UIViewContentModeScaleAspectFill;
    img.layer.cornerRadius = img.frame.size.width / 2;
    [self addSubview:img];
    
    NSString *urlString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", _fbId];
    
    
    [img sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"user-photo.png"]];

    
    
    //234	234	234
    self.backgroundColor = [UIColor colorWithRed:(234.0 / 255.0) green:(234.0 / 255.0) blue:(234.0 / 255.0) alpha:1.0];
    
    nombre = [[UILabel alloc] init];
    nombre.text = [_Title capitalizedString];
    
    //33	24	57
    nombre.textColor =  [UIColor colorWithRed:(39.0 / 255.0) green:(42.0 / 255.0) blue:(53.0 / 255.0) alpha:1.0];

    if (_direction){
    nombre.frame = CGRectMake(75, 0, 150, 30);
        nombre.textAlignment = NSTextAlignmentLeft;
    }else{
    nombre.frame = CGRectMake(self.frame.size.width - 150 - 75, 0, 150, 30);
    nombre.textAlignment = NSTextAlignmentRight;
   
    }
    
    nombre.adjustsFontSizeToFitWidth = YES;
    [nombre setMinimumScaleFactor:5.0/nombre.font.pointSize];
    
    
   // nombre.numberOfLines = 0;
    
   // nombre.lineBreakMode = NSLineBreakByWordWrapping;
    
    //[nombre sizeToFit];
    
    [self addSubview:nombre];
    
    
    
        
    
    
    CGFloat starX = nombre.frame.origin.x;
    
    if (_direction){
        
        starX = nombre.frame.origin.x;
       
    }else{
       
        starX = nombre.frame.origin.x + 30;
    }

    
    CGFloat starY = nombre.frame.origin.y + nombre.frame.size.height + 5 ;
    
    
    for (int ss = 0; ss< 5 ; ss++){
        
        
        UIImageView * star = [[UIImageView alloc]init];
        star.frame = CGRectMake(starX + (25 * ss), starY, 20, 20);
        
        //[star setImage:[UIImage imageNamed:@"StarFilled.png"]];
        
        star.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:star];
        
        // star.backgroundColor = [UIColor grayColor];
        
        //177	127	9
        
        //star.image = [star.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        if (_rating > ss){
            // UIColor * bColor = [UIColor colorWithRed:(177.0 / 255.0) green:(127.0 / 255.0) blue:(9.0 / 255.0) alpha:(1.0)];
            // [star setTintColor: bColor];
            [star setImage:[UIImage imageNamed:@"StarFilled.png"]];
        }else
        {
            //    UIColor * bColor = [UIColor colorWithWhite:0.2 alpha:1.0];
            //    [star setTintColor: bColor];
            [star setImage:[UIImage imageNamed:@"StarOutlined.png"]];
            //[star setImage:[UIImage imageNamed:@"StarFilled.png"]];
        }
        
        
    }
    
    UITextView * text = [[UITextView alloc]init];
    text.backgroundColor = [UIColor clearColor];
    text.text = _message;
    text.selectable = false;
    text.editable= false;
    text.scrollEnabled = false;
    text.font = [text.font fontWithSize:12.0];
    //79	83	86
    text.textColor = [UIColor colorWithWhite:(86.0 / 255.0) alpha:1.0];
    [self addSubview:text];
    
    
    if (_direction){
        
        text.textAlignment = NSTextAlignmentLeft;
        text.frame = CGRectMake(75, self.frame.size.height - 90, self.frame.size.width - 100, 80);

        
    }else{
        text.frame = CGRectMake(25, self.frame.size.height - 90, self.frame.size.width - 100, 80);

        text.textAlignment = NSTextAlignmentRight;
    }
    
    
    
    
    
}

@end
