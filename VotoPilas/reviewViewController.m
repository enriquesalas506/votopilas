//
//  reviewViewController.m
//  VotoPilas
//
//  Created by Jose on 7/23/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "reviewViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

extern CGFloat navHeight;


@interface reviewViewController ()

@end

@implementation reviewViewController{
    
    NSMutableArray * stars_array;
    UILabel * ratingLabel;
    
    UITextView * comentario;
    UIButton * enviar;
    
    int starRate;
}

extern UIView * statusBar;





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    starRate = 0;
    
    stars_array = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    
    //------------------------
    
    //----------------CIRCLE IMAGE
    
    PFUser * user = [PFUser currentUser];
    
    NSString * userImage = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[user objectForKey:@"fbId"]];
    
    UIImageView * circleView = [[UIImageView alloc]init];
    CGFloat radious = 70;
    CGFloat centerX = (self.view.frame.size.width / 2) - (radious / 2);
    CGFloat centerY = navHeight + 15;
    circleView.frame = CGRectMake(centerX, centerY, radious, radious);
    [circleView sd_setImageWithURL:[NSURL URLWithString:userImage]];
    
    circleView.layer.cornerRadius = (circleView.frame.size.width / 2);
    circleView.contentMode = UIViewContentModeScaleAspectFill;
    circleView.clipsToBounds = true;
    
    
    [self.view addSubview:circleView];
    
    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(0, circleView.frame.size.height + circleView.frame.origin.y + 10 , self.view.frame.size.width, 30);
    nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    nameLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    nameLabel.adjustsFontSizeToFitWidth = YES;
    nameLabel.minimumScaleFactor = 8.0 / nameLabel.font.pointSize;
    nameLabel.text = [user objectForKey:@"name"];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:nameLabel];
    
    //-------------------------------
    CGFloat starX = (self.view.frame.size.width / 2)- (40 * 2.5) + (30.0 / 4.0);
    CGFloat starY = nameLabel.frame.origin.y + (nameLabel.frame.size.height / 2) + (20) ;
    
    
    
    for (int ss = 0; ss< 5 ; ss++){
        
        
        UIButton * star = [[UIButton alloc]init];
        star.frame = CGRectMake(starX + (40 * ss), starY, 30, 30);
        
        [star addTarget:self action:@selector(starsRating:) forControlEvents:UIControlEventTouchDown];
        [star addTarget:self action:@selector(starsRating:) forControlEvents:UIControlEventTouchDragInside];
        [star addTarget:self action:@selector(starsRating:) forControlEvents:UIControlEventTouchDragEnter];
        [star addTarget:self action:@selector(starsRating:) forControlEvents:UIControlEventAllTouchEvents];



        
        [stars_array addObject:star];
        
        //[star setImage:[UIImage imageNamed:@"StarFilled.png"]];
        
        star.contentMode = UIViewContentModeScaleToFill;
        
        star.tag = ss;
        
        [self.view addSubview:star];
        
        [star setImage:[UIImage imageNamed:@"StarOutlined.png"] forState:UIControlStateNormal];
        [star setImage:[UIImage imageNamed:@"StarFilled.png"] forState:UIControlStateHighlighted];
        
        
        
        
    }
    
    
    ratingLabel = [[UILabel alloc]init];
    ratingLabel.frame = CGRectMake(0, starY + 40 , self.view.frame.size.width, 30);
    ratingLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    ratingLabel.textColor = [UIColor colorWithWhite:(163.0 / 255.0) alpha:1.0];
    ratingLabel.adjustsFontSizeToFitWidth = YES;
    ratingLabel.minimumScaleFactor = 8.0 / nameLabel.font.pointSize;
    //ratingLabel.text = @"Hola";
    ratingLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:ratingLabel];
    
    //-----------------
    
    comentario = [[UITextView alloc]init];
    comentario.text = @"Escriba un comentario";
    comentario.frame = CGRectMake(30, ratingLabel.frame.origin.y + ratingLabel.frame.size.height + 20, self.view.frame.size.width - 60, 100);
    comentario.backgroundColor = [UIColor colorWithWhite:(249.0 / 255.0) alpha:1.0];
    comentario.layer.borderWidth = 1.0;
    //197	197	197
    comentario.layer.borderColor = [UIColor colorWithWhite:(197.0 / 255.0) alpha:1.0].CGColor;
    comentario.layer.cornerRadius = 10;
    comentario.textColor = [UIColor colorWithWhite:(190.0 / 255.0) alpha:1.0];

    [comentario setReturnKeyType:UIReturnKeyDone];
    
    comentario.delegate =self;
    
    [self.view addSubview: comentario];
    
    
    //----------------------------
    
    enviar = [[UIButton alloc]init];
    
    enviar.frame = CGRectMake((self.view.frame.size.width / 2) - 100, comentario.frame.origin.y + comentario.frame.size.height + 25.0, 200, 50);
    
    //53	215	88
    enviar.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    
    
    [enviar setTitle:@"Enviar" forState:UIControlStateNormal];
    
    [enviar addTarget:self action:@selector(botonHover:) forControlEvents:UIControlEventTouchDown];
    [enviar addTarget:self action:@selector(botonNormal:) forControlEvents:UIControlEventTouchUpInside];
    [enviar addTarget:self action:@selector(botonNormal:) forControlEvents:UIControlEventTouchCancel];
    [enviar addTarget:self action:@selector(botonNormal:) forControlEvents:UIControlEventTouchDragExit];
    [enviar addTarget:self action:@selector(botonNormal:) forControlEvents:UIControlEventTouchDragOutside];
    [enviar addTarget:self action:@selector(sendRate) forControlEvents:UIControlEventTouchUpInside];


    
    enviar.layer.cornerRadius = enviar.frame.size.height / 2;
    
    [self.view addSubview:enviar];
    
    
    

}

