//
//  CustomMiembroCell.m
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "CustomMiembroCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "globalVars.h"

extern NSMutableArray * ratingList;

extern int scrollCurrentPage;



@implementation CustomMiembroCell{
    
    UIImageView * image;
    UILabel * nombre;
    
}


extern bool didFinishLoading;


- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCell{
    
    
    NSLog(@"FRAME %f",self.frame.size.height);
    
    
    
}



-(void)didMoveToSuperview{
    
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    
    
    UIImage * arrowImage = [UIImage imageNamed:@"arrowr.png"];
    arrowImage =  [arrowImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImageView * arrow = [[UIImageView alloc]initWithImage:arrowImage];
    arrow.frame = CGRectMake(self.frame.size.width - 20, 15,12, 12);
    [arrow setTintColor:[UIColor colorWithWhite:0.7 alpha:1.0]];
    [self addSubview:arrow];
    

    
    
    nombre = [[UILabel alloc] init];
    nombre.text = [NSString stringWithFormat:@"%d. %@",_listPosition,_Title] ;
    
    nombre.frame = CGRectMake(self.frame.size.height + 3, 20, self.frame.size.width - (self.frame.size.height + 10) - 30, self.frame.size.height - 20);
    
    
    
    nombre.numberOfLines = 2;
    
    nombre.lineBreakMode = NSLineBreakByWordWrapping;
    
    nombre.font = [nombre.font fontWithSize:16];
    
    nombre.textColor = [UIColor colorWithWhite:0 alpha:1.0];
    
    nombre.adjustsFontSizeToFitWidth = true;
    
    nombre.minimumScaleFactor = 5.0 / nombre.font.pointSize;
    
    [nombre sizeToFit];
    
    [self addSubview:nombre];
    
    
    
    //-----IMAGE
    
    //_urlImage = @" ";
    NSURL * url = [NSURL URLWithString:_urlImage];
    image = [[UIImageView alloc]init];
    
  //  NSLog(@"POLITICO URL %@",url);
    
    if (url != nil){
        [image sd_setImageWithURL:url ];
        
    }else{
        image.image = [UIImage imageNamed:@"user-photo.png"];
        //[image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user-photo.png"]];

    }
    
   // [image setImage:[UIImage imageNamed:@"user-photo.png"]];
    
    
    image.clipsToBounds = YES;
    
    image.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    image.frame = CGRectMake(10 , 15, self.frame.size.height - 30, self.frame.size.height - 30);
    
    image.layer.cornerRadius = image.frame.size.width /2;
    
    //image.backgroundColor = [UIColor blackColor];
    
    [self addSubview:image];
    
    
    //-----IMAGE
    
    
    //----------------ADJUST RATING BASED IN RECOMENDATIONS

    int totalRating = 0;
    int totalCounting = 0;
    
    
    
    for (int rr = 0; rr< _item.recomendaciones.count ; rr++){
        
        
        
        infoSourceModel * recomendacion = _item.recomendaciones[rr];
        
        NSNumber * filterValue = 0;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        filterValue = [defaults objectForKey:recomendacion.title];
        
        

        if (filterValue.intValue || filterValue==nil){
        
        totalRating = totalRating + recomendacion.rating;
        totalCounting++;
        }
        
     //   NSLog(@"RATE %@ %d",recomendacion.title,totalRating);
    }
    
    
    double roundRate = (double) totalRating / (double) totalCounting;
    
    _rating = round(roundRate);
    
    
    
   // NSLog(@"FINAL RATE  %d",_rating);

    
    //----------------ADJUST RATING BASED IN RECOMENDATIONS
    
    
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"finishedDownloading" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(downloadRating)
     name:@"finishedDownloading"
     object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateCell" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateCell:)
     name:@"updateCell"
     object:nil];
    
    //updateReviews
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateReviews" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(deleteCacheReview)
     name:@"updateReviews"
     object:nil];


    
   
    
   //---------DOWNLOAD RATING
    
    [self useCacheRating];

    
    if (didFinishLoading == true){

    [self downloadRating];
        
    }
    
    

}

-(void)useCacheRating{
    
    
    NSString * ratingKey = [NSString stringWithFormat:@"%@%@",@"rating",_item.politicianObject.objectId];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * ratingValue  = [defaults objectForKey:ratingKey];
    
    
    
    if (ratingValue != nil){
        
        
        _rating = ratingValue.intValue; // using cache
        
        [self rewriteRating];
    }
    
    if (ratingValue == nil){

        
        
    }
    
}


-(void)deleteCacheReview{
    
    
   // NSLog(@"DELETING RATING");
    
    //-----borrando rating
   // NSString * ratingKey = [NSString stringWithFormat:@"%@%@",@"rating",_item.politicianObject.objectId];

  //  [[NSUserDefaults standardUserDefaults] setObject:nil forKey:ratingKey];
    
    
}


-(void)updateCell:(NSNotification *)notification{
    
    NSNumber * tabNumber = notification.object;
    _currentTab = tabNumber.intValue;
    
    
    [self downloadRating];
    
}


