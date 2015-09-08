//
//  configurationNewViewController.m
//  VotoPilas
//
//  Created by Jose on 7/23/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "configurationNewViewController.h"
#import "configurationTableViewCell.h"
#import "ValoracionesViewController.h"
#import "globalVars.h"
#import <Parse/Parse.h>


extern CGFloat navHeight;
extern UIView * statusBar;



@interface configurationNewViewController ()

@end

@implementation configurationNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//234	233	239
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor colorWithWhite:(239.0 / 255.0) alpha:1.0];
    
    
    UITableView * tabla = [[UITableView alloc]init];
    tabla.frame = CGRectMake(0, navHeight + 25, self.view.frame.size.width, 80);
    tabla.scrollEnabled = false;
    tabla.delegate = self;
    tabla.dataSource = self;
    
    [self.view addSubview:tabla];
    
    
    UIButton * restablecer = [[UIButton alloc]init];
    restablecer.frame = CGRectMake(20, tabla.frame.origin.y + tabla.frame.size.height + 25, self.view.frame.size.width - 40.0, 50);
    
    //53	215	88
    restablecer.backgroundColor = [UIColor colorWithRed:(53.0 / 255.0) green:(215.0 / 255.0) blue:(88.0 / 255.0) alpha:1.0];
    restablecer.layer.cornerRadius = restablecer.frame.size.height / 2;
    [restablecer setTitle:@"Restablecer Partidos Descartados" forState:UIControlStateNormal];
    
    [restablecer.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    
    [restablecer addTarget:self action:@selector(botonHover:) forControlEvents:UIControlEventTouchDown];
    [restablecer addTarget:self action:@selector(botonNormal:) forControlEvents:UIControlEventTouchUpInside];
    [restablecer addTarget:self action:@selector(botonNormal:) forControlEvents:UIControlEventTouchCancel];
    [restablecer addTarget:self action:@selector(botonNormal:) forControlEvents:UIControlEventTouchDragExit];
    [restablecer addTarget:self action:@selector(botonNormal:) forControlEvents:UIControlEventTouchDragOutside];
    
    [restablecer addTarget:self action:@selector(resetToDefaults) forControlEvents:UIControlEventTouchUpInside];
    

    
    [self.view addSubview:restablecer];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    

    
      self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    
    
    // Do any additional setup after loading the view.
}


-(void)resetToDefaults{
    
    NSLog(@"RESETING");
    
    [self.navigationController popViewControllerAnimated:true];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:ResetToDefaultsNotification
     object:nil];
}

-(void)botonHover:(UIButton *)boton{
    
    boton.alpha = 0.7;
}
-(void)botonNormal:(UIButton *)boton{
    
    boton.alpha = 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    configurationTableViewCell * cell = [[configurationTableViewCell alloc]init];
    
    if (indexPath.row == 0){
        cell.titulo = @"Elegir Valoraciones";
        
    }
    if (indexPath.row == 1){
        
        if ([ PFUser currentUser]){
        cell.titulo = @"Cerrar Sesión";
        }else{
            
            cell.titulo = @"Iniciar Sesión";
        }
            
            
            
    }
    
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated{
    
    statusBar.hidden = false;
    
      self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.backgroundColor =  [UIColor colorWithRed:(34.0 / 255.0) green:(175.0 / 255.0) blue:(241.0 / 255.0) alpha:1.0];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
   /*
    statusBar.hidden = true;
    self.navigationController.navigationBar.backgroundColor =  [UIColor clearColor];
    
    UIView * gview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0, self.view.frame.size.width, 62)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gview.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0 alpha:1] CGColor], (id)[[UIColor colorWithWhite:0.3 alpha:0] CGColor], nil];
    [gview.layer insertSublayer:gradient atIndex:0];
    
    [self.view addSubview:gview];*/
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
        
        ValoracionesViewController * valoraciones = [[ValoracionesViewController alloc]init];
        [self.navigationController pushViewController:valoraciones animated:true];
        
        
    }
    
    if (indexPath.row == 1){
        
        [self logOut];
        
    }
}

-(void)logOut{
    
    [PFUser logOut];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"logInNotification"
     object:nil];// refresca los listados
    
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
