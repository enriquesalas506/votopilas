//
//  alertaCustomViewController.m
//  VotoPilas
//
//  Created by Jose on 6/25/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "loginFacebookViewController.h"
#import "M13Checkbox.h"
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "ValoracionesViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


#import "loginEmailViewController.h"





//#import <ParseFacebookUtilsV4/PFFacebookUtils.h>




@interface loginFacebookViewController ()

@end

@implementation loginFacebookViewController{
    
    
    UIView * whiteFrame;
    M13Checkbox *leftAlignment;
    
    
}



-(void)loadPantalla{
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    
    UIButton * back = [[UIButton alloc]init];
    back.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:back];
    [back addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchDown];
    
    
    
    
    whiteFrame = [[UIView alloc]init];
    whiteFrame.frame = CGRectMake((self.view.frame.size.width / 2) - 125.0, (self.view.frame.size.height / 2) - 125  , 250,275);
    whiteFrame.backgroundColor = [UIColor whiteColor];
    whiteFrame.clipsToBounds = true;
    whiteFrame.layer.cornerRadius = 10;
    [self.view addSubview:whiteFrame];
    
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:whiteFrame.bounds];
    whiteFrame.layer.masksToBounds = NO;
    whiteFrame.layer.shadowColor = [UIColor blackColor].CGColor;
    whiteFrame.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    whiteFrame.layer.shadowOpacity = 0.5f;
    whiteFrame.layer.shadowPath = shadowPath.CGPath;
    
    //----------------------
    
    UILabel * title = [[UILabel alloc]init];
    title.frame = CGRectMake(10, 0, whiteFrame.frame.size.width, 40);
    title.textColor = [UIColor blackColor];
    title.font = [UIFont fontWithName:@"Helvetica" size:14];
    [title setMinimumScaleFactor:6.0/title.font.pointSize];
    title.text = @"Valorar";
    title.textAlignment = NSTextAlignmentCenter;
    [whiteFrame addSubview:title];
    
    //167	167	167
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:(167.0 / 255.0) green:(167.0 / 255.0) blue:(167.0 / 255.0) alpha:1.0];
    line.frame = CGRectMake(10, title.frame.origin.y + title.frame.size.height, whiteFrame.frame.size.width - 20, 1);
    //[whiteFrame addSubview:line];
    
    //110	112	119
    UILabel * subtitle = [[UILabel alloc]init];
    subtitle.frame = CGRectMake(25, line.frame.origin.y + 2, whiteFrame.frame.size.width - 50, 75);
    subtitle.textColor = [UIColor colorWithWhite:(115.0 / 255.0) alpha:1];
    subtitle.font = [UIFont fontWithName:@"Helvetica" size:12];
    [subtitle setMinimumScaleFactor:6.0/title.font.pointSize];
    subtitle.text = @"Para poder valorar a este candidato necesitas Iniciar Sesión. No te preocupes, puedes hacerlo rápidamente.";
    subtitle.numberOfLines = 0;
    subtitle.textAlignment = NSTextAlignmentCenter;
    [whiteFrame addSubview:subtitle];
    
    
    CGFloat  omitirX = (whiteFrame.frame.size.width / 2) - 75;
    
    UIButton * omitir = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    omitir.frame = CGRectMake(omitirX, subtitle.frame.origin.y, 100, 50);
    omitir.titleLabel.font = [UIFont systemFontOfSize:12];
    
   // [omitir setTitle:@"Omitir" forState:UIControlStateNormal];
    omitir.titleLabel.textAlignment = NSTextAlignmentRight;
    omitir.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    [omitir addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    //91	157	255
    [omitir setTitleColor:[UIColor colorWithRed:(21.0 / 255.0) green:(123.0 / 255.0) blue:(255.0 / 255.0) alpha:1] forState:UIControlStateNormal];
    
   // [whiteFrame addSubview:omitir];
    
    
    
    CGFloat  loginX = (whiteFrame.frame.size.width / 2) - 100;
    CGFloat  loginW = (whiteFrame.frame.size.width / 2) - 20;
    
    
    UIButton * login = [[UIButton alloc] init];
    login.frame = CGRectMake(loginX, subtitle.frame.origin.y + subtitle.frame.size.height, 200, 50);
    [login setImage:[UIImage imageNamed:@"fb-button.png"] forState:UIControlStateNormal];
    [login.imageView setContentMode:UIViewContentModeScaleAspectFit];

    login.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    [login addTarget:self action:@selector(makeLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteFrame addSubview:login];
    
    
    
    
    
    UIButton * cancel = [[UIButton alloc] init];
    cancel.frame = CGRectMake(loginX, login.frame.origin.y + login.frame.size.height, 200, 50);
    [cancel setImage:[UIImage imageNamed:@"conituan-dark.png"] forState:UIControlStateNormal];
    [cancel.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    cancel.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    [cancel addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteFrame addSubview:cancel];
    
    
    //----------LOGIN EMAIL
    
    UIButton * loginEmail = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginEmail.frame = CGRectMake(loginX, cancel.frame.origin.y + cancel.frame.size.height , 200, 40);
    [loginEmail setTitle:@"Login usando Email" forState:UIControlStateNormal];
    
    loginEmail.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    [loginEmail addTarget:self action:@selector(logInUsingEmail) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteFrame addSubview:loginEmail];
    
    
    //----------LOGIN EMAIL

    
    //----------------------------
    
    

}

-(void) makeLogin{
    

    [PFFacebookUtils logInInBackgroundWithReadPermissions:@[ @"public_profile",@"email"] block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
            [self performSelector:@selector(userLoggedIn) withObject:nil afterDelay:0.25];
            //------------------------------
            
            
           
            
            if ([FBSDKAccessToken currentAccessToken]) {
                // User is logged in, do work such as go to next view controller.
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name"}] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
                 {
                     if (!error)
                     {
                         NSLog(@"%@",result);
                         NSLog(@"fetched user:%@  and Email : %@", result,result[@"email"]);
                        // NSLog(@"FBId %@",result[@"id"]);
                         
                         
                         
                         [user setObject:result[@"email"] forKey:@"email"];
                         [user setObject:result[@"id"] forKey:@"fbId"];
                         [user setObject:result[@"name"] forKey:@"name"];


                         // [user setObject:imageFile forKey:@"profilePicture"];
                         [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                             if (!error) {
                                 NSLog(  @"SUCCESS JOSE SUCCESS");
                                 
                             }
                         }];
                         
                         
                         
                     }
                 }];
                
            }

            
            //------------------------------
           
            
            
        } else {
            NSLog(@"User logged in through Facebook!");
            
             [self performSelector:@selector(userLoggedIn) withObject:nil afterDelay:0.25];
        }
    }];

    
    
}


-(void)logInUsingEmail{
  
      self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
      [self dismissViewControllerAnimated:true completion:^{
        
          [self openEmailLogin];
         // [self performSelector:@selector(openEmailLogin) withObject:nil afterDelay:0.25 ];

      }];
    
   
    
}

-(void)openEmailLogin{
    
    loginEmailViewController * logInEmail = [[loginEmailViewController alloc]init];
    logInEmail.controller = _controller;
    
    
    
   // _controller.navigationController.navigationBarHidden = true;
    [_controller.navigationController pushViewController:logInEmail animated:true];
    
    

}

-(void)userLoggedIn{
    
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"userLoggedInNotification"
     object:nil];// refresca los listados
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadPantalla];
    
    
    
 
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)closeView{

    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"omitirNotification"
     object:nil];// refresca los listados
    

    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:true completion:nil];
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
