// LeftSidebarViewController.m
// Basic
//
// Copyright (c) 2014 Jon Danao (danao.org | jondanao)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "LeftSidebarViewController.h"
#import "TheSidebarController.h"

#import "ViewController.h"
#import "listadoTableViewCell.h"

#import <Parse/Parse.h>

#import "MBProgressHUD.h"

#import "listManager.h"

#import <Parse/Parse.h>

#import "UIImageView+WebCache.h"


#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "ValoracionesViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>



extern CGFloat navHeight;

extern  NSString * filterCargo;





@interface LeftSidebarViewController()

- (void)buttonClicked:(id)sender;

@end

static const CGFloat kVisibleWidth = 260.0f;

@implementation LeftSidebarViewController{
    
    UITableView * tabla;
    
    UILabel * nameLabel;
    
    CGFloat officialX;
    
    UIImageView * circleView;
    
    UIImageView * header;

}

-(UIImage *)makeBlur:(UIImageView *)holder blur:(CGFloat)imgblur{
    
    //--------------------------
    UIGraphicsBeginImageContext(holder.bounds.size);
    [holder.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Blur the UIImage with a CIFilter
    CIImage *imageToBlur = [CIImage imageWithCGImage:viewImage.CGImage];
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: imgblur] forKey: @"inputRadius"];
    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
    UIImage *endImage = [[UIImage alloc] initWithCIImage:resultImage];
    //--------------------------

    return  endImage;
}

