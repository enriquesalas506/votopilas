//
//  ViewController.m
//  VotoPilas
//
//  Created by Jose on 6/22/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "ViewController.h"
#import "PartidosSelector.h"
#import "globalVars.h"
#import "CustomMiembroCell.h"
#import "PartidosItem.h"
#import "itemsOfPartido.h"
#import "TheSidebarController/TheSidebarController.h"
#import "configurationViewController.h"//decaprecated

#import "configurationNewViewController.h"

#import "PerfilViewController.h"
#import "infoSourceModel.h"

#import "alertaCustomViewController.h"

#import "customTableView.h"

#import <Parse/Parse.h>

#import "customScroll.h"

#import "partidosManager.h"

#import "politicianManager.h"

#import "PartidosModel.h"

#import "PoliticianModel.h"
#import "MBProgressHUD.h"

#import "PartidoProfileViewController.h"

#import "SearchViewController.h"


#import <Chartboost/Chartboost.h>
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>

extern CGFloat navHeight;
extern NSString * filterCargo;
extern NSMutableArray * ratingList;

extern bool didFinishLoading;

UIView * statusBar;


NSString *const partidosInfoName = @"partidosInfo";
NSString *const partidosArrayName = @"partidosArray";


int actionCounter = 0;


@interface ViewController (){
    
    
    UITableView * table;
    
    NSMutableArray * partidosArray;
    NSMutableArray * partidosInfo;
    
    NSMutableArray * temporalPartidosArray;
    
    PartidosSelector * partidos;
    
    
    int CurrentPartidoSelected;
    
    UIButton * overlayButton;// cuando aparece el sidebar
    
    NSMutableArray * efficientFilter;
    
    NSMutableArray * efficientPartyMembersFilter;
    
    
    NSMutableArray * infoArrayUntouched;
    NSMutableArray * partidosListUntouched;
    
    
    customScroll * tableHolder;
    
    UIButton *settingsView;
    
    
    BOOL firstLaunch;
    
    
    //-------------
    
    NSMutableArray * cacheTableList;
    
    
    SearchViewController * search ;

    
    
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    cacheTableList = [[NSMutableArray alloc]init];
    partidosArray = [[NSMutableArray alloc]init];

    search = [[SearchViewController alloc]init];
    
    //--------------------------------
    
    
    self.navigationController.navigationBar.backgroundColor =  [UIColor colorWithRed:(34.0 / 255.0) green:(175.0 / 255.0) blue:(241.0 / 255.0) alpha:1.0];
    
    
       
    statusBar = [[UIView alloc]init];
    statusBar.backgroundColor =  [UIColor colorWithRed:(34.0 / 255.0) green:(175.0 / 255.0) blue:(241.0 / 255.0) alpha:1.0];
    statusBar.frame = CGRectMake(0, 0, self.view.frame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height);
    
    [self.navigationController.view addSubview:statusBar];
    
    
    
    //-------FILTRO
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *loadFilter = [defaults objectForKey:@"filter"];
    efficientFilter = [NSMutableArray arrayWithArray:loadFilter];
    