-(void)sendRate{
    
    if ([comentario.text isEqualToString:@"Escriba un comentario"]){
        
        comentario.text = @"";
    }
    
    if (starRate == 0){
    UIAlertView * alert = [[UIAlertView alloc]init];
    
    alert.title = @"Ooops!";
    alert.message = @"Porfavor deja una califcación";
    [alert addButtonWithTitle:@"Aceptar"];
    
    [alert show];
        
    }else{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
        
        
        PFQuery * ratingQuery = [PFQuery queryWithClassName:@"Rating"];
        [ratingQuery whereKey:@"user" equalTo:[PFUser currentUser]];
        [ratingQuery whereKey:@"politician" equalTo:_politicalObject];
        
        NSArray * reviewList = [ratingQuery findObjects];
        
        if (reviewList.count >0){
            
            PFObject *rating = reviewList[0];
            rating[@"politician"] = _politicalObject;
            rating[@"value"] = [NSNumber numberWithInt:starRate];
            rating[@"user"] = [PFUser currentUser];
            rating[@"message"] = comentario.text;
            //rating[@"message"] = [NSString stringWithFormat:@"test %d",tt];
            
            [rating saveInBackground];

            
            
        }else{
        
        PFObject *rating = [PFObject objectWithClassName:@"Rating"];
        rating[@"politician"] = _politicalObject;
        rating[@"value"] = [NSNumber numberWithInt:starRate];
        rating[@"user"] = [PFUser currentUser];
        rating[@"message"] = comentario.text;
        //rating[@"message"] = [NSString stringWithFormat:@"test %d",tt];
        
        [rating saveInBackground];
        }
        
        [self performSelector:@selector(finishSending) withObject:nil afterDelay:1.0];

    }
    
}

-(void)finishSending{
    
    
    [self deleteCacheReview];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshSectionNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateReviews" object:nil];

    
    UIAlertView * alert = [[UIAlertView alloc]init];

    alert.title = @"Tu comentario ha sido enviado";
    alert.delegate = self;
    [alert addButtonWithTitle:@"Aceptar"];
    
    [alert show];
 
    
   
    
}

