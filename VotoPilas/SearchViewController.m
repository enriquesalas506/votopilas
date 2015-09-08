//
//  SearchViewController.m
//  VotoPilas
//
//  Created by Jose on 7/27/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomMiembroCell.h"
#import "itemsOfPartido.h"
#import "PerfilViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController{
    
    
    UITableView * table;
    UISearchBar * searchBar;
    
    NSMutableArray * filteredArray;
    
}

extern CGFloat navHeight;
extern int scrollCurrentPage;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    scrollCurrentPage = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    //Helvetica
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    //-----BARRA DE BUSQUEDA
    
    searchBar = [[UISearchBar alloc]init];
    searchBar.delegate = self;
    
    
    
    searchBar.frame = CGRectMake(50, 0, self.view.frame.size.width - 50, 50);
    searchBar.barStyle = UIBarStyleBlackOpaque;
    
    [searchBar setImage:[UIImage imageNamed:@"magnifying.png"]
       forSearchBarIcon:UISearchBarIconSearch
                  state:UIControlStateNormal];
    
    searchBar.tintColor = [UIColor whiteColor];
    
    [searchBar becomeFirstResponder];
    //searchBar.showsCancelButton = YES;

    
    UITextField *  textFieldInsideSearchBar = [searchBar valueForKey:@"searchField"];//("searchField")
    
    textFieldInsideSearchBar.textColor = [UIColor whiteColor];
    
    
    //----------------CAMBIAR LA IMAGEN
    //-----------------CAMBIAR LA IMAGEN
    
    
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    self.navigationItem.rightBarButtonItem = searchBarItem;

    
    
    
    //-----------------------
    filteredArray = [[NSMutableArray alloc]init];

    
    
    table = [[UITableView alloc] init];
    table.frame = CGRectMake(0, navHeight, self.view.frame.size.width, self.view.frame.size.height - navHeight);
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    

    
    
    // Do any additional setup after loading the view.
    
    //---------FILTERED ARRAY INITIALIZATION
    
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"finishedDownloading" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(finishedDownloading)
     name:@"finishedDownloading"
     object:nil];

    
    
}


-(void)finishedDownloading{
    
    
    NSLog(@"REFRESCANDO BUSQUEDA");
    
    //[self performSelector:@selector(refreshSearch) withObject:0 afterDelay:2.0];
 
}



//--------------TABLA
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (searchBar.text.length > 0){
        
        return filteredArray.count;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomMiembroCell * cell = [[CustomMiembroCell alloc]init];
    
    
    itemsOfPartido * partidoProperties  = filteredArray[indexPath.row];
    
    NSString * title = partidoProperties.nombre;
    NSString * urlString = partidoProperties.imagen;
    int rating = partidoProperties.rating;
    
    cell.Title = [title capitalizedString];
    cell.urlImage = urlString;
    cell.rating = rating;
    cell.item = partidoProperties;
    cell.listPosition = partidoProperties.posicionListado;
    
    
    //------HIGHTLIGHT COLOR
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [cell setSelectedBackgroundView:bgColorView];
    
    //---------------------------
    
    
    

    
    
    return cell;
    
}



//--------------TABLA

-  (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 100;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    // Do the search...
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
 
    [self refreshSearch];
}


-(void)refreshSearch{
    [filteredArray removeAllObjects];
    
    
    
    NSMutableArray * itemsArray = [[NSMutableArray alloc]init];
    
    for (int xx = 0; xx < _searchArray.count; xx++) {
        
        
        itemsArray = [NSMutableArray arrayWithArray:_searchArray[xx]];
        
        //----------------SEARCH
        
        for (int yy = 0; yy < itemsArray.count ; yy++) {
            
            
            itemsOfPartido * item = itemsArray[yy];
            
            
            //NSLog(@"ITEM %@",item.nombre);
            
            
            if (searchBar.text != nil){
            
            if ([item.nombre rangeOfString:searchBar.text options:NSCaseInsensitiveSearch].location == NSNotFound) {
                // NSLog(@"string does not contain bla");
            } else {
                //  NSLog(@"string contains bla!");
                
                [filteredArray addObject:itemsArray[yy]];
            }
                
                
            }
            
            
            
            
        }
        
        
    }
    
    // NSLog(@"RESULT %@",filteredArray);
    
    
    [table reloadData];

}


+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CustomMiembroCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    
    PerfilViewController * perfil = [[PerfilViewController alloc]init];
    
    perfil.rating = cell.rating;
    
    
    
    perfil.item = filteredArray[indexPath.row];//agregando la informacion del partido
    
    [self.navigationController pushViewController:perfil animated:true];
    
    //---------CAMBIAR COLOR
    
    
    
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
