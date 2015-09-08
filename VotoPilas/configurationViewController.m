//
//  configurationViewController.m
//  VotoPilas
//
//  Created by Jose on 6/23/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "configurationViewController.h"
#import "globalVars.h"
#import "customSourceTableViewCell.h"

@interface configurationViewController ()

@end

@implementation configurationViewController{
    
    UITableView * tabla;
    UIScrollView * scroll;
}


extern CGFloat navHeight;
extern NSMutableArray * ratingList;
//ratingList




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    
    scroll = [[UIScrollView alloc]init];
    
    scroll.userInteractionEnabled = YES;
    scroll.exclusiveTouch = YES;
    scroll.canCancelContentTouches = YES;
    scroll.delaysContentTouches = YES;
    
    
    scroll.frame = CGRectMake(0,navHeight , self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview: scroll];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //Helvetica
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.navigationItem.title = @"Configuración";
    
    
    //------------------------------SetUp

    
    UILabel * subtitle = [[UILabel alloc]init];
    subtitle.frame = CGRectMake(20,0 , self.view.frame.size.width - 50, 50);
    subtitle.font = [UIFont fontWithName:@"Helvetica" size:16];
    subtitle.text = @"Valoraciones a tomar en cuenta";
    
    [scroll addSubview:subtitle];
    
    UIView * line = [[UIView alloc]init];
    line.frame = CGRectMake(15, subtitle.frame.size.height + subtitle.frame.origin.y, self.view.frame.size.width - 30, 1);
    //187	187	187
    line.backgroundColor = [UIColor colorWithWhite:(187.0 / 255.0) alpha:1.0];
    [scroll addSubview:line];
    
    
    //[_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];


    
    
    //------------------------------SetUp
    
    tabla = [[UITableView alloc]init];
    tabla.frame = CGRectMake(0, subtitle.frame.size.height + subtitle.frame.origin.y + 1 , self.view.frame.size.width, 250);
    tabla.delegate = self;
    tabla.dataSource = self;
    
    
    tabla.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [scroll addSubview:tabla];
    
    
    //-------------------------------Reestablecer listados escondidos
    
    UILabel * subtitleListados = [[UILabel alloc]init];
    subtitleListados.frame = CGRectMake(20,tabla.frame.size.height + tabla.frame.origin.y , self.view.frame.size.width - 20, 30);
    subtitleListados.font = [UIFont fontWithName:@"Helvetica" size:16];
    subtitleListados.text = @"Listados escondidos";
    
    [scroll addSubview:subtitleListados];

    
    UIView * line1 = [[UIView alloc]init];
    line1.frame = CGRectMake(15, subtitleListados.frame.size.height + subtitleListados.frame.origin.y + 1, self.view.frame.size.width - 30, 1);
    //187	187	187
    line1.backgroundColor = [UIColor colorWithWhite:(187.0 / 255.0) alpha:1.0];
    [scroll addSubview:line1];
    
    
    UIButton * restablecerButton = [[UIButton alloc]init];
    restablecerButton.frame = CGRectMake(10, line1.frame.size.height + line1.frame.origin.y + 10, self.view.frame.size.width - 20, 50);
    
    restablecerButton.layer.borderWidth = 1;
    //234	234	234
    restablecerButton.backgroundColor = [UIColor colorWithWhite:(234.0 / 255.0) alpha:(1.0)];
    restablecerButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    restablecerButton.layer.borderColor = [UIColor colorWithWhite:(180.0 / 255.0) alpha:1.0].CGColor;
    restablecerButton.titleLabel.text = @"Reestablecer listados escondidos";
     
    [restablecerButton setTitle:@"Reestablecer listados escondidos" forState:UIControlStateNormal];
    
    //112	112	112
    [restablecerButton setTitleColor:[UIColor colorWithRed:(112.0 / 255.0) green:(112.0 / 255.0) blue:(112.0 / 255.0) alpha:1.0] forState:UIControlStateNormal];
    //[restablecerButton setTitleColor:[UIColor colorWithRed:(200.0 / 255.0) green:(200.0 / 255.0) blue:(200.0 / 255.0) alpha:1.0] forState:UIControlEventTouchDown];
    [scroll addSubview:restablecerButton];
    
    
    [restablecerButton addTarget:self action:@selector(resetToDefaults) forControlEvents:UIControlEventTouchUpInside];

    [restablecerButton addTarget:self action:@selector(restablecerHover:) forControlEvents:UIControlEventTouchDown];
    [restablecerButton addTarget:self action:@selector(restablecerCancel:) forControlEvents:UIControlEventTouchUpInside];
    [restablecerButton addTarget:self action:@selector(restablecerCancel:) forControlEvents:UIControlEventTouchDragExit];
    [restablecerButton addTarget:self action:@selector(restablecerCancel:) forControlEvents:UIControlEventTouchDragOutside];
    [restablecerButton addTarget:self action:@selector(restablecerCancel:) forControlEvents:UIControlEventTouchCancel];
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, restablecerButton.frame.origin.y + restablecerButton.frame.size.height + 25);
    
    


}


-(void)resetToDefaults{
    
    NSLog(@"RESETING");
    
    [self.navigationController popViewControllerAnimated:true];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:ResetToDefaultsNotification
     object:nil];
}

-(void)restablecerHover:(UIButton *)boton{
    
    boton.backgroundColor = [UIColor colorWithWhite:(255.0 / 255.0) alpha:(1.0)];
}
-(void)restablecerCancel:(UIButton *)boton{
    
    boton.backgroundColor = [UIColor colorWithWhite:(234.0 / 255.0) alpha:(1.0)];
}


-(void)viewWillAppear:(BOOL)animated{
    

    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self debugSouceList];

}

-(void)debugSouceList{

    
    _sourcesList = [NSMutableArray arrayWithArray: ratingList];
      [tabla beginUpdates];
      [tabla reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
      [tabla endUpdates];
    
    //------------------------------------
    
    
   
    
    
    
   
    
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSNumber * filterValue = 0;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    filterValue = [defaults objectForKey:_sourcesList[indexPath.row]];
   

    

    
    
    customSourceTableViewCell * cell = [[customSourceTableViewCell alloc]init];
    
    cell.title = _sourcesList[ indexPath.row];
    
    if (filterValue != nil){
        cell.isSelected = filterValue.intValue;
    }else{
        cell.isSelected = 1;
    }
    
      
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber * filterValue = 0;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    filterValue = [defaults objectForKey:_sourcesList[indexPath.row]];
    
    if (filterValue == nil){
        
        filterValue = [NSNumber numberWithInt:1];
    }
    
    BOOL value = filterValue.boolValue;
    
    [self setValueForKeyIndex:indexPath.row :!value];
    
    customSourceTableViewCell * cell  = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell checkSelection:!value];
    
    
    //------------------------------
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"refreshFilterNotification"
     object:nil];// refresca los listados


}




-(void)setValueForKeyIndex:(int) index :(int)value{//esta funcion guarda los valores de los filtros
    
    NSString * fuente = _sourcesList[index];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // to store
    [defaults setObject:[NSNumber numberWithInt:value] forKey:fuente];
    [defaults synchronize];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return _sourcesList.count;
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
