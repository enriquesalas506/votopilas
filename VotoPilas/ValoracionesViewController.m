//
//  ValoracionesViewController.m
//  VotoPilas
//
//  Created by Jose on 7/16/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "ValoracionesViewController.h"


#import "valoracionesManager.h"
#import "valoracionesItem.h"
#import "valoracionesVIPmodel.h"

@interface ValoracionesViewController ()

@end

@implementation ValoracionesViewController{
    
    
    NSMutableArray * list;
    UIScrollView * scroll;
}


-(void)clearValoraciones{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //42	132	255
    
    [self clearValoraciones];
    
    
    list = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = true;
    
    
    
    scroll = [[UIScrollView alloc]init];
    CGFloat scrollY =  50;
    CGFloat scrollH = self.view.frame.size.height - (scrollY );
    scroll.frame = CGRectMake(0, scrollY, self.view.frame.size.width, scrollH );
    [self.view addSubview:scroll];
    //---------------------------------------------------------------------------
    
    
    UIButton * boton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [boton setTitle:@"Continuar" forState:UIControlStateNormal];
    [boton addTarget:self action:@selector(goToMainScreen) forControlEvents:UIControlEventTouchUpInside];
    boton.frame = CGRectMake(self.view.frame.size.width - 100 - 15, 25, 100, 50);
    [self.view addSubview:boton];
    
    
    UILabel * titulo = [[UILabel alloc]init];
    titulo.text = @"Las valoraciones son importantes \n en Votopilas";
    titulo.font = [titulo.font fontWithSize:16.0];
    titulo.numberOfLines = 5;
    titulo.lineBreakMode = NSLineBreakByWordWrapping;
    titulo.textAlignment = NSTextAlignmentCenter;
    titulo.frame = CGRectMake(25, 50, self.view.frame.size.width - 50, 60);
    [scroll addSubview: titulo];
    
    UILabel * subTitulo = [[UILabel alloc]init];
    subTitulo.text = @"¿Que opinion deseas ver?";
    subTitulo.font = [titulo.font fontWithSize:14.0];
    subTitulo.numberOfLines = 5;
    subTitulo.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    subTitulo.lineBreakMode = NSLineBreakByWordWrapping;
    subTitulo.textAlignment = NSTextAlignmentCenter;
    subTitulo.frame = CGRectMake(25, titulo.frame.origin.y + titulo.frame.size.height , self.view.frame.size.width - 50, 30);
    [scroll addSubview: subTitulo];

    //scroll.backgroundColor = [UIColor redColor];
    
    
    [valoracionesManager downloadUsers:^(NSMutableArray * array)  {
        
        NSLog(@"ARRAY OF VIP USERS %@",array);
        
        
        valoracionesVIPmodel * item = [[valoracionesVIPmodel alloc]init];
        item.name = @"Publico en General";
        item.facebookId = @"todos";
        
        [list addObject:item];

        
        for (int xx = 0; xx < array.count; xx++) {
            
            PFUser * user = array[xx];
            valoracionesVIPmodel * item = [[valoracionesVIPmodel alloc]init];
            item.name = [user objectForKey:@"name"];
            item.facebookId = [user objectForKey:@"fbId"];
            
            [list addObject:item];
        }
        
        [self makeMagic];
    
    }];
    
    
    
    
    
}

-(void)goToMainScreen{
    
    //waitRemovePartido
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"changeRootNotificaion"
     object:nil];// refresca los listados
    
    //refreshFilterNotification
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"refreshFilterNotification"
     object:nil];// refresca los listados

    
    self.navigationController.navigationBarHidden = false;
    [self.navigationController popViewControllerAnimated:true];
    

    
}

-(void)makeMagic{
    
    
    int yy = 0;
    int xxx = 1;
    NSLog(@"LIST COUNT %d",list.count);
    for (int xx=1; xx < list.count + 1; xx++) {
        
        valoracionesItem * item = [[valoracionesItem alloc]init];
        CGFloat itemW = (self.view.frame.size.width / 2) - 50;
        
        valoracionesVIPmodel * model = list[xx -1];
        item.name = model.name;
        item.facebookId = model.facebookId;
        
       
        

        
        CGFloat itemY = ((itemW + 10) * yy)  + 200;
        CGFloat itemX = (self.view.frame.size.width / 4) * xxx;

        
        item.frame = CGRectMake(itemX - (itemW / 2), itemY, itemW, itemW);
        
         xxx = xxx + 2;
        
        if (xxx > 3){
            xxx = 1;
        }
        
        
        if (xx % 2 ==0){
            yy ++;
        }

        scroll.contentSize = CGSizeMake(self.view.frame.size.width, itemY + itemW);
        
        
        [scroll addSubview:item];
        
    }
    
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