    if (efficientFilter == nil){
    
        NSLog(@"EFFICIENT FILTER IS EQUAL NILL");
        
    efficientFilter = [[NSMutableArray alloc]init];
        
    }
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ResetToDefaultsNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(resetToDefaults)
     name:ResetToDefaultsNotification
     object:nil];

    
    
    //--------FILTRO
    
    
 
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view, typically from a nib.
    
    //----SET UP VIEW CONTROLLER
    
    overlayButton = [[UIButton alloc]init];
    overlayButton.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:1.0];
    navHeight = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height; ;
    
    
       UIButton *button2 = [[UIButton alloc] init];
    button2.frame=CGRectMake(0,0,40,30);
    [[button2 imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [button2 setImage:[[UIImage imageNamed: @"menu-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(showLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTintColor:[UIColor whiteColor]];
    button2.contentMode = UIViewContentModeScaleAspectFit;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button2];
    
    

    
  //34	175	241
   self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(34.0 / 255.0) green:(175.0 / 255.0) blue:(241.0 / 255.0) alpha:1.0];//navigation bar color
   self.navigationController.navigationBar.topItem.title = @"Listado Nacional";

  //Helvetica
     self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];

    
    //----SET UP VIEW CONTROLLER
    
    //----SET UP PARTIDOS COTROLLER
    
    
    NSLog(@"SIZE BAR  %f",navHeight);
    
    partidos = [[PartidosSelector alloc]init];
    partidos.frame = CGRectMake(0, navHeight, self.view.frame.size.width, 50);
    
    [self.view addSubview:partidos];
    
    //----SET UP PARTIDOS COTROLLER
    
    //--------------------------------TABLE VIEW CONTROLLER
  
    
    //--------------------------------TABLE VIEW CONTROLLER
    
    
    //--------------------------------PAGE VIEW
    
    CGFloat optionBarHeight = 35;
    
    tableHolder = [[customScroll alloc]init];
    tableHolder.frame = CGRectMake(0, navHeight + partidos.frame.size.height + optionBarHeight, self.view.frame.size.width, self.view.frame.size.height - navHeight - partidos.frame.size.height - optionBarHeight);
    tableHolder.controller = self;
    //tableHolder.backgroundColor = [UIColor redColor];
    [self.view addSubview:tableHolder];
    
    
    
    //----------OPTION BAR
    
    UIView * optionBar = [[UIView alloc]init];
    optionBar.frame = CGRectMake(0, partidos.frame.origin.y + partidos.frame.size.height, self.view.frame.size.width, optionBarHeight);
    //43	47	62
    optionBar.backgroundColor = [UIColor colorWithRed:(43.0 / 255.0) green:(47.0 / 255.0) blue:(62.0 / 255.0) alpha:1.0];
    [self.view addSubview: optionBar];
    
    
    //-----------OPTION BAR
    
    //---------
    
    //-----masinformacion
    UIButton * masinfo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    masinfo.titleLabel.font = [masinfo.titleLabel.font fontWithSize:12];
    masinfo.frame = CGRectMake(15, 0, 100, optionBarHeight);
    [masinfo setTitle:@"Perfil del Partido" forState:UIControlStateNormal];
    [masinfo addTarget:self action:@selector(moreInfo) forControlEvents:UIControlEventTouchUpInside];

    
    //36	166	234
  //  [masinfo setTitleColor:[UIColor colorWithRed:(36.0/ 255.0) green:(166.0/ 255.0) blue:(234.0/ 255.0) alpha:1.0] forState:UIControlStateNormal];
    [masinfo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [optionBar addSubview:masinfo];
    
    //----descartar partidos
    
    UIButton * decartarpartido = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    decartarpartido.titleLabel.font = [masinfo.titleLabel.font fontWithSize:12];
    decartarpartido.titleLabel.textAlignment = NSTextAlignmentRight;
    decartarpartido.frame = CGRectMake(self.view.frame.size.width - 115, 0, 100, optionBarHeight);
    [decartarpartido setTitle:@"Descartar Listado" forState:UIControlStateNormal];
    [decartarpartido addTarget:self action:@selector(ocultarBoton) forControlEvents:UIControlEventTouchUpInside];

    
    //36	166	234
    [decartarpartido setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [optionBar addSubview:decartarpartido];
    
    
    
    

    
    //--------------------------------PAGE VIEW
    
    //----------------------------------
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ChangePartidoNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(changeNotification:)
     name:@"ChangePartidoNotification"
     object:nil];
    
    
    //-------Push Configuration View Controller
    //GoToSettingsNotification
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GoToSettingsNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(goToConfiguration)
     name:@"GoToSettingsNotification"
     object:nil];
    
    //ClearOverlayNotification
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ClearOverlayNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(clearOverlay)
     name:@"ClearOverlayNotification"
     object:nil];
    
    //RefreshFilters
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshFilterNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(filterList)
     name:@"refreshFilterNotification"
     object:nil];
    
    
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeNameNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(changeName:)
     name:@"changeNameNotification"
     object:nil];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"waitRemovePartido" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(removePartido:)
     name:@"waitRemovePartido"
     object:nil];
    
    //incomeData
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"incomeData" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(processDataPart:)
     name:@"incomeData"
     object:nil];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"finishedDownloading" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(finishedDownloading)
     name:@"finishedDownloading"
     object:nil];
    
  

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];

    
    //updateTopMenuNotification
    
      
    //----------OCULTAR BOTON
    

    
    //------
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,40,25);
    [[button1 imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [button1 setImage:[[UIImage imageNamed: @"searchicon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(gotoSearch) forControlEvents:UIControlEventTouchUpInside];
   // [button1 addTarget:self action:@selector(ocultarBoton) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTintColor:[UIColor whiteColor]];
    button1.contentMode = UIViewContentModeScaleAspectFit;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    
    
    //self.navigationItem.rightBarButtonItem = anotherButton;


    

  
    
    [self downloadDataFromParse];
    
}

-(void)becomeActive:(NSNotification *)notification {
    // only respond if the selected tab is our current tab
    
    //---refresh data in background
    if (didFinishLoading){
        NSLog(@"RELOADING APP DATA");
        [politicianManager downloadPoliticiansAllParts: partidosListUntouched];
        
    }
    
    
}

-(void)finishedDownloading{
    
    
    
        didFinishLoading = true;
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:true];

    

    
}



-(void)gotoSearch{
    
    
    
    [self.navigationController pushViewController:search animated:true];
    
}


-(void)moreInfo{
    
    NSLog(@"MAS INFORMACION");
    if (temporalPartidosArray.count > 0){
    PartidosModel * partido = temporalPartidosArray[CurrentPartidoSelected];
    PartidoProfileViewController * profile = [[PartidoProfileViewController alloc]init];
    profile.partido = partido;
    [self.navigationController pushViewController:profile animated:true];
    
    }
    
    
    
}

-(void)changeName:(NSNotification *)note{
    
    NSString * titulo = [NSString stringWithFormat:@"Listado %@", note.object];
    
    self.title = titulo;
}

-(void)updateTabWhenScroll:(int) page{
    
    
   // NSLog(@"PAGE %d",page);
    
    //---------------------
    
    CurrentPartidoSelected = page;
    
    [self highlightItem];
    //[self performSelector:@selector(highlightItem) withObject:nil afterDelay:0.5];
    
    
    
    
}

-(void)clearTableHolder{
    
    
    NSArray *viewsToRemove = [tableHolder subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }

}

//-------------ADD STUFF TO SCROLL VIEW

//-----------------RELOAD DATA DEL SCROLL VIEW QUE CONTIENE LOS POLITICOS


-(void)tableHolderReloadData{
    
    UIColor * blueSky = [[UIColor alloc]init];
    blueSky = [UIColor colorWithRed:(34.0 / 255.0) green:(175.0 / 255.0) blue:(241.0 / 255.0) alpha:1.0];

    
    NSArray *viewsToRemove = [tableHolder subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    
    
    for (int xx = 0; xx < efficientPartyMembersFilter.count; xx++) {
        
        
        customTableView * supertable;
        if (cacheTableList.count <= xx) {
         
        supertable    = [[customTableView alloc]init];
         [cacheTableList addObject:supertable];

        }else{
            
            supertable = cacheTableList[xx];
        }
        
        supertable.indexTab = xx;
        
        supertable.frame = CGRectMake((xx * tableHolder.frame.size.width), 0, tableHolder.frame.size.width, tableHolder.frame.size.height);
        supertable.delegate = self;
        supertable.dataSource = self;
        supertable.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];

        supertable.tag = xx;
        //supertable.delaysContentTouches = true;
        [tableHolder addSubview:supertable];
        
        
    }
    tableHolder.contentSize = CGSizeMake(efficientPartyMembersFilter.count * tableHolder.frame.size.width , tableHolder.frame.size.height);

    
}

//-----------------RELOAD DATA DEL SCROLL VIEW QUE CONTIENE LOS POLITICOS

//-------------ADD STUFF TO SCROLL VIEW




-(void)forceTableReload{
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"RefreshTableNotification"
     object:nil];// cuando aparece el sidebar se crea un boton encima. Esto lo remueve
    
}
-(void)forceTableReloadSection{
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"RefreshSectionNotification"
     object:nil];// cuando aparece el sidebar se crea un boton encima. Esto lo remueve
    
}


//-------------------------PARSE

-(void)logInParse{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];//PROGRESS BAR

    
    [PFUser logInWithUsernameInBackground:@"esalas"
                                 password:@"password" block:^(PFUser *user, NSError *error)
     
     {
         if (!error) {
             
             NSLog(@"LOGIN PARSE");
             //[self performSegueWithIdentifier:@"loginSegue" sender:nil];
             
             //startDownloadingNotification
             
             [[NSNotificationCenter defaultCenter]
              postNotificationName:@"startDownloadingNotification"
              object:nil];// tell other controllers to start downloading the data from the server
             

             
             [self downloadDataFromParse];
            

             
             
            } else {
             NSLog(@"%@",error);
            
                UIAlertView * alert = [[UIAlertView alloc]init];
                alert.title =@"Error de Conexion";
                [alert addButtonWithTitle:@"Aceptar"];
                [alert show];
                //alert.message =@"Error de Conexion";
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:true];
                
                
             // The login failed. Check error to see why.
         }
     }];

}

