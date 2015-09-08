//
//  alertaCustomViewController.m
//  VotoPilas
//
//  Created by Jose on 6/25/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "alertaCustomViewController.h"
#import "M13Checkbox.h"

@interface alertaCustomViewController ()

@end

@implementation alertaCustomViewController{
    
    
    UIView * whiteFrame;
    M13Checkbox *leftAlignment;

    
}

-(void)cancelAction{
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
    
    
    UIButton * back = [[UIButton alloc]init];
    back.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:back];
    [back addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchDown];
    
    
    whiteFrame = [[UIView alloc]init];
    whiteFrame.frame = CGRectMake((self.view.frame.size.width / 2) - 125, (self.view.frame.size.height / 2) - 100  , 250,150);
    whiteFrame.backgroundColor = [UIColor whiteColor];
    whiteFrame.clipsToBounds = true;
    whiteFrame.layer.cornerRadius = 0;
    [self.view addSubview:whiteFrame];
    
    
    //-----------SOMBRA
    
    
    // border
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:whiteFrame.bounds];
    whiteFrame.layer.masksToBounds = NO;
    whiteFrame.layer.shadowColor = [UIColor blackColor].CGColor;
    whiteFrame.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    whiteFrame.layer.shadowOpacity = 0.5f;
    whiteFrame.layer.shadowPath = shadowPath.CGPath;
    //-----------SOMBRA
    
    
    //----------------------
    
    UILabel * title = [[UILabel alloc]init];
    title.frame = CGRectMake(20, 0, whiteFrame.frame.size.width - 40, 40);
    title.textColor = [UIColor blackColor];
    title.font = [UIFont fontWithName:@"Helvetica" size:14];
    [title setMinimumScaleFactor:6.0/title.font.pointSize];
    title.text = _mainTitle;
    [whiteFrame addSubview:title];
    
    //167	167	167
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:(167.0 / 255.0) green:(167.0 / 255.0) blue:(167.0 / 255.0) alpha:1.0];
    line.frame = CGRectMake(10, title.frame.origin.y + title.frame.size.height, whiteFrame.frame.size.width - 20, 1);
   // [whiteFrame addSubview:line];
    
    UILabel * subtitle = [[UILabel alloc]init];
    subtitle.frame = CGRectMake(10, line.frame.origin.y + 2, whiteFrame.frame.size.width - 20, 30);
    subtitle.textColor = [UIColor redColor];
    subtitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [subtitle setMinimumScaleFactor:6.0/title.font.pointSize];
    subtitle.text = _subtitle;
  //  [whiteFrame addSubview:subtitle];
    
    
    UITextView * message = [[UITextView alloc]init];
    message.frame = CGRectMake(10, title.frame.size.height, whiteFrame.frame.size.width - 20, 100);
    message.textColor = [UIColor colorWithWhite:(135.0 / 255.0) alpha:1.0];
    message.font = [UIFont fontWithName:@"Helvetica" size:12];
    message.text = _message;
    message.scrollEnabled = false;
    message.selectable = false;
    message.editable = false;
    [whiteFrame addSubview:message];
    
    
    
    //-----CHECK BOX
    
    //Left Alignment
   leftAlignment = [[M13Checkbox alloc] initWithTitle:_boxMessage];
    leftAlignment.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    //80	127	138
    leftAlignment.titleLabel.textColor = [UIColor colorWithRed:(80.0 / 255.0) green:(127.0 / 255.0) blue:(138.0 / 255.0) alpha:1.0];
    
    [leftAlignment setCheckAlignment:M13CheckboxAlignmentLeft];
    leftAlignment.frame = CGRectMake(10, whiteFrame.frame.size.height - 100, whiteFrame.frame.size.width - 20, 50);
   // [whiteFrame addSubview:leftAlignment];
    
    UIView * line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithRed:(167.0 / 255.0) green:(167.0 / 255.0) blue:(167.0 / 255.0) alpha:1.0];
    line1.frame = CGRectMake(10, leftAlignment.frame.origin.y + leftAlignment.frame.size.height + 1, whiteFrame.frame.size.width - 20, 1);
    //[whiteFrame addSubview:line1];
    
    UIButton * okButton = [[UIButton alloc]init];
    //okButton.backgroundColor = [UIColor redColor];
    okButton.frame = CGRectMake(whiteFrame.frame.size.width - 100, whiteFrame.frame.size.height - 40, 100, 25);
    [okButton setTitle:@"Aceptar" forState:UIControlStateNormal];
    [okButton.titleLabel setFont:[okButton.titleLabel.font fontWithSize:12] ];
    
    //61	96	208
    [okButton setTitleColor:[UIColor colorWithRed:(61.0 /255.0) green:(96.0 /255.0) blue:(208.0 /255.0) alpha:(1.0)] forState:UIControlStateNormal];
    //126	195	252
    [okButton setTitleColor:[UIColor colorWithRed:(126.0 /255.0) green:(195.0 /255.0) blue:(252.0 /255.0) alpha:(1.0)] forState:UIControlStateHighlighted];

    [whiteFrame addSubview:okButton];
    
    [okButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
     
     
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)closeView{
    
    
    //waitRemovePartido
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"waitRemovePartido"
     object:nil];// refresca los listados

    
    if ( [leftAlignment checkState] == M13CheckboxStateChecked){
        
       // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // to store
       // [defaults setObject:[NSNumber numberWithInt:1] forKey:_statusKey];
       // [defaults synchronize];
    }
    
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
