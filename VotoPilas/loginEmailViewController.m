//
//  logInViewController.m
//  VotoPilas
//
//  Created by Jose on 7/16/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "loginEmailViewController.h"

#import "UIERealTimeBlurView.h"

#import "UIImage+Blur.h"

#import "loginFacebookViewController.h"

#import "ValoracionesViewController.h"


#import "MakeBlur.h"

#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "ValoracionesViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "createEmailViewController.h"

#import "MBProgressHUD.h"

#import <Parse/Parse.h>







@interface loginEmailViewController ()

@end

@implementation loginEmailViewController{
    
    CGFloat moveViewToY;
    UITextField * userName;
    UITextField * passwordField;

}


extern UIView * statusBar;
extern CGFloat navHeight;




-(void)viewWillAppear:(BOOL)animated{
    
    statusBar.hidden = true;
    self.navigationController.navigationBarHidden = true;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
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
    
    userName = [[UITextField alloc]init];
    userName.frame = CGRectMake(fieldX, (self.view.frame.size.height / 2), fieldSize, fieldH);
    userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"EMAIL O USUARIO" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];
    
    userName.textColor = [UIColor whiteColor];
    
    userName.autocapitalizationType = UITextAutocapitalizationTypeNone;

    
    userName.delegate = self;


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
    
    passwordField = [[UITextField alloc]init];
    passwordField.textColor = [UIColor whiteColor];

    passwordField.frame = CGRectMake(fieldX, userName.frame.origin.y + userName.frame.size.height - 2, fieldSize, fieldH);
    passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"CONTRASEÑA" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];
    
    passwordField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
    
    passwordField.secureTextEntry = true;
    
    passwordField.delegate = self;
    
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
    [botonLogin addTarget:self action:@selector(makeLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:botonLogin];
    
    
    UIButton * botonCrear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    botonCrear.frame = CGRectMake(fieldX, botonLogin.frame.origin.y + botonLogin.frame.size.height + 5, fieldSize, 50);
    //35	210	255
    //  botonLogin.backgroundColor = [UIColor colorWithRed:(35.0 / 255.0) green:(210.0 / 255.0) blue:(255.0 / 255.0) alpha:1.0];
    [botonCrear setTitle:@"Crear Cuenta" forState:UIControlStateNormal];
    [botonCrear addTarget:self action:@selector(crearCuenta) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:botonCrear];
     
     
    
    UIButton * botonCancelar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    botonCancelar.frame = CGRectMake(-5, 10, 100, 50);
    [botonCancelar setTitle:@"Cancelar" forState:UIControlStateNormal];
    [botonCancelar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [botonCancelar addTarget:self action:@selector(closeController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:botonCancelar];
    
    UIButton * botonRescate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    botonRescate.frame = CGRectMake(fieldX, botonCrear.frame.origin.y + botonCrear.frame.size.height + 5, fieldSize, 50);
    [botonRescate setTitle:@"Recuperar Contraseña" forState:UIControlStateNormal];
    [botonRescate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [botonRescate addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:botonRescate];


    NSLog(@"HOLA");

    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    
    
    
    
}

-(void)resetPassword{
    
    
    if (![userName.text isEqualToString:@""]){
       
        [PFUser requestPasswordResetForEmailInBackground:userName.text];
        
        [self displayMessage:@"Se ha enviado una solicitud de reinicio de contraseña a tu email"];
        
        
    }else{
        
        [self displayMessage:@"Por favor ingresa tu usuario"];
    }
    
}

//[PFUser requestPasswordResetForEmailInBackground:@"email@example.com"];
-(void)makeLogin{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    PFUser * user = [[PFUser alloc]init];
    [PFUser logInWithUsernameInBackground:userName.text password:passwordField.text block:^(PFUser *user, NSError *error) {
        if (!error) {
            //do stuff with user
            //NSLog(@"USER LOGGED IN");
            [self displayMessage:@"Has ingresado satisfactoriamente"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:true];
            [self userLoggedIn];
            
            
        } else {
            //error handling here
            NSLog(@"USER DIDNT LOG IN");
            [self displayMessage:@"Error al ingresar a la cuenta"];

            [MBProgressHUD hideAllHUDsForView:self.view animated:true];
            
        }
        
    }];
    
}

-(void)userLoggedIn{
    
    
    //waitRemovePartido
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"changeRootNotificaion"
     object:nil];// refresca los listados
    
    if (_controller == nil){
        
        [self dismissViewControllerAnimated:true completion:nil];
    }
    

    
    [self.navigationController popToViewController:_controller animated:true];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"userLoggedInNotification"
     object:nil];// refresca los listados
    
    
}

-(void)displayMessage:(NSString *)message{
    
    NSLog(@"MENSAJE");
    
    UIAlertView * alert = [[UIAlertView alloc]init];
    alert.title = message;
    [alert addButtonWithTitle:@"Aceptar"];
    [alert show];
    
}

-(void)crearCuenta{
    
    createEmailViewController * createEmail = [[createEmailViewController alloc]init];
    createEmail.controller = _controller;
    [self.navigationController pushViewController:createEmail animated:true];
}

-(void)closeController{
    
    NSLog(@"CLOSSE CONTROLLER");

    self.navigationController.navigationBarHidden = false;
    [self.navigationController popViewControllerAnimated:true];
    
    if (_controller == nil){
        
        [self dismissViewControllerAnimated:true completion:nil];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    // currentTextField = textField;
    moveViewToY = self.view.frame.size.height - ( textField.frame.origin.y + textField.frame.size.height);
    
    return true;
}

-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
    
    [UIView animateWithDuration:0.20
                     animations:^{
                         
                         
                         CGFloat moveKeyboard = -keyboardFrame.size.height  + moveViewToY - 25;
                         
                         self.view.frame = CGRectMake(0, moveKeyboard, self.view.frame.size.width, self.view.frame.size.height);
                         
                         
                         
                     } completion:^(BOOL finished) {
                     }];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
}

-(void)animateViewToDefault{
    
    
    [UIView animateWithDuration:0.25
                          delay:0.1
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         
                         CGFloat moveKeyboard = navHeight;
                         
                         self.view.frame = CGRectMake(0, moveKeyboard, self.view.frame.size.width, self.view.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                     }];
    
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    [self reserViewAnimation];
    
    return YES;
}

-(void)reserViewAnimation{
    
    
    [UIView animateWithDuration:0.25
                          delay:0.1
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         
                         CGFloat moveKeyboard = navHeight;
                         
                         self.view.frame = CGRectMake(0, -0, self.view.frame.size.width, self.view.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                     }];
    
}



@end