-(void)downloadDataFromParse{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];//PROGRESS BAR

    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"startDownloadingNotification"
     object:nil];//
    
    //---------------------------------LOGIN PARSE
   
    [partidosManager downloadPartidosList:^(NSMutableArray * array)  {
        
         NSMutableArray * freshArray = [NSMutableArray arrayWithArray:array];
        
        [partidosArray removeAllObjects];
        
        
        for (int xx = 0; xx < freshArray.count; xx++) {
            
            PartidosModel * partidoModel = freshArray[xx];
            [partidosArray addObject:partidoModel];
        }
        
        
        partidosListUntouched = [NSMutableArray arrayWithArray:partidosArray];
        
        
        
        

        
        
        [self DownloadPoliticianList:freshArray];
        
        
        //NSLog(@"PARTIDOS ARRAY %@",partidosArray);
    }];
    NSLog(@"PARSING COUNT %d",partidosArray.count);
    
    
  
    
    
}


-(void)processDataPart:(NSNotification *)notification{
    
    

    
   // partidosArray = [NSMutableArray arrayWithArray:partidosListUntouched];
    
    //NSLog(@"DATA PART %@",notification.object);
    
    NSArray * array = [NSArray arrayWithArray:notification.object];
    
    partidosInfo = [NSMutableArray arrayWithArray:array];//<-- transifiriendo datos al constructor
    infoArrayUntouched = [NSMutableArray arrayWithArray:partidosInfo];
    search.searchArray = infoArrayUntouched;
    
    [search refreshSearch];

    partidosArray = [NSMutableArray arrayWithArray:partidosListUntouched];
    
    efficientPartyMembersFilter = [NSMutableArray arrayWithArray:partidosInfo];//reloadting and ressetting filer array
    
    
    
        NSLog(@"ESTO ESTAN ENCICLADO");
        
        [self filterList];
        
    
    
    
}
-(void)DownloadPoliticianList:(NSMutableArray *)arrayWithPartidos{
    
    NSLog(@"BEFORE DOWNLOADING POLITICIAN LIST");
    
    infoArrayUntouched = [[NSMutableArray alloc]init];
    
    
    //------------------
    
    [politicianManager downloadPoliticiansInParts:arrayWithPartidos]; // esto esta en beta
    
    
  
    /*
        
        [politicianManager downloadPoliticians:arrayWithPartidos :^(NSMutableArray * array)  {
            
            
            partidosInfo = [NSMutableArray arrayWithArray:array];//<-- transifiriendo datos al constructor
            infoArrayUntouched = [NSMutableArray arrayWithArray:partidosInfo];
            
            efficientPartyMembersFilter = [NSMutableArray arrayWithArray:partidosInfo];//reloadting and ressetting filer array
            
            [self filterList];
            
        }];
        
    
     */
    
    
    //----------------
                                  
                                  
}



