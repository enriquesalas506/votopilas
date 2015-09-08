//
//  logInViewController.m
//  VotoPilas
//
//  Created by Jose on 7/16/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "createEmailViewController.h"

#import "UIERealTimeBlurView.h"

#import "UIImage+Blur.h"

#import "loginFacebookViewController.h"

#import "ValoracionesViewController.h"


#import "MakeBlur.h"

#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "ValoracionesViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "MBProgressHUD.h"





@interface createEmailViewController ()

@end

@implementation createEmailViewController{
    
    CGFloat moveViewToY;
    
    UITextField * userName;
    UITextField * nameField;
    UITextField * lastnameField;
    UITextField * passwordField;
    UITextField * repeatField;

}

extern UIView * statusBar;

extern CGFloat navHeight;




-(void)viewWillAppear:(BOOL)animated{
    
    

    statusBar.hidden = true;
   
    

    
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
    
    
    
    CGFloat fieldSize = 200;
    CGFloat fieldH = 50;
    CGFloat fieldX = (self.view.frame.size.width / 2) - (fieldSize / 2);
    
    UIColor * placeHolderColor = [UIColor whiteColor];

    
    userName = [[UITextField alloc]init];
    userName.frame = CGRectMake(fieldX, 75, fieldSize, fieldH);
    userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"USUARIO O EMAIL" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];
    
    userName.textColor = [UIColor whiteColor];
    
    userName.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
    
    userName.autocapitalizationType = UITextAutocapitalizationTypeNone;

    
    userName.delegate = self;
    
    
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
    
    //----------------
    
    nameField = [[UITextField alloc]init];
    nameField.frame = CGRectMake(fieldX, userName.frame.origin.y + userName.frame.size.height -2, fieldSize, fieldH);
    nameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"NOMBRE" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];
    nameField.layer.borderColor = [UIColor whiteColor].CGColor;
    nameField.layer.borderWidth = 2;
    
    nameField.textColor = [UIColor whiteColor];

    
    nameField.delegate = self;

    
    nameField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
    
    
    
    [self.view addSubview: nameField];
    
    
    lastnameField = [[UITextField alloc]init];
    lastnameField.frame = CGRectMake(fieldX, nameField.frame.origin.y + nameField.frame.size.height -2, fieldSize, fieldH);
    lastnameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"APELLIDO" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];
    
    lastnameField.layer.borderColor = [UIColor whiteColor].CGColor;
    lastnameField.layer.borderWidth = 2;
    
    lastnameField.delegate = self;
    
    lastnameField.textColor = [UIColor whiteColor];



    
    lastnameField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
    
    
    
    [self.view addSubview: lastnameField];

    
    
    
    //-------------------------------
    
    passwordField = [[UITextField alloc]init];
    passwordField.frame = CGRectMake(fieldX, lastnameField.frame.origin.y + lastnameField.frame.size.height - 2, fieldSize, fieldH);
    passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"CONTRASEÑA" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];
    
    passwordField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
    
    passwordField.secureTextEntry = true;
    
    passwordField.delegate = self;
    
    passwordField.textColor = [UIColor whiteColor];


    
    passwordField.layer.borderColor = [UIColor whiteColor].CGColor;
    passwordField.layer.borderWidth = 2;

    
    [self.view addSubview: passwordField];
    
    
    repeatField = [[UITextField alloc]init];
    repeatField.frame = CGRectMake(fieldX, passwordField.frame.origin.y + passwordField.frame.size.height - 2, fieldSize, fieldH);
    repeatField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"REPETIR CONTRASEÑA" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];
    
    repeatField.textAlignment = NSTextAlignmentCenter; // Pre-iOS6 SDK: UITextAlignmentCenter
    
    repeatField.secureTextEntry = true;
    
    repeatField.delegate = self;
    
    repeatField.textColor = [UIColor whiteColor];


    
    [self.view addSubview: repeatField];

    
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:repeatField.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = self.view.bounds;
    maskLayer2.path  = maskPath2.CGPath;
    repeatField.layer.mask = maskLayer2;
    
    CAShapeLayer *borderLayer2 = [[CAShapeLayer alloc] init];
    borderLayer2.frame = self.view.bounds;
    borderLayer2.path  = maskPath2.CGPath;
    borderLayer2.lineWidth   = 4.0f;
    borderLayer2.strokeColor = [UIColor whiteColor].CGColor;
    borderLayer2.fillColor   = [UIColor clearColor].CGColor;
    
    [repeatField.layer addSublayer:borderLayer2];

    
    
    //-----------------------BOTON LOGIN
    
    UIButton * botonLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    botonLogin.frame = CGRectMake(fieldX, repeatField.frame.origin.y + repeatField.frame.size.height + 15, fieldSize, fieldH);
    //35	210	255
    //  botonLogin.backgroundColor = [UIColor colorWithRed:(35.0 / 255.0) green:(210.0 / 255.0) blue:(255.0 / 255.0) alpha:1.0];
    botonLogin.layer.borderWidth = 2.0;
    botonLogin.layer.borderColor = [UIColor colorWithRed:(35.0 / 255.0) green:(210.0 / 255.0) blue:(255.0 / 255.0) alpha:1.0].CGColor;
    botonLogin.layer.cornerRadius = 10;
    [botonLogin setTitle:@"CREAR CUENTA" forState:UIControlStateNormal];
    [botonLogin setTitleColor:[UIColor colorWithRed:(35.0 / 255.0) green:(210.0 / 255.0) blue:(255.0 / 255.0) alpha:1.0] forState:UIControlStateNormal];
    [botonLogin addTarget:self action:@selector(createUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:botonLogin];
    
    
    UIButton * botonCancelar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    botonCancelar.frame = CGRectMake(-5, 10, 100, 50);
    [botonCancelar setTitle:@"Cancelar" forState:UIControlStateNormal];
    [botonCancelar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [botonCancelar addTarget:self action:@selector(closeController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:botonCancelar];
    
    
    NSLog(@"HOLA");
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    

    
    
    
    
}

-(void)createUser{
    
    
    if (![userName.text isEqualToString:@""]){
        if (![passwordField.text isEqualToString:@""]){
    if ([passwordField.text isEqualToString:repeatField.text] ){
    
    PFUser *user = [PFUser user];
    user.username = userName.text;
    user.password = passwordField.text;
    user.email = userName.text;
    
    // other fields can be set just like with PFObject
    user[@"name"] = [NSString stringWithFormat:@"%@ %@",nameField.text,lastnameField.text];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:true];

    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:true];

        if (!error) {   // Hooray! Let them use the app now.
            
            [self displayMessage:@"Tu cuenta ha sido creada"];
            [self userLoggedIn];
        }
        else {   NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
                 [self displayMessage:errorString];
        }
    }];

    }else{
        
        [self displayMessage:@"La Contraseña y repetir Contraseña deben ser iguales"];
    }
        
    }else{
            
        [self displayMessage:@"La Contraseña no deber ir vacía"];
    }
        
    }else{
        
        
        [self displayMessage:@"El campo Usuario no debe ir vacío"];
        
    }
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


-(void)closeController{
    
    NSLog(@"CLOSSE CONTROLLER");
    
    self.navigationController.navigationBarHidden = false;
    [self.navigationController popViewControllerAnimated:true];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
