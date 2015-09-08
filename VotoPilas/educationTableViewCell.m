//
//  educationTableViewCell.m
//  VotoPilas
//
//  Created by Jose on 7/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "educationTableViewCell.h"

@implementation educationTableViewCell{
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
    UIImageView * check = [[UIImageView alloc]init];
    check.frame = CGRectMake(10, 10, self.frame.size.height, self.frame.size.height - 20);
    check.image = [UIImage imageNamed:@"check.png"];
    check.image = [check.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    check.contentMode = UIViewContentModeScaleAspectFit;
    [check setTintColor:[UIColor colorWithWhite:(82.0 / 255.0) alpha:(1.0)]];
    // [self addSubview:check];
    
    
    //-------------------------
    
    UILabel * puestoLabel = [[UILabel alloc]init];
    puestoLabel.frame = CGRectMake(25, 15, 100, 20);
    puestoLabel.text = @"PUESTO";
    puestoLabel.font = [puestoLabel.font fontWithSize:12];
    //175	175	170
    puestoLabel.textColor = [UIColor colorWithWhite:(175.0 / 255.0) alpha:1.0];
    [self addSubview:puestoLabel];
    
    
    UILabel * DireccionLabel = [[UILabel alloc]init];
    DireccionLabel.frame = CGRectMake(self.frame.size.width - 175, 15, 100, 20);
    DireccionLabel.text = @"TIEMPO";
    DireccionLabel.textAlignment = NSTextAlignmentRight;
    DireccionLabel.font = [puestoLabel.font fontWithSize:12];
    //175	175	170
    DireccionLabel.textColor = [UIColor colorWithWhite:(175.0 / 255.0) alpha:1.0];
    [self addSubview:DireccionLabel];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString * beginSting = [formatter stringFromDate: _beginDate];
    NSString * endString = [formatter stringFromDate: _endDate];
    
    
    UILabel * tiempo = [[UILabel alloc]init];
    tiempo.frame = CGRectMake(self.frame.size.width - 120, puestoLabel.frame.origin.y + puestoLabel.frame.size.height, 150, 30);
    tiempo.text = [[NSString stringWithFormat:@"%@ - %@",beginSting,endString] capitalizedString];
    tiempo.textAlignment = NSTextAlignmentLeft;
    tiempo.font = [tiempo.font fontWithSize:15];
    tiempo.textColor = [UIColor colorWithWhite:(0.1) alpha:1.0];
    [self addSubview:tiempo];
    
    
    
    CGFloat infoLabelY = puestoLabel.frame.origin.y + puestoLabel.frame.size.height;
    
    
    
    infoLabel = [[UILabel alloc]init];
    
    CGFloat infoLabelH = [self getHeightForText:[_title capitalizedString] withFont: [infoLabel.font fontWithSize:15] andWidth:150];

    
    infoLabel.frame = CGRectMake(25,infoLabelY,150, infoLabelH);
    infoLabel.text = [_title capitalizedString];
    infoLabel.textColor = [UIColor colorWithWhite:(44.0/ 255.0) alpha:(1.0)];
    //infoLabel.minimumScaleFactor = 10.0 / infoLabel.font.pointSize;
    infoLabel.adjustsFontSizeToFitWidth = true;
    // infoLabel.backgroundColor = [UIColor redColor];
    infoLabel.numberOfLines = 0;
    
    infoLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    infoLabel.font = [infoLabel.font fontWithSize:15];
    infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    [self addSubview:infoLabel];
    
    

    
    UILabel * empresaLabel = [[UILabel alloc]init];
    
    

    empresaLabel.frame = CGRectMake(25, infoLabel.frame.size.height + infoLabel.frame.origin.y + 5, 200, 20);
    empresaLabel.text = @"FACULTAD";
    empresaLabel.font = [puestoLabel.font fontWithSize:12];
    //175	175	170
    empresaLabel.textColor = [UIColor colorWithWhite:(175.0 / 255.0) alpha:1.0];
    [self addSubview:empresaLabel];
    
    UILabel * empresa = [[UILabel alloc]init];
    
    
    CGFloat empresaH =[self getHeightForTextWithNoDefault:[_place capitalizedString] withFont: [empresaLabel.font fontWithSize:15] andWidth:200];

    empresa.frame = CGRectMake(25, empresaLabel.frame.origin.y + empresaLabel.frame.size.height,200, empresaH);
    empresa.text = [_place capitalizedString];
    empresa.textColor = [UIColor colorWithWhite:(44.0/ 255.0) alpha:(1.0)];
    empresa.numberOfLines = 0;
    //empresa.adjustsFontSizeToFitWidth = YES;
    empresa.minimumScaleFactor = 6.0 / empresa.font.pointSize;
    empresa.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    empresa.font = [tiempo.font fontWithSize:15];
    [self addSubview:empresa];
    
    
    
    
    
    
    //----------------------------
    CGFloat descriptionY = empresa.frame.origin.y + empresa.frame.size.height;
    
    UILabel * desriptionLabel = [[UILabel alloc]init];
    
    CGFloat descriptionH =[self getHeightForText:[_job_description capitalizedString] withFont: [desriptionLabel.font fontWithSize:10] andWidth:150];

    
    desriptionLabel.frame = CGRectMake(25, descriptionY, self.frame.size.width - 50, descriptionH);
    desriptionLabel.textAlignment = NSTextAlignmentLeft;
    // desriptionLabel.backgroundColor = [UIColor redColor];
       desriptionLabel.font = [desriptionLabel.font fontWithSize:10];
    //175	175	170
    desriptionLabel.textColor = [UIColor colorWithWhite:(0.1) alpha:1.0];
    desriptionLabel.text = _job_description;
    desriptionLabel.numberOfLines = 0;
    desriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;

    [self addSubview:desriptionLabel];
    
    
    
    
   // desriptionLabel.backgroundColor = [UIColor redColor];
    
    
    
    self.clipsToBounds = true;
    
}

-(float) getHeightForTextWithNoDefault:(NSString*) text withFont:(UIFont*) font andWidth:(float) width{
    CGSize constraint = CGSizeMake(width , 20000.0f);
    CGSize title_size;
    float totalHeight;
    
    SEL selector = @selector(boundingRectWithSize:options:attributes:context:);
    if ([text respondsToSelector:selector]) {
        title_size = [text boundingRectWithSize:constraint
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{ NSFontAttributeName : font }
                                        context:nil].size;
        
        totalHeight = ceil(title_size.height);
    } else {
        title_size = [text sizeWithFont:font
                      constrainedToSize:constraint
                          lineBreakMode:NSLineBreakByWordWrapping];
        totalHeight = title_size.height ;
    }
    
    CGFloat height = MAX(totalHeight, 0.0f);
    return height;
}


-(float) getHeightForText:(NSString*) text withFont:(UIFont*) font andWidth:(float) width{
    CGSize constraint = CGSizeMake(width , 20000.0f);
    CGSize title_size;
    float totalHeight;
    
    SEL selector = @selector(boundingRectWithSize:options:attributes:context:);
    if ([text respondsToSelector:selector]) {
        title_size = [text boundingRectWithSize:constraint
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{ NSFontAttributeName : font }
                                        context:nil].size;
        
        totalHeight = ceil(title_size.height);
    } else {
        title_size = [text sizeWithFont:font
                      constrainedToSize:constraint
                          lineBreakMode:NSLineBreakByWordWrapping];
        totalHeight = title_size.height ;
    }
    
    CGFloat height = MAX(totalHeight, 25.0f);
    return height;
}

@end