//-------------------------PARSE




-(void)resetToDefaults{
    
    NSLog(@"RESET TO DEFAULTS");
    
    
    self.title = @"Listado Nacional";

    filterCargo = nil;// setting cargo filter to default
    
    //------------
    [efficientFilter removeAllObjects];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:efficientFilter forKey:@"filter"];
    [defaults synchronize];
    
    //[self debugTableView];//cambiar por el constructor cuando se tengan los datos
    [partidos clearSelector];
    [self clearTableHolder];
    [self downloadDataFromParse];
    
    
    //===============================COMPLETE RESETE ALL NSUSERDEFAULTS
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    
    
    //-----------Reiniciar Swipe Controller

    
}

-(void)ocultarBoton{
    
    NSLog(@"OCULTAR BOTON");
    
    if (efficientPartyMembersFilter.count >0 && temporalPartidosArray.count > 0) {//validacion para no caer en un outofbounds
        
        

        
    alertaCustomViewController * customAlerta = [[alertaCustomViewController alloc]init];
    
        PartidosModel * partido = temporalPartidosArray[CurrentPartidoSelected];
        
    customAlerta.mainTitle = @"Ocultar Listado";
    customAlerta.subtitle = partido.acronym;
        customAlerta.message = @"Podrás reestablecer los listados ocultos desde el menu de configuarión";
        customAlerta.boxMessage = @"No mostrar otra vez.";
        customAlerta.statusKey = @"filterAlert";
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber * statusKey = [defaults objectForKey:@"filterAlert"];
        


    
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
    
        if (statusKey.boolValue == false){
        
            [self presentViewController:customAlerta animated:true completion:nil];
            
            
        }else{
            
            
            NSLog(@"BORRANDO DEL LA LISTA");
            
            //----ocultar
            [efficientFilter addObject:partido.acronym];
            
            
            NSLog(@"EFFICIENT FILTER BOTON%@",temporalPartidosArray);
            
            
            // to store
            [defaults setObject:efficientFilter forKey:@"filter"];
            [defaults synchronize];
            
            
            [self filterList];
            
            //---ocultar

        }
    
     
     
    }
    
}