- (void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor colorWithRed:(43.0 / 255.0) green:(47.0 / 255.0) blue:(61.0 / 255.0) alpha:(1.0)];
    
    //--------------HEADER
    
    officialX = self.view.frame.size.width -kVisibleWidth;
    
    header = [[UIImageView alloc]init];
    header.frame = CGRectMake(officialX, 0, kVisibleWidth, navHeight + 100);
    //72	72	72
    //43	47	61
    header.backgroundColor = [UIColor colorWithRed:(43.0 / 255.0) green:(47.0 / 255.0) blue:(61.0 / 255.0) alpha:(1.0)];
    header.contentMode = UIViewContentModeScaleAspectFill;
    header.clipsToBounds = true;
    
    
    
    

    
    if ([PFUser currentUser]){
        
        
        
        
        PFUser * user = [PFUser currentUser];
        
        NSString * userImage = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[user objectForKey:@"fbId"]];
        
        [header sd_setImageWithURL:[NSURL URLWithString:userImage] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            header.image = [ self makeBlur:header blur:3];
            
            //---------------------- BLACK LAYER
            
            UIView * blackLayer = [[UIView alloc]init];
            blackLayer.frame = CGRectMake(0, 0, header.frame.size.width, header.frame.size.height);
            blackLayer.alpha = 0.3;
            blackLayer.backgroundColor = [UIColor blackColor];
            [header addSubview:blackLayer];
            [header sendSubviewToBack:blackLayer];

            
            
            
        }];
        
        //----------------CIRCLE IMAGE
        
        
        circleView = [[UIImageView alloc]init];
        CGFloat radious = 50;
        CGFloat centerX = 25;
        CGFloat centerY = header.frame.size.height - 75;
        circleView.frame = CGRectMake(centerX, centerY, radious, radious);
        [circleView sd_setImageWithURL:[NSURL URLWithString:userImage]];
        
        circleView.layer.cornerRadius = (circleView.frame.size.width / 2);
        circleView.contentMode = UIViewContentModeScaleAspectFill;
        circleView.clipsToBounds = true;
        
        
        [header addSubview:circleView];
        
        //------------------------------
        
        CGFloat nameX = (header.frame.size.width / 2) - 40;
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(nameX, header.frame.size.height - 75, (header.frame.size.width) - 30, 50);
        nameLabel.font = [nameLabel.font fontWithSize:16];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.adjustsFontSizeToFitWidth = YES;
        nameLabel.minimumScaleFactor = 8.0 / nameLabel.font.pointSize;
        nameLabel.text = [user objectForKey:@"name"];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        
      //  nameLabel.backgroundColor = [UIColor redColor];
        
        [header addSubview:nameLabel];
        
        
        
    }else{
     //do something here
        NSLog(@"GETTING NULL FACEBOOK IMAGE");
    }
    
    
    [self.view addSubview:header];
    
    //------------------------
    
    
    
    UIButton * botonSettings = [[UIButton alloc] init];
    CGFloat botonSize = 100;
    [botonSettings setImage:[UIImage imageNamed:@"settings-btn.png"]  forState:UIControlStateNormal];
    
    
    
    
    [botonSettings.imageView setContentMode:UIViewContentModeScaleAspectFit];
    CGFloat botonX = (self.view.frame.size.width - kVisibleWidth) + (kVisibleWidth / 2) - 30;
    botonSettings.frame = CGRectMake(botonX, (header.frame.size.height) - 90, botonSize, botonSize);
    [header addSubview:botonSettings];
    
    
    
    //if ([ PFUser currentUser] ==
    
    botonSize = 75;

        
        [botonSettings setImageEdgeInsets:UIEdgeInsetsMake(27, 27, 27, 27)];

        [botonSettings setImage:[[UIImage imageNamed:@"gears.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        
        [botonSettings.imageView setTintColor:[UIColor whiteColor]];


        botonSettings.frame = CGRectMake(self.view.frame.size.width - botonSize - 17 ,  7, botonSize, botonSize);
   // }
    
    
    
    [botonSettings addTarget:self action:@selector(hoverSettings:) forControlEvents:UIControlEventTouchDown];
    [botonSettings addTarget:self action:@selector(goToConfiguration) forControlEvents:UIControlEventTouchUpInside];

    [botonSettings addTarget:self action:@selector(hoverCancel:) forControlEvents:UIControlEventTouchDragExit];
    [botonSettings addTarget:self action:@selector(hoverCancel:) forControlEvents:UIControlEventTouchDragOutside];
    [botonSettings addTarget:self action:@selector(hoverCancel:) forControlEvents:UIControlEventTouchCancel];
    [botonSettings addTarget:self action:@selector(hoverCancel:) forControlEvents:UIControlEventTouchUpInside];


    
    [header setUserInteractionEnabled:false];
    [self.view addSubview:botonSettings];
    
    //-----LOG OUT
    
    
    UIButton * logOutSettings = [UIButton buttonWithType:UIButtonTypeCustom];
    [logOutSettings setImageEdgeInsets:UIEdgeInsetsMake(25, 25, 25, 25)];
    [logOutSettings setImage:[[UIImage imageNamed:@"logout.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [logOutSettings.imageView setTintColor:[UIColor whiteColor]];
    
    
    
    [logOutSettings.imageView setContentMode:UIViewContentModeScaleAspectFit];
    CGFloat logoutX = (self.view.frame.size.width - kVisibleWidth) + ((header.frame.size.width * 3.5) / 4.5) - (botonSize / 2);
    logOutSettings.frame = CGRectMake(logoutX, (header.frame.size.height / 2)- (botonSize / 2), botonSize, botonSize);
    
    if ([ PFUser currentUser] == nil){
        
        logOutSettings.hidden = true;
    }
    
    
    
    [logOutSettings addTarget:self action:@selector(hoverSettings:) forControlEvents:UIControlEventTouchDown];
    [logOutSettings addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    
    [logOutSettings addTarget:self action:@selector(hoverCancel:) forControlEvents:UIControlEventTouchDragExit];
    [logOutSettings addTarget:self action:@selector(hoverCancel:) forControlEvents:UIControlEventTouchDragOutside];
    [logOutSettings addTarget:self action:@selector(hoverCancel:) forControlEvents:UIControlEventTouchCancel];
    [logOutSettings addTarget:self action:@selector(hoverCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //[self.view addSubview:logOutSettings];
    
    

    
    
    //-----SETTINGS
    
    //------------LISTADOS

    //---------- Listados Title
    
    UILabel * listadosLabel = [[UILabel alloc]init];
    CGFloat listadosX = (self.view.frame.size.width -kVisibleWidth) + 25.0;
    listadosLabel.frame = CGRectMake(listadosX , header.frame.size.height, kVisibleWidth - 50, 30);
    
    if ([ PFUser currentUser] == nil){
        
        listadosLabel.frame = CGRectMake(listadosX , 75, kVisibleWidth - 50, 30);

    }
    
    listadosLabel.textAlignment = NSTextAlignmentLeft;
    listadosLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    
    
    NSString *string = [@"Listados" uppercaseString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    float spacing = 1.0f;
    [attributedString addAttribute:NSKernAttributeName
                             value:@(spacing)
                             range:NSMakeRange(0, [string length])];
    
    listadosLabel.attributedText = attributedString;
    
    listadosLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:listadosLabel];
    
    //----------LINEA
    
    UIView * line = [[UIView alloc]init];
    line.frame = CGRectMake(listadosLabel.frame.origin.x, listadosLabel.frame.origin.y + listadosLabel.frame.size.height, listadosLabel.frame.size.width, 1);
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];

    
    tabla = [[UITableView alloc]init];
    tabla.frame = CGRectMake(self.view.frame.size.width -kVisibleWidth,  listadosLabel.frame.origin.y + listadosLabel.frame.size.height + 10 , kVisibleWidth,  (self.view.frame.size.height) -(listadosLabel.frame.origin.y + listadosLabel.frame.size.height + 10));
    
    tabla.delegate = self;
    tabla.dataSource = self;
    
    tabla.backgroundColor = [UIColor colorWithRed:(43.0 / 255.0) green:(47.0 / 255.0) blue:(61.0 / 255.0) alpha:(1.0)];
    
    tabla.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tabla];
    
    //------------LISTADOS
    
    
    //-----------GESTURE
    
    
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    
    //------------GESTURE
    
   // [self debugTabla];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"startDownloadingNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(downloadDataFromParse)
     name:@"startDownloadingNotification"
     object:nil];
    

    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userLoggedInNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(goToValoraciones)
     name:@"userLoggedInNotification"
     object:nil];
    
    
    //----------------------------------
    
    UILabel * title = [[UILabel alloc]init];
    title.text = @"Votopilas";
    title.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22];
    title.frame = CGRectMake(self.view.frame.size.width -kVisibleWidth, 7, kVisibleWidth, 75);
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
                             
    
    
    
    

    
    
}

-(void)goToValoraciones{
    
    [[self.view subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self viewDidLoad];
    
}


-(void)viewWillAppear:(BOOL)animated{
   
    
    
}

-(void)logOut{
    
    [PFUser logOut];

    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"logInNotification"
     object:nil];// refresca los listados

}

-(void)downloadDataFromParse{
    
    
    _listado = [[NSMutableArray alloc]init];
    
    //---------------------------------LOGIN PARSE
    
    [listManager downloadListados:^(NSMutableArray * array)  {
        
        for (int xx = 0; xx < array.count; xx++) {
        
            
           // NSLog(@"LISTADOS DE DEPARTAMENTOS %@",array[xx]);

            
            [_listado addObject:array[xx]];
        }
        
        NSArray * sortedArray = [_listado sortedArrayUsingSelector:
                       @selector(localizedCaseInsensitiveCompare:)];
        
        _listado = [NSMutableArray arrayWithArray:sortedArray];
      
        for (int xx = 0; xx < _listado.count ; xx++){
            
            NSString * palabra = _listado[xx];
            if ([palabra isEqualToString:@"Nacional"]){
                
                [_listado removeObjectAtIndex:xx];
                [_listado insertObject:@"Nacional" atIndex:0];
            }
            if ([palabra isEqualToString:@"Presidencial"]){
                [_listado removeObjectAtIndex:xx];
                [_listado insertObject:@"Presidencial" atIndex:0];
                
            }
            
        }
        
        [tabla reloadData];
        
    }];
    
    
}



-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    [self.sidebarController dismissSidebarViewController];
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ClearOverlayNotification"
     object:nil];// cuando aparece el sidebar se crea un boton encima. Esto lo remueve
    
 
}

-(void)goToConfiguration{
    
    
    [self.sidebarController dismissSidebarViewController];

    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ClearOverlayNotification"
     object:nil];// cuando aparece el sidebar se crea un boton encima. Esto lo remueve
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"GoToSettingsNotification"
     object:nil];

}