-(void)deleteCacheReview{
    
    
    NSLog(@"DELETING RATING");
    
    //-----borrando rating
    NSString * ratingKey = [NSString stringWithFormat:@"%@%@",@"rating",_politicalObject.objectId];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:ratingKey];
    
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if ([alertView.title isEqualToString:@"Tu comentario ha sido enviado"]){// not the best way to do it but it will do the trick...
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:true];
    [self.navigationController popViewControllerAnimated:true];
        
    }
    

    
}

-(void)botonHover:(UIButton *)boton{
    
    boton.alpha = 0.7;
}
-(void)botonNormal:(UIButton *)boton{
    
    boton.alpha = 1;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([comentario.text isEqualToString:@"Escriba un comentario"]){
        
        comentario.text = @"";
        comentario.textColor = [UIColor colorWithWhite:(60.0 / 255.0) alpha:1.0];

    }
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         
                         self.view.frame = CGRectMake(0, -self.view.frame.size.height / 4, self.view.frame.size.width, self.view.frame.size.height);

                     
                     }
                     completion:^(BOOL finished){
                     }];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    

    if([text isEqualToString:@"\n"]) {
        
        if ([comentario.text isEqualToString:@""]){
            
            comentario.text = @"Escriba un comentario";
            comentario.textColor = [UIColor colorWithWhite:(190.0 / 255.0) alpha:1.0];

        }
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                             
                             
                         }
                         completion:^(BOOL finished){
                         }];

        
        [textView resignFirstResponder];
        return NO;
    }

    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    
    statusBar.hidden = false;
    
    self.navigationController.navigationBar.backgroundColor =  [UIColor colorWithRed:(34.0 / 255.0) green:(175.0 / 255.0) blue:(241.0 / 255.0) alpha:1.0];
    
    
    
    
  

    
    
}

-(void)starsRating:(UIButton *)stars{
    
    
    starRate = stars.tag + 1;
    
    if (starRate != 0){
        
        enviar.backgroundColor = [UIColor colorWithRed:(53.0 / 255.0) green:(215.0 / 255.0) blue:(88.0 / 255.0) alpha:1.0];

    }
    
    if (starRate)
    
    
    if (stars.tag == 0){
        
        ratingLabel.text = @"Muy Malo!";
    }
    if (stars.tag == 1){
        
        ratingLabel.text = @"Malo";
    }
    if (stars.tag == 2){
        
        ratingLabel.text = @"Regular";
    }
    if (stars.tag == 3){
        
        ratingLabel.text = @"Bueno";
    }
    if (stars.tag == 4){
        
        ratingLabel.text = @"Muy Bueno!";
    }
    
    for (int ss = 0; ss < stars_array.count ; ss++){
        
        UIButton * objstar = stars_array[ss];
        
        if (ss <= stars.tag){
            
            
            [objstar setImage:[UIImage imageNamed:@"StarFilled.png"] forState:UIControlStateNormal];
            [objstar setImage:[UIImage imageNamed:@"StarFilled.png"] forState:UIControlStateHighlighted];
            
            
        }else{
            
            [objstar setImage:[UIImage imageNamed:@"StarOutlined.png"] forState:UIControlStateNormal];
            [objstar setImage:[UIImage imageNamed:@"StarFilled.png"] forState:UIControlStateHighlighted];
            
            
        }
        
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    statusBar.hidden = true;
    self.navigationController.navigationBar.backgroundColor =  [UIColor clearColor];
    
    UIView * gview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0, self.view.frame.size.width, 62)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gview.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0 alpha:1] CGColor], (id)[[UIColor colorWithWhite:0.3 alpha:0] CGColor], nil];
    [gview.layer insertSublayer:gradient atIndex:0];
    
    [self.view addSubview:gview];

    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