-(void)removePartido:(NSNotification *)notfication{
    
    NSLog(@"REMOVIENDO PARTIDO");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
    PartidosModel * partido = temporalPartidosArray[CurrentPartidoSelected];
    
    [efficientFilter addObject:partido.acronym];
    
    
      NSLog(@"EFFICIENT FILTER BOTON%@",temporalPartidosArray);
    
    
    // to store
      [defaults setObject:efficientFilter forKey:@"filter"];
      [defaults synchronize];
    

    
      [self filterList];
    
    
}



-(void)filterList{
    
    
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:true];//hide hud
    
    if ([filterCargo  isEqual: @""] || filterCargo == nil){
        
        filterCargo = @"Nacional";
        
        
    }
    

    
    
    
    

    
   //-------------------------REMOVIENDO PARTIDOS
    NSMutableArray * partidoArrayNames = [[NSMutableArray alloc]init];
    
    
   

    
    for (int pp = 0; pp < partidosArray.count; pp++) {
        
        
        
        PartidosModel * partido = partidosArray[pp];
        
        
        [partidoArrayNames addObject:partido.acronym];
    }
    
    
    
    for (int cc=0; cc< efficientFilter.count; cc++){
        
      
        
        NSUInteger indexOfTheObject = [partidoArrayNames indexOfObject: efficientFilter[cc]];
        
        
        
        if(NSNotFound != indexOfTheObject) {
            
            
            PartidosModel * partido = partidosArray[indexOfTheObject];

          //  NSLog(@"REMOVING  %d %@",indexOfTheObject,partido.acronym);
            
            [partidoArrayNames removeObjectAtIndex:indexOfTheObject];
            [ partidosArray removeObjectAtIndex:indexOfTheObject];//removiendo de los arrays
            [ partidosInfo removeObjectAtIndex:indexOfTheObject];//removiendo de los arrays
        }
        
        

        
    }
    
    
  
       //-------------------------REMOVIENDO PARTIDOS
    
    //-------------------FILTRAND MIEMBROS DEL PARTIDO
    

    efficientPartyMembersFilter = [NSMutableArray arrayWithArray:partidosInfo];
    

    
    //----------------------FILTRAR MIEMBROS DEL PARTIDO

    if (![filterCargo  isEqual: @""] && filterCargo != nil){

    
    NSMutableArray * filteredPartido = [[NSMutableArray alloc]init];//copy of array

    
    NSLog(@"Filter List %@",filterCargo);
    
    
        for (int zz=0; zz< partidosInfo.count; zz++){
    
    
       // NSLog(@"Filtering....");
        
            NSMutableArray * insidePartido = partidosInfo[zz];//copy of array
            NSMutableArray * filteredArray = [[NSMutableArray alloc]init];//copy of array
            
            
            for (int dd=0; dd< insidePartido.count; dd++){
        
            itemsOfPartido * item = insidePartido[dd];
        
               // NSLog(@"Miembro Cargo %@",item.cargo);
               // NSLog(@"Miembro Listado %@",item.listado);
               // NSLog(@"FILTER NAME %@",filterCargo);


                
            if ([item.cargo isEqualToString:filterCargo]  || [item.listado  isEqualToString:filterCargo]){
                [filteredArray addObject:item];//borrando item
            }
        
            }
    
           // NSLog(@"Filtros del partido %@", filteredArray);
            
            

            [filteredPartido addObject:filteredArray];//filtrando
            
            }
            
            
            
        
        
    
        efficientPartyMembersFilter = [NSMutableArray arrayWithArray:filteredPartido];
        }
    
    
    //----------------------FILTRANDO PARTIDOS
    
    NSLog(@"EFFICIENT FILTER %@",efficientFilter);
    
    
    NSMutableArray * prefileterInfo = [[NSMutableArray alloc]init];
    NSMutableArray * prefileterArray = [[NSMutableArray alloc]init];
    
    for (int cc=0; cc< efficientPartyMembersFilter.count; cc++){
        
        NSMutableArray * insideArray = efficientPartyMembersFilter[cc];
        
        if (insideArray.count > 0){
            
            [prefileterInfo addObject:efficientPartyMembersFilter[cc]];
            
            [prefileterArray addObject:partidosArray[cc]];
            
        }
        
        
        
    }

    // NSLog(@"PREFILTER ARRAY %@",prefileterArray);
    //NSLog(@"PREFILTER INFO %@",prefileterInfo);
    
    efficientPartyMembersFilter = [NSMutableArray arrayWithArray:prefileterInfo];
    temporalPartidosArray = [NSMutableArray arrayWithArray:prefileterArray];
    
    
    //---------------------------------------------------
    partidos.itemsList = prefileterArray;
    [partidos refreshItems];

    
   
    
    //-------------------------------------------------ORDERNAR POR LISTADO
    
    
   
    
    NSMutableArray * orderedMemberlist = [[NSMutableArray alloc]init];
    
    for (int ss= 0; ss < efficientPartyMembersFilter.count ; ss++){
        
    NSArray * orderItems = [NSArray arrayWithArray:efficientPartyMembersFilter[ss]];
    
    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"posicionKey" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
    
    orderItems = [orderItems sortedArrayUsingDescriptors:sortDescriptors];
    
    [orderedMemberlist addObject:orderItems];
        
    }
    
    efficientPartyMembersFilter = [NSMutableArray arrayWithArray:orderedMemberlist];
    
    
    if (efficientPartyMembersFilter.count == 0){
        
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
    }
    

    //-------------------------------------------------ORDERNAR POR LISTADO
    
    
    
    if (CurrentPartidoSelected >= efficientPartyMembersFilter.count){
        CurrentPartidoSelected = 0;//restando el numero del contador
    }
    
    
    
    if (CurrentPartidoSelected < 0){
        CurrentPartidoSelected = 0;//esto evita un crash al recargar la tabla
    }
    
    
    NSLog(@"CURRENT PARTIDO SELECTED %d",CurrentPartidoSelected);
    [partidos highLightItem:CurrentPartidoSelected];

    
    
    [self tableHolderReloadData];
    
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
    [self forceTableReloadSection];

    
    //[self showAd];
    
}



