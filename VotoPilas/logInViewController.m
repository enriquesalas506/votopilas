//
//  logInViewController.m
//  VotoPilas
//
//  Created by Jose on 7/16/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "logInViewController.h"

#import "UIERealTimeBlurView.h"

#import "UIImage+Blur.h"

#import "loginFacebookViewController.h"

#import "ValoracionesViewController.h"



#import "MakeBlur.h"

#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "ValoracionesViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


#import "loginEmailViewController.h"





@interface logInViewController ()

@end

@implementation logInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:(42.0 / 255.0) green:(132.0 / 255.0) blue:(255.0 / 255.0) alpha:1.0];
    
    //2	32	135
    self.navigationController.navigationBar.barTintColor =  [UIColor colorWithRed:(2.0 / 255.0) green:(32.0 / 255.0) blue:(135.0 / 255.0) alpha:1.0];
    self.navigationController.navigationBar.topItem.title = @"Valoraciones";
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBarHidden = YES;
    
    
    //--------------------------------
    
  
    
    UIImageView * voto = [[UIImageView alloc]init];
    voto.image = [UIImage imageNamed:@"login-img.png"];
    voto.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    voto.contentMode = UIViewContentModeScaleToFill;
     [self.view addSubview:voto];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"omitirNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(omitirBoton)
     name:@"omitirNotification"
     object:nil];
    

    
    //userLoggedInNotification
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userLoggedInNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(goToValoraciones)
     name:@"userLoggedInNotification"
     object:nil];

    
    
    //-------------------------
   
    
    
    UIButton * fbButton = [[UIButton alloc]init];
    fbButton.frame = CGRectMake((self.view.frame.size.width/ 2) - 100, (self.view.frame.size.height / 2) + 50, 200, 50);
    [fbButton setImage:[UIImage imageNamed:@"fb-button.png"] forState:UIControlStateNormal];
    [fbButton addTarget:self action:@selector(makeLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fbButton];
    
    
    UIButton * continueButton = [[UIButton alloc]init];
    continueButton.frame = CGRectMake((self.view.frame.size.width/ 2) - 100, fbButton.frame.origin.y + fbButton.frame.size.height, 200, 50);
    [continueButton setImage:[UIImage imageNamed:@"conitinue-button.png"] forState:UIControlStateNormal];
    [self.view addSubview:continueButton];
    
    [continueButton addTarget:self action:@selector(changeRoot) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * votoLabel = [[UILabel alloc ]init];
    votoLabel.frame = CGRectMake(0, fbButton.frame.origin.y - 100, self.view.frame.size.width, 50);
    //186	204	202
    votoLabel.textColor = [UIColor colorWithRed:(186.0 / 255.0) green:(204.0 / 255.0) blue:(202.0 / 255.0) alpha:1.0];
    votoLabel.text = [@"HAZ QUE TU VOTO VALGA!" capitalizedString];
    votoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:votoLabel];
    
    UIImageView * votoPilas = [[UIImageView alloc]init];
    votoPilas.frame = CGRectMake((self.view.frame.size.width / 2) - 50, votoLabel.frame.origin.y - 100, 100, 100);
    votoPilas.image = [UIImage imageNamed:@"votoPilas.png"];
    votoPilas.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:votoPilas];
    
    
    
    CGFloat  loginX = (self.view.frame.size.width / 2) - 100;
    CGFloat  loginW = (self.view.frame.size.width / 2) - 20;
    

    
    UIButton * loginEmail = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginEmail.frame = CGRectMake(loginX, continueButton.frame.origin.y + continueButton.frame.size.height + 15 , 200, 40);
    [loginEmail setTitle:@"Login usando Email" forState:UIControlStateNormal];
    
    loginEmail.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    [loginEmail addTarget:self action:@selector(logInUsingEmail) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginEmail];
    

    
 
    
}

-(void)logInUsingEmail{
    
    
        [self openEmailLogin];
        // [self performSelector:@selector(openEmailLogin) withObject:nil afterDelay:0.25 ];
        
    
    
    
}
-(void)openEmailLogin{
    
    
    
    loginEmailViewController * logInEmail = [[loginEmailViewController alloc]init];
    
    UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:logInEmail];
    
    
    [self presentViewController:navController animated:true completion:nil];
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"omitirNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userLoggedInNotification" object:nil];


}


-(void)goToValoraciones{
    
    ValoracionesViewController * valoracion = [[ValoracionesViewController alloc]init];
    
    [self.navigationController pushViewController:valoracion animated:true];
    
}

-(void)omitirBoton{
    
    [self performSelector:@selector(changeRoot) withObject:nil afterDelay:0.25];

    
}

-(void)changeRoot{
    
    //waitRemovePartido
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"changeRootNotificaion"
     object:nil];// refresca los listados

    
}

-(void)viewDidAppear:(BOOL)animated{
    
   // [self popFacebook];
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

-(void)userLoggedIn{
    
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"userLoggedInNotification"
     object:nil];// refresca los listados
    
  //  [self changeRoot];
    
    
}

-(void)popFacebook{
    
    loginFacebookViewController * customAlerta = [[loginFacebookViewController alloc]init];
    
    
   
    
    if ([[UIDevice currentDevice].systemVersion integerValue] >= 8 )
    {
        //For iOS 8
        self.providesPresentationContextTransitionStyle = true;
        self.definesPresentationContext = true;
        customAlerta.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        customAlerta.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    else
    {
        //For iOS 7
        customAlerta.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    
    [self presentViewController:customAlerta animated:true completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