-(void)hoverCancel:(UIButton *)boton{
 
      // boton.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.0];
    
    [boton.imageView setTintColor:[UIColor colorWithWhite:1.0 alpha:1.0] ];
}
-(void)hoverSettings:(UIButton *)boton{
    
   // boton.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    
    [boton.imageView setTintColor:[UIColor colorWithWhite:0.90 alpha:1.0] ];
    
}

-(void)debugTabla{
    
    _listado = [[NSMutableArray alloc]initWithObjects:@"Presidencial",@"Nacional",@"Metropolitano",@"Dep. Guatemala",@"Dep. Huehuetenango",@"Dep. Alta Verapaz",@"Dep. Escuintla",@"Reestablecer", nil];
    
    [tabla reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // NSLog(@" %@",_listado[indexPath.row]);
    listadoTableViewCell * cell = [[listadoTableViewCell alloc]init];
    cell.title = _listado[indexPath.row];
    
    
    UIView *bgColorView = [[UIView alloc] init];
   // bgColorView.backgroundColor = [UIColor colorWithRed:(43.0 / 255.0) green:(47.0 / 255.0) blue:(61.0 / 255.0) alpha:(1.0)];
    bgColorView.backgroundColor = [UIColor colorWithRed:(63.0 / 255.0) green:(67.0 / 255.0) blue:(81.0 / 255.0) alpha:(1.0)];
    
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"Numbers Of Rows %d",_listado.count);
    
    return _listado.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    
    
    [self.sidebarController dismissSidebarViewController];
    
    
    
    NSString * filter = _listado[indexPath.row];
    
    filterCargo = filter;
    
    if ([filterCargo  isEqual: @"Reestablecer"]){
        
        filterCargo = nil;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"changeNameNotification"
         object:@"VotoPilas"];
    }
    else{
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"changeNameNotification"
         object:filter];
    }

    
    

    
    
    //refreshFilterNotification
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"refreshFilterNotification"
     object:nil];// refresca los listados
    

     
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ClearOverlayNotification"
     object:nil];// cuando aparece el sidebar se crea un boton encima. Esto lo remueve
    

    //----Cambiar Titulo
    
     
     


}

- (void)buttonClicked:(id)sender
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"content2.jpg"]];
    self.sidebarController.contentViewController = viewController;
    [self.sidebarController dismissSidebarViewController];
}

@end