-(void)clearOverlay{
    
    
     [overlayButton removeFromSuperview];
    
}

-(void)goToConfiguration{
    
    configurationNewViewController * configView = [[configurationNewViewController alloc]init];
    [self.navigationController pushViewController:configView animated:true];
}

-(void)changeNotification:(NSNotification *)notifcation{
    
    NSNumber * index = notifcation.object;
    
   
    //-------DEBUG PARTIDOS LIST
    
    NSLog(@"CHANGE NOTIFICATION %d",index.intValue);
    
    CurrentPartidoSelected = index.intValue;// este es el partido actualmente seleccionado
    partidos.itemsList = temporalPartidosArray;// este es el selector del partido
    
    [table reloadData];
    
    [tableHolder moveToScroll:index.intValue];
    
   // [self forceTableReload];


}


- (void)showLeftMenu
{
    if(self.sidebarController.sidebarIsPresenting)
    {
        [self.sidebarController dismissSidebarViewController];
        
        
    }
    else
    {
        [self.navigationController.view addSubview:overlayButton];
        [overlayButton addTarget:self action:@selector(closeSideBar) forControlEvents:UIControlEventTouchDown];

        [self.sidebarController presentLeftSidebarViewControllerWithStyle:SidebarTransitionStyleFeedly];
    }
}

