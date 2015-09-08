//
//  logInViewController.m
//  VotoPilas
//
//  Created by Jose on 7/16/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "createAccountViewController.h"

#import "UIERealTimeBlurView.h"

#import "UIImage+Blur.h"

#import "loginFacebookViewController.h"

#import "ValoracionesViewController.h"


#import "MakeBlur.h"

#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "ValoracionesViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>





@interface createAccountViewController ()

@end

@implementation createAccountViewController

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
    
    
    
    UIImageView * votoPilas = [[UIImageView alloc]init];
    votoPilas.frame = CGRectMake((self.view.frame.size.width / 2) - 50, 50, 100, 100);
    votoPilas.image = [UIImage imageNamed:@"votoPilas.png"];
    votoPilas.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:votoPilas];
    
    UILabel * votoLabel = [[UILabel alloc ]init];
    votoLabel.frame = CGRectMake(0,votoPilas.frame.origin.y + votoPilas.frame.size.height, self.view.frame.size.width, 50);
    //186	204	202
    votoLabel.textColor = [UIColor colorWithRed:(186.0 / 255.0) green:(204.0 / 255.0) blue:(202.0 / 255.0) alpha:1.0];
    votoLabel.text = [@"HAZ QUE TU VOTO VALGA!" capitalizedString];
    votoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:votoLabel];
    
    
    
    CGFloat fieldSize = 200;
    CGFloat fieldH = 50;
    CGFloat fieldX = (self.view.frame.size.width / 2) - (fieldSize / 2);
    
    UIColor * placeHolderColor = [UIColor whiteColor];
    
    UITextField * userName = [[UITextField alloc]init];
    userName.frame = CGRectMake(fieldX, (self.view.frame.size.height / 2), fieldSize, fieldH);
    userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"USUARIO" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];
    
    userName.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:userName.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path  = maskPath.CGPath;
    userName.layer.mask = maskLayer;
    
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = self.view.bounds;
    borderLayer.path  = maskPath.CGPath;
    borderLayer.lineWidth   = 4.0f;
    borderLayer.strokeColor = [UIColor whiteColor].CGColor;
    borderLayer.fillColor   = [UIColor clearColor].CGColor;
    
    [userName.layer addSublayer:borderLayer];
    
    [self.view addSubview: userName];
    
    //-------------------------------
    
    UITextField * passwordField = [[UITextField alloc]init];
    passwordField.frame = CGRectMake(fieldX, userName.frame.origin.y + userName.frame.size.height - 2, fieldSize, fieldH);
    passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"CONTRASEÑA" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];
    
    passwordField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
    
    passwordField.secureTextEntry = true;
    
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:passwordField.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = self.view.bounds;
    maskLayer2.path  = maskPath2.CGPath;
    passwordField.layer.mask = maskLayer2;
    
    CAShapeLayer *borderLayer2 = [[CAShapeLayer alloc] init];
    borderLayer2.frame = self.view.bounds;
    borderLayer2.path  = maskPath2.CGPath;
    borderLayer2.lineWidth   = 4.0f;
    borderLayer2.strokeColor = [UIColor whiteColor].CGColor;
    borderLayer2.fillColor   = [UIColor clearColor].CGColor;
    
    [passwordField.layer addSublayer:borderLayer2];
    
    [self.view addSubview: passwordField];
    
    
    //-----------------------BOTON LOGIN
    
    UIButton * botonLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    botonLogin.frame = CGRectMake(fieldX, passwordField.frame.origin.y + passwordField.frame.size.height + 15, fieldSize, fieldH);
    //35	210	255
    //  botonLogin.backgroundColor = [UIColor colorWithRed:(35.0 / 255.0) green:(210.0 / 255.0) blue:(255.0 / 255.0) alpha:1.0];
    botonLogin.layer.borderWidth = 2.0;
    botonLogin.layer.borderColor = [UIColor whiteColor].CGColor;
    botonLogin.layer.cornerRadius = 10;
    [botonLogin setTitle:@"INGRESAR" forState:UIControlStateNormal];
    [botonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:botonLogin];
    
    
    UIButton * botonCrear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    botonCrear.frame = CGRectMake(fieldX, botonLogin.frame.origin.y + botonLogin.frame.size.height + 5, fieldSize, 50);
    //35	210	255
    //  botonLogin.backgroundColor = [UIColor colorWithRed:(35.0 / 255.0) green:(210.0 / 255.0) blue:(255.0 / 255.0) alpha:1.0];
    [botonCrear setTitle:@"Crear Cuenta" forState:UIControlStateNormal];
    // [botonCrear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:botonCrear];
    
    UIButton * botonCancelar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    botonCancelar.frame = CGRectMake(-5, 10, 100, 50);
    [botonCancelar setTitle:@"Cancelar" forState:UIControlStateNormal];
    [botonCancelar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:botonCancelar];
    
    
    
    
    
    
    
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