-(void)rewriteRating{
    
    CGFloat starX = nombre.frame.origin.x;
    CGFloat starY = nombre.frame.origin.y + nombre.frame.size.height + 10 ;
    
    
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
}


-(void)downloadRating{
    
    

    
    if (scrollCurrentPage == _indexTab){
        
        
    //--------------checking if rating was cached
        
        
        NSString * ratingKey = [NSString stringWithFormat:@"%@%@",@"rating",_item.politicianObject.objectId];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber * ratingValue  = [defaults objectForKey:ratingKey];
        

    
    if (ratingValue != nil){
        
        
        _rating = ratingValue.intValue; // using cache

        [self rewriteRating];
    }
        
    if (ratingValue == nil){

    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
    NSMutableArray * ratingList = [[NSMutableArray alloc]init];
    
    PFQuery *rateQuery = [PFQuery queryWithClassName:@"Rating"];
    [rateQuery includeKey:@"politician"];
    [rateQuery includeKey:@"user"];
    //[rateQuery orderBySortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"vip" ascending:NO]];
    [rateQuery setLimit:10];
    
    [rateQuery whereKey:@"politician" equalTo:_item.politicianObject];
    
    [rateQuery findObjectsInBackgroundWithBlock:^(NSArray *preRatingList, NSError *error) {
    
        
        if (!error) {
            
            
            
        
        
        int noVipCount = 0;
        float avgRateNumber = 0;
            
        int VipCount = 0;
        float avgVipNumber = 0;
        
        
        _item.recomendacionesVIP = [[NSMutableArray alloc] init];
        _item.recomendacionesNOVIP = [[NSMutableArray alloc] init];
        
        
        for (int rr = 0; rr < preRatingList.count; rr++) {
            
            NSObject * rateObject = preRatingList[rr];
            
            
            PFObject * userObject = [rateObject valueForKey:@"user"];
            
            NSNumber * isVIP = [userObject objectForKey:@"vip"];
            if (isVIP.boolValue == true){
                
                infoSourceModel * rateModel = [[infoSourceModel alloc]init];
                rateModel.title = [userObject objectForKey:@"fbId"];
                rateModel.fbId = [userObject objectForKey:@"fbId"];
                
                NSNumber * rateNumber = [rateObject valueForKey:@"value"];
                
                rateModel.rating = rateNumber.intValue;
                rateModel.name = [userObject objectForKey:@"name"];
                
                rateModel.message = [rateObject valueForKey:@"message"];
                
                rateModel.isVip = [rateObject valueForKey:@"vip"];
                
                
                [ratingList addObject:rateModel];
                
                
                
                
                if (rateModel.fbId != nil){
                    NSNumber * filterValue = [defaults objectForKey:rateModel.fbId];
                    
                    
                    
                    if (filterValue.intValue || filterValue==nil){
                        
                        [_item.recomendacionesVIP addObject:rateModel];
                        
                        avgVipNumber = avgVipNumber + rateNumber.floatValue;
                        VipCount++;
                        

                        
                    }
                    
                }
                
                
            }else{
                
                NSNumber * rateNumber = [rateObject valueForKey:@"value"];
                
                
                //--------NO VIP
                
                
                
                
                infoSourceModel * rateModel = [[infoSourceModel alloc]init];
                rateModel.title = [userObject objectForKey:@"fbId"];
                rateModel.fbId = [userObject objectForKey:@"fbId"];
                
                rateModel.rating = rateNumber.intValue;
                rateModel.name = [userObject objectForKey:@"name"];
                rateModel.message = [rateObject valueForKey:@"message"];
                
                rateModel.isVip = [rateObject valueForKey:@"vip"];
                
                
                
                NSNumber * filterValue = [defaults objectForKey:@"todos"];
                
                
                
                if (filterValue.intValue || filterValue==nil){
                    
                    [_item.recomendacionesVIP addObject:rateModel];
                    
                    noVipCount++;
                    avgRateNumber = rateNumber.floatValue + avgRateNumber;


                    
                }
                
                
                
                
                
                
            }
            
            
            
            if (noVipCount > 0){
                infoSourceModel * rateTodos = [[infoSourceModel alloc]init];
                rateTodos.title = @"todos";
                rateTodos.rating = avgRateNumber / (float)noVipCount;
                [ratingList addObject:rateTodos];
            }
            
            
            
        }
            
            
            
        
            if (VipCount > 0 ){
            
                _rating = avgVipNumber / (float)VipCount;
                
            }
            if (noVipCount > 0){
                
                if (VipCount > 0){
                _rating = (_rating + (avgRateNumber / (float)noVipCount))/2;
                }else{
                _rating = (avgRateNumber / (float)noVipCount);

                }
            }
            
            
            //------------SAVING RATING
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[NSNumber numberWithInt:_rating] forKey:ratingKey];
            [defaults synchronize];
            
            //------------SAVING RATING

            
        
        _item.recomendaciones = [NSMutableArray arrayWithArray:ratingList];
    
       
            
            
            
            //NSLog(@"FINISHED DOWNLOADING RATING %d",_rating);

            [self rewriteRating];
            
        }else{
            
            NSLog(@"Error downloading Rating");
        }
    
    }];
    
     
    }//----cache rating
    
    }//----is on table
}

@end