- (void)closeSideBar{
    
    if(self.sidebarController.sidebarIsPresenting)
    {
        [self.sidebarController dismissSidebarViewController];
        
        
    }
    [overlayButton removeFromSuperview];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.view addSubview:settingsView];

    
    NSLog(@"APPEARING");
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [settingsView removeFromSuperview];
}
         

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if (efficientPartyMembersFilter.count > 0){
        
        if (tableView.tag < efficientPartyMembersFilter.count){
        
        NSArray * item = efficientPartyMembersFilter[tableView.tag];
        
        
            if (item.count == 0){
                
                tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                [self addNoExisten:tableView];
            }else{
                
                tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
              //  [self removeAllItemsOfTable:tableView];
            }
            
           // NSLog(@"RETURNING ITEMS %d",item.count);
            
        return item.count;// cantidad de items
            
        }else{
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self addNoExisten:tableView];
            return 0;
        }
    }
    
    

    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addNoExisten:tableView];
    return 0;
}

-(void)removeAllItemsOfTable:(UITableView * )newtable{
    
    
    
    NSArray *viewsToRemove = [newtable subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}
-(void)addNoExisten:(UITableView * )newtable{
    
  
    NSLog(@"ADDING NO EXISTEN");
    
    
    UILabel * label = [[UILabel alloc]init];
    label.text = @"No existen elementos disponibles";
    label.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    //label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, (newtable.frame.size.height /2 ) - 100, self.view.frame.size.width, 100);
   // [newtable addSubview:label];
    
    
    
    
}

-  (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  //  NSLog(@"CELL");
    
    customTableView * tabla = tableView;
    
    CustomMiembroCell * cell = [[CustomMiembroCell alloc]init];
    
    //---------------------------
    
    NSArray * items = efficientPartyMembersFilter[tableView.tag];// getting the array of partidos
    
    itemsOfPartido * partidoProperties  = items[indexPath.row];
    
    NSString * title = partidoProperties.nombre;
    NSString * urlString = partidoProperties.imagen;
    int rating = partidoProperties.rating;
    
    cell.Title = [title capitalizedString];
    cell.urlImage = urlString;
    cell.rating = rating;
    cell.item = partidoProperties;
    cell.listPosition = partidoProperties.posicionListado;
    cell.indexTab = tabla.indexTab;
    
    
    //------HIGHTLIGHT COLOR
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [cell setSelectedBackgroundView:bgColorView];
    
    //---------------------------


    
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    CustomMiembroCell * cell = [tableView cellForRowAtIndexPath:indexPath];

    
    
    PerfilViewController * perfil = [[PerfilViewController alloc]init];
    
    perfil.rating = cell.rating;
    
    
    NSMutableArray * partido = efficientPartyMembersFilter[CurrentPartidoSelected];
    
    perfil.item = partido[indexPath.row];//agregando la informacion del partido
    
    [self.navigationController pushViewController:perfil animated:true];
    
    //---------CAMBIAR COLOR
    
   
    actionCounter++;//action counter
    
    
    if (actionCounter > 6){
        //SHOW ADD
        
        actionCounter = 0;
        
        [self showAd];
        
    }
    
}

-(void)showAd{
 
    NSLog(@"SHOW AD");
    
    [Chartboost showInterstitial:CBLocationDefault];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







//RefreshTableNotification
-(void)highlightItem{
    [partidos highLightItem:CurrentPartidoSelected];
}

@end
