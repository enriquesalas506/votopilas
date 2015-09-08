//
//  PerfilViewController.m
//  VotoPilas
//
//  Created by Jose on 6/24/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "PerfilViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "globalVars.h"
#import "politicaTableViewCell.h"
#import "recomendacionCellTableViewCell.h"
#import "infoSourceModel.h"
#import "comentariosTableViewCell.h"
#import "politicalExperienceModel.h"
#import "laboralExperienceModel.h"
#import "laboralTableViewCell.h"
#import "reviewViewController.h"


#import "educatioModel.h"
#import "educationTableViewCell.h"

#import "loginFacebookViewController.h"

#import <Parse/Parse.h>

#import "UIImage+StackBlur.h"

#import "UIImage+BlurredFrame.h"

#import "MBProgressHUD.h"

#import "HeaderGeneralTable.h"

#import "loginEmailViewController.h"

#import "createAccountViewController.h"

#import "logInViewController.h"


extern CGFloat navHeight;

extern UIView * statusBar;


@interface PerfilViewController ()

@end


@implementation PerfilViewController{
    
    BOOL reviewCounter;
    //----------------
    
    UIScrollView * scroll;
    UITableView * expPolitica;
    UITableView * expLaboral;
    UITableView * expEducacion;
    UITableView * reviewTable;
    UITableView * commentsTable;
    UIButton * escribirComentario;
    UIImageView * imagenPefil;
    UIView * shadow ;
    
    UIView * gview;
    loginFacebookViewController * facebook;
    
    CGFloat whiteColor;
    UILabel * partidoLabel;

    UILabel * partidoName;
    UILabel * name ;
    UILabel * nacimiento;
    UIView * starLayer;
    UIButton * reviewButton;
    UILabel * listadoLabel;
    UILabel * listado;
    UILabel * puestoLabel;
    UILabel * puesto ;
    UIView * line1 ;
    UILabel * exp;
    UIView * line2 ;
    UILabel * lab ;
    UIView * barragview;

    
    CAGradientLayer *barragradient;
    
    UIImageView * circleProfile;
    
    
    UITableView * generalTable;

}


-(void)omitirBoton{
    
    [facebook dismissViewControllerAnimated:true completion:nil];
    
}
-(void)goToValoraciones{
    
    [facebook dismissViewControllerAnimated:true completion:nil];
    
    [self performSelector:@selector(makeReview) withObject:nil afterDelay:1.0];
    
}

-(UIImage *)makeBlur:(UIImageView *)holder blur:(CGFloat)blur{
    
    //--------------------------
    UIGraphicsBeginImageContext(holder.bounds.size);
    [holder.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Blur the UIImage with a CIFilter
    CIImage *imageToBlur = [CIImage imageWithCGImage:viewImage.CGImage];
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: blur] forKey: @"inputRadius"];
    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
    UIImage *endImage = [[UIImage alloc] initWithCIImage:resultImage];
    //--------------------------
    
    return  endImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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

    
    reviewCounter =false;
    
    // Do any additional setup after loading the view.
    
    //--------------SETUP NAVIGATION
    whiteColor = 1;
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //Helvetica
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    //self.navigationItem.title = _item.partido;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    scroll = [[UIScrollView alloc]init];
    scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height );
    scroll.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1];
    
    [self.view addSubview:scroll];
    
    
    //--------------SETUP NAVIGATION
    
    
    //---------------SETUP IMAGE
    
    imagenPefil = [[UIImageView alloc]init];
    
    
    
   
    
    shadow = [[UIView alloc]init];
    
    gview = [[UIView alloc] initWithFrame:CGRectMake(0.0, imagenPefil.frame.size.height - 80, imagenPefil.frame.size.width, 80)];
      //--------------PROPERTIES
    
    partidoName = [[UILabel alloc]init];
    
    partidoLabel = [[UILabel alloc]init];
    
    
    name = [[UILabel alloc]init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:_item.fechaDeNaciomiento];

    

    
    nacimiento = [[UILabel alloc]init];
    
    //-----------------------RATING
    
    starLayer = [[UIView alloc]init];
    CGFloat starX = 25;
    CGFloat starY = starLayer.frame.origin.y + (starLayer.frame.size.height / 2) - (10) ;

    
   

    
    //--------------REVIEW BUTTON
    
    
    reviewButton = [[UIButton alloc]init];
  
    
    //--------------REVIEW BUTTON
    
    //-------------Listado
    
    
    listadoLabel = [[UILabel alloc]init];
    
    listado = [[UILabel alloc]init];
    
    //-------------Puesto
    
    
    puestoLabel = [[UILabel alloc]init];
    
    puesto = [[UILabel alloc]init];
       //172	174	179
    
    UIView * sectionLine = [[UIView alloc]init];
    
    
    CGFloat expY = imagenPefil.frame.size.height;
    exp = [[UILabel alloc]init];
    
    
    //159	159	159
    UIView * line = [[UIView alloc]init];
    

    expPolitica = [[UITableView alloc]init];
    
    
    //-------EXPERIENCIA Laboral

    //205	206	210
    line1 = [[UIView alloc]init];
    
    lab = [[UILabel alloc]init];
    
    expLaboral = [[UITableView alloc]init];
       //-------Educacion
    
    line2 = [[UIView alloc]init];
   
    
    UILabel * edu = [[UILabel alloc]init];
    
    //--------
    
    //NSLog(@"EDUCACION COUNT %d",_item.educacion.count);
    
    expEducacion = [[UITableView alloc]init];
    
    //----------------------COMMENTS
    
    //NSLog(@"RECOMENDACIONES VIP %d",_item.recomendacionesVIP.count);
    
    escribirComentario  =  [UIButton buttonWithType:UIButtonTypeRoundedRect ];
    
    reviewTable = [[UITableView alloc]init];
 
    
    
    
    
    
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, reviewTable.frame.origin.y + reviewTable.frame.size.height
                                    );

    
    
    
    //--------BARRA
    barragview = [[UIView alloc]init];
    barragradient = [CAGradientLayer layer];
    barragradient.frame = CGRectMake(0, 0, self.view.frame.size.width, 65);
    barragradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0 alpha:1] CGColor], (id)[[UIColor colorWithWhite:0.1
                                                                                                                              alpha:0] CGColor], nil];
    [barragview.layer insertSublayer:barragradient atIndex:0];
    
    [self.view addSubview:barragview];

    
    
    
    
    //---------------------
    
    imagenPefil = [[UIImageView alloc]init];
    imagenPefil.frame = CGRectMake(0, 0, (self.view.frame.size.width ) , 250);
    imagenPefil.contentMode = UIViewContentModeScaleAspectFill;
    imagenPefil.clipsToBounds = true;
    
    
    UIView * placeholderview = [[UIView alloc]init];
    placeholderview.frame = CGRectMake(0, 0, imagenPefil.frame.size.width, imagenPefil.frame.size.height);
    //24	113	153
    placeholderview.backgroundColor = [UIColor colorWithRed:(24.0 / 255.0) green:(113.0 / 255.0) blue:(153.0 / 255.0) alpha:1.0];
    
    UIImage * perfilPlaceholder =  [PerfilViewController imageWithView:placeholderview];
    
    
    [imagenPefil sd_setImageWithURL: [NSURL URLWithString:_item.imagen] placeholderImage:perfilPlaceholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        if (_item.imagen != nil){
            
            
            
            imagenPefil.image = [imagenPefil.image  applyLightEffectAtFrame:CGRectMake(0, 0, imagenPefil.image.size.width, imagenPefil.image.size.height)];
        }
        
        
    } ];
    

    
    shadow = [[UIView alloc]init];
    shadow.frame = CGRectMake(0, 0, self.view.frame.size.width, imagenPefil.frame.size.height);
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.40;
    if (_item.imagen != nil){
        [imagenPefil addSubview:shadow];
    }

    
    
    gview = [[UIView alloc] initWithFrame:CGRectMake(0.0, imagenPefil.frame.size.height - 80, imagenPefil.frame.size.width, 80)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gview.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.5 alpha:0] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [gview.layer insertSublayer:gradient atIndex:0];
    
    
    if (_item.imagen != nil){
        
        [imagenPefil addSubview:gview];
        
    }
    //-----

    
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshLayoutNotification" object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(refreshViews)
     name:@"refreshLayoutNotification"
     object:nil];
    
    
    
    [_item updateExperienciaLaboral:_item.laboralRelation];
    [_item updateEducacion:_item.educationRelation];
    [_item updateExperienciaPolitica:_item.politicalRelation];
    
    
    //-----------------------------------------------------

    
    [self refreshViews];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    
    //------------------
    
    
    
    
    
    
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


-(void)refreshViews{
    
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:true];
    
    reviewCounter =false;
    
    // Do any additional setup after loading the view.
    
    //--------------SETUP NAVIGATION
    whiteColor = 1;
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //Helvetica
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    //self.navigationItem.title = _item.partido;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    NSArray *viewsToRemove = [scroll subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height );
    scroll.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1];
    
    [self.view addSubview:scroll];
    
    
    //--------------SETUP NAVIGATION
    
    
    //---------------SETUP IMAGE
    
    
    
    
    //placeholder
    
    
    [scroll addSubview:imagenPefil];//hechemos punta
    
    //---------------
    
    
    
    //----------SHADOW
    
  /*
       
   ---------PROPERTIES
    
   */
    
    
    
    name = [[UILabel alloc]init];
    name.frame = CGRectMake(25, imagenPefil.frame.size.height - 65,imagenPefil.frame.size.width - 50, 30);
    name.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    name.text = [_item.nombre capitalizedString];
    //name.numberOfLines = 0;
    name.textAlignment = NSTextAlignmentCenter;
    name.adjustsFontSizeToFitWidth =true;
    name.minimumScaleFactor = 5.0 / name.font.pointSize;
    name.textColor = [UIColor colorWithWhite:1 alpha:1];
    [imagenPefil addSubview: name];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:_item.fechaDeNaciomiento];
    
    
    
    //-------FECHA DE NACIMIENTO
    
    NSInteger age = 0;
    
    if (_item.fechaDeNaciomiento != nil){
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:_item.fechaDeNaciomiento
                                       toDate:now
                                       options:0];
    age = [ageComponents year];
        
    }
    
    //--------FECHA DE NACIMIENTO
    
    
    
    nacimiento = [[UILabel alloc]init];
    nacimiento.frame = CGRectMake(25, imagenPefil.frame.size.height - 45,imagenPefil.frame.size.width - 50, 30);
    nacimiento.font = [UIFont fontWithName:@"Helvetica" size:13];
    nacimiento.text = [NSString stringWithFormat:@"%@ (%d años)",stringFromDate,age] ;
    
    //name.numberOfLines = 0;
    //name.lineBreakMode = NSLineBreakByWordWrapping;
    nacimiento.adjustsFontSizeToFitWidth =true;
    nacimiento.minimumScaleFactor = 5.0 / name.font.pointSize;
    nacimiento.textColor = [UIColor colorWithWhite:0.8 alpha:1];
    nacimiento.textAlignment = NSTextAlignmentCenter;
    if (_item.fechaDeNaciomiento == nil){
        nacimiento.hidden =true;
    }
    [imagenPefil addSubview: nacimiento];
    
    
    //-----------CIRCLE IMAGE
    
    circleProfile = [[UIImageView alloc]init];
    
    circleProfile.frame = CGRectMake((imagenPefil.frame.size.width / 2) - 60, (imagenPefil.frame.size.height / 2) - 60, 120, 120);
    
    [circleProfile sd_setImageWithURL: [NSURL URLWithString:_item.imagen] placeholderImage:[UIImage imageNamed:@"user-photo.png"] ];

    circleProfile.contentMode = UIViewContentModeScaleAspectFill;
    
    circleProfile.clipsToBounds = true;
    
    circleProfile.layer.cornerRadius = circleProfile.frame.size.width / 2;
    
    [imagenPefil addSubview:circleProfile];
    
    [imagenPefil addSubview:circleProfile];
    
    
    //-----------------------RATING
    
    starLayer = [[UIView alloc]init];
    starLayer.frame = CGRectMake(0, imagenPefil.frame.size.height, self.view.frame.size.width, 40);
    starLayer.backgroundColor = [UIColor colorWithRed:(234.0 / 255.0) green:(234.0 / 255.0) blue:(234.0 / 255.0) alpha:1.0];
    [scroll addSubview:starLayer];
    
    
    CGFloat starX = 25;
    CGFloat starY = starLayer.frame.origin.y + (starLayer.frame.size.height / 2) - (10) ;
    
    
    for (int ss = 0; ss< 5 ; ss++){
        
        
        UIImageView * star = [[UIImageView alloc]init];
        star.frame = CGRectMake(starX + (25 * ss), starY, 20, 20);
        
        //[star setImage:[UIImage imageNamed:@"StarFilled.png"]];
        
        star.contentMode = UIViewContentModeScaleToFill;
        
        [scroll addSubview:star];
        
        // star.backgroundColor = [UIColor grayColor];
        
        //177	127	9
        
        //star.image = [star.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        if (_rating > ss){
            // UIColor * bColor = [UIColor colorWithRed:(177.0 / 255.0) green:(127.0 / 255.0) blue:(9.0 / 255.0) alpha:(1.0)];
            // [star setTintColor: bColor];
            [star setImage:[UIImage imageNamed:@"StarFilled.png"]];
        }else
        {
            //    UIColor * bColor = [UIColor colorWithWhite:0.2 alpha:1.0];
            //    [star setTintColor: bColor];
            [star setImage:[UIImage imageNamed:@"StarOutlined.png"]];
            //[star setImage:[UIImage imageNamed:@"StarFilled.png"]];
        }
        
        
    }
    
    
    
    //--------------REVIEW BUTTON
    
    
    reviewButton = [[UIButton alloc]init];
    reviewButton.frame = CGRectMake(self.view.frame.size.width - 100, imagenPefil.frame.origin.y + imagenPefil.frame.size.height - 50, 100, 100);
    [reviewButton setImage:[UIImage imageNamed:@"rate-float-button.png"] forState:UIControlStateNormal];
    [reviewButton addTarget:self action:@selector(makeReview) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:reviewButton];
    
    
    
    
    //--------------REVIEW BUTTON
    
    //-------------Listado
    
    
    listadoLabel = [[UILabel alloc]init];
    listadoLabel.frame = CGRectMake(25, starLayer.frame.origin.y + starLayer.frame.size.height + 10,150, 17);
    listadoLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    listadoLabel.text = @"LISTADO" ;
    //name.numberOfLines = 0;
    //name.lineBreakMode = NSLineBreakByWordWrapping;
    listadoLabel.adjustsFontSizeToFitWidth =true;
    listadoLabel.minimumScaleFactor = 5.0 / name.font.pointSize;
    listadoLabel.textColor = [UIColor colorWithWhite:(170.0 / 255.0) alpha:1];
    [scroll addSubview: listadoLabel];
    
    
    listado = [[UILabel alloc]init];
    listado.frame = CGRectMake(25, listadoLabel.frame.origin.y + listadoLabel.frame.size.height ,150, 25);
    listado.font = [UIFont fontWithName:@"Helvetica" size:16];
    listado.text = [[NSString stringWithFormat:@"%d. %@",_item.posicionListado,_item.listado] uppercaseString] ;
    //name.numberOfLines = 0;
    //name.lineBreakMode = NSLineBreakByWordWrapping;
    listado.adjustsFontSizeToFitWidth =true;
    listado.minimumScaleFactor = 5.0 / name.font.pointSize;
    listado.textColor = [UIColor colorWithWhite:(0.0 / 255.0) alpha:1];
    [scroll addSubview: listado];
    
    //-------------Puesto
    
    
    puestoLabel = [[UILabel alloc]init];
    puestoLabel.frame = CGRectMake(25, listado.frame.origin.y + listado.frame.size.height + 10,150, 17);
    puestoLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    puestoLabel.text = @"PUESTO" ;
    //name.numberOfLines = 0;
    //name.lineBreakMode = NSLineBreakByWordWrapping;
    puestoLabel.adjustsFontSizeToFitWidth =true;
    //puestoLabel.minimumScaleFactor = 5.0 / name.font.pointSize;
    puestoLabel.textColor = [UIColor colorWithWhite:(170.0 / 255.0) alpha:1];
    [scroll addSubview: puestoLabel];
    
    
    puesto = [[UILabel alloc]init];
    puesto.frame = CGRectMake(25, puestoLabel.frame.origin.y + puestoLabel.frame.size.height ,200, 25);
    puesto.font = [UIFont fontWithName:@"Helvetica" size:16];
    puesto.text = [[NSString stringWithFormat:@"CANDIDATO A %@",_item.cargo] uppercaseString] ;
    //name.numberOfLines = 0;
    //name.lineBreakMode = NSLineBreakByWordWrapping;
    puesto.adjustsFontSizeToFitWidth =true;
    //puesto.minimumScaleFactor = 5.0 / name.font.pointSize;
    puesto.textColor = [UIColor colorWithWhite:(0.0 / 255.0) alpha:1];
    [scroll addSubview: puesto];
    
    //172	174	179
    
    
    
    partidoLabel = [[UILabel alloc]init];
    partidoLabel.frame = CGRectMake(25, puesto.frame.origin.y + puesto.frame.size.height ,200, 25);
    partidoLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    partidoLabel.text = @"PARTIDO" ;
    //name.numberOfLines = 0;
    //name.lineBreakMode = NSLineBreakByWordWrapping;
    partidoLabel.adjustsFontSizeToFitWidth =true;
    //puestoLabel.minimumScaleFactor = 5.0 / name.font.pointSize;
    partidoLabel.textColor = [UIColor colorWithWhite:(170.0 / 255.0) alpha:1];
    [scroll addSubview: partidoLabel];

    
    
    partidoName.frame = CGRectMake(25,  partidoLabel.frame.origin.y + partidoLabel.frame.size.height ,200, 25);
    partidoName.font = [UIFont fontWithName:@"Helvetica" size:16];
    partidoName.text = _item.partido ;
    partidoName.textAlignment = NSTextAlignmentLeft;
    //name.numberOfLines = 0;
    //name.lineBreakMode = NSLineBreakByWordWrapping;
    partidoName.adjustsFontSizeToFitWidth =true;
    partidoName.minimumScaleFactor = 5.0 / partidoName.font.pointSize;
    partidoName.textColor = [UIColor colorWithWhite:0 alpha:1];
    [scroll addSubview: partidoName];
    
    
    
   
    //------------------------
    
    
    generalTable = [[UITableView alloc]init];
    generalTable.frame = CGRectMake(0, partidoName.frame.origin.y + partidoName.frame.size.height + 15, self.view.frame.size.width, 40);
    generalTable.delegate = self;
    generalTable.dataSource = self;
    generalTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    generalTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [scroll addSubview:generalTable];
    
    
    
    escribirComentario  =  [UIButton buttonWithType:UIButtonTypeRoundedRect ];
    escribirComentario.frame = CGRectMake(25, generalTable.frame.origin.y + generalTable.frame.size.height, self.view.frame.size.width - 50, 30);
    
    [escribirComentario setTitle:@"ESCRIBIR UN COMENTARIO" forState:UIControlStateNormal];
    
    [escribirComentario addTarget:self action:@selector(makeReview) forControlEvents:UIControlEventTouchUpInside];
    
    [scroll addSubview:escribirComentario];
    
    reviewTable = [[UITableView alloc]init];
    reviewTable.backgroundColor = [UIColor colorWithWhite:whiteColor alpha:1];
    reviewTable.allowsSelection = NO;
    reviewTable.frame = CGRectMake(0, escribirComentario.frame.origin.y + escribirComentario.frame.size.height, self.view.frame.size.width, 150 * _item.recomendacionesVIP.count);
    
    reviewTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    reviewTable.separatorColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    reviewTable.separatorInset = UIEdgeInsetsMake(0, 30, 0, 0);
    
    
    reviewTable.delegate =self;
    reviewTable.dataSource = self;
    [scroll addSubview:reviewTable];
    
    
    
    //--------BARRA
    
    
    [self.view bringSubviewToFront:barragview];
    
    
    
    

    
    

    
    
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, reviewTable.frame.origin.y + reviewTable.frame.size.height
                                    );
    
    
    
    
}


-(void)resizeTable{
    
    generalTable.frame = CGRectMake(0, partidoName.frame.origin.y + partidoName.frame.size.height + 15, self.view.frame.size.width, generalTable.contentSize.height);
    
    
 //   generalTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    generalTable.allowsSelection = NO;
    
    escribirComentario.frame = CGRectMake(25, generalTable.frame.origin.y + generalTable.frame.size.height + 25, self.view.frame.size.width - 50, 30);

    
    reviewTable.frame = CGRectMake(0, escribirComentario.frame.origin.y + escribirComentario.frame.size.height , self.view.frame.size.width, 150 * _item.recomendacionesVIP.count);

    
    
    
    
    
    
    
    
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, reviewTable.frame.origin.y + reviewTable.frame.size.height
                                    );

}

-(void)makeReview{
    
    if ( [PFUser currentUser]){
    
    reviewViewController * review = [[reviewViewController alloc]init];
    
    review.politicalObject = _item.politicianObject;
    
    [self.navigationController pushViewController:review animated:true];
    }else{
        
        facebook = [[loginFacebookViewController alloc]init];
        facebook.controller = self;

        
        if ([[UIDevice currentDevice].systemVersion integerValue] >= 8 )
        {
            //For iOS 8
            self.providesPresentationContextTransitionStyle = true;
            self.definesPresentationContext = true;
            facebook.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            facebook.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        else
        {
            //For iOS 7
            facebook.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
        
        
        
        [self presentViewController:facebook animated:true completion:^{
        }];

    
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    statusBar.hidden = true;
    self.navigationController.navigationBar.backgroundColor =  [UIColor clearColor];
    self.navigationController.navigationBarHidden = false;
    
    [self downloadRating];//descargar rating
    
    

}

-(void)viewWillDisappear:(BOOL)animated{
    
    
    [partidoName removeFromSuperview];
    
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"omitirNotification" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userLoggedInNotification" object:nil];
        
        
    
    
    statusBar.hidden = false;
    
    self.navigationController.navigationBar.backgroundColor =  [UIColor colorWithRed:(34.0 / 255.0) green:(175.0 / 255.0) blue:(241.0 / 255.0) alpha:1.0];
    
    
}



-(void)viewDidAppear:(BOOL)animated{
    
    
    
    [super viewDidAppear:animated];
    
      [expPolitica beginUpdates];
    [expPolitica reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [expPolitica endUpdates];
    

}


//-----------TABLE
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (generalTable == tableView){
    return 3;
    }
    if (reviewTable == tableView){
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   
    if (generalTable == tableView){
    if (section == 0){
        
        return _item.experienciaPolitica.count;
        
    }
    if (section == 1){
        
        return _item.experienciaLaboral.count;
        
    }
    if (section == 2){
        
        return _item.educacion.count;
        
    }
    
   
    }
    
   
    if (tableView == reviewTable){
        
        return _item.recomendacionesVIP.count;
        
    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (generalTable == tableView){

    if (indexPath.section == 0){
        
        politicaTableViewCell * cell = [[politicaTableViewCell alloc]init];
        
        politicalExperienceModel * politicalModel = _item.experienciaPolitica[indexPath.row];

        cell.title = politicalModel.puesto;
        
        cell.beginDate = politicalModel.startDate;
        cell.endDate = politicalModel.endDate;
        cell.job_description = politicalModel.job_description;
        
        cell.backgroundColor = [UIColor colorWithWhite:whiteColor alpha:1];

        
        [self resizeTable];

        
        return cell;

        
    }
    if (indexPath.section == 1){
        
        laboralTableViewCell * cell = [[laboralTableViewCell alloc]init];
        
        laboralExperienceModel * politicalModel = _item.experienciaLaboral[indexPath.row];
        
        cell.title = politicalModel.puesto;
        
        cell.beginDate = politicalModel.startDate;
        cell.endDate = politicalModel.endDate;
        cell.place = politicalModel.place;
        cell.job_description = politicalModel.job_description;
        
        cell.backgroundColor = [UIColor colorWithWhite:whiteColor alpha:1];
        
        [self resizeTable];

        
        return cell;
        
        
        
    }
    if (indexPath.section == 2){
        
        
        educationTableViewCell * cell = [[educationTableViewCell alloc]init];
        
        educatioModel * politicalModel = _item.educacion[indexPath.row];
        
        cell.title = politicalModel.puesto;
        
        cell.beginDate = politicalModel.startDate;
        cell.endDate = politicalModel.endDate;
        cell.place = politicalModel.place;
        cell.job_description = politicalModel.job_description;
        
        cell.backgroundColor = [UIColor colorWithWhite:whiteColor alpha:1];
        
        
        [self resizeTable];

        
        return cell;
        
        
    }
        
        
        
    }
    
    if (tableView == reviewTable){
        
        reviewCounter = !reviewCounter;

        
        recomendacionCellTableViewCell * cell = [[recomendacionCellTableViewCell alloc]init];
        
        cell.direction = reviewCounter;
        
        infoSourceModel * info = _item.recomendacionesVIP[indexPath.row];
        
        cell.title = info.name;
        cell.rating = info.rating;
        cell.message = info.message;
        cell.fbId = info.fbId;
        cell.backgroundColor = [UIColor colorWithWhite:whiteColor alpha:1];
        
        
        return cell;
        
        
    }
    
    
    //------------------------------------
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableView == generalTable){
        
        
        if (indexPath.section == 0){
            
            
            CGFloat addPuesto;
            CGFloat addDescriptiom;
            
            
            politicalExperienceModel * politicalModel = _item.experienciaPolitica[indexPath.row];
            
            addPuesto = [self getHeightForText: [politicalModel.puesto uppercaseString] withFont:[UIFont systemFontOfSize:15] andWidth:150];
            
            addDescriptiom = [self getHeightForTextWithNoDefault: politicalModel.description withFont:[UIFont systemFontOfSize:8]  andWidth:self.view.frame.size.width - 40];
            
         
            
            return 50 + addPuesto + addDescriptiom;
        }
        
        if (indexPath.section == 1){
            
            CGFloat addPuesto;
            CGFloat addDescriptiom;
            CGFloat addPlace;
            
            
            educatioModel * politicalModel = _item.experienciaLaboral[indexPath.row];
            
            addPuesto = [self getHeightForText: [politicalModel.puesto uppercaseString] withFont:[UIFont systemFontOfSize:15] andWidth:150];
            
            addDescriptiom = [self getHeightForTextWithNoDefault: politicalModel.description withFont:[UIFont systemFontOfSize:10]  andWidth:self.view.frame.size.width - 40];
            
            
            addPlace = [self getHeightForTextWithNoDefault: [politicalModel.place uppercaseString] withFont:[UIFont systemFontOfSize:15]  andWidth:
                        200];
            
            
            
            return 25 + addPuesto + 50+ addPlace + addDescriptiom ;
        }

        
        if (indexPath.section == 2){
            
            CGFloat addPuesto;
            CGFloat addDescriptiom;
            CGFloat addPlace;


            educatioModel * politicalModel = _item.educacion[indexPath.row];

            addPuesto = [self getHeightForText: [politicalModel.puesto capitalizedString] withFont:[UIFont systemFontOfSize:15] andWidth:150];
            
            addDescriptiom = [self getHeightForTextWithNoDefault: politicalModel.description withFont:[UIFont systemFontOfSize:10]  andWidth:self.view.frame.size.width - 40];

            
            addPlace = [self getHeightForTextWithNoDefault: [politicalModel.place capitalizedString]withFont:[UIFont systemFontOfSize:15]  andWidth:
                        200];

            
                
            return 25 + addPuesto + 50+ addPlace + addDescriptiom ;
        }
        
        return 100;
        
    }
    
    if (tableView == reviewTable){
        
        
       
        
        
        return  150;
    }

    
    return 50.0;
}

-(float) getHeightForText:(NSString*) text withFont:(UIFont*) font andWidth:(float) width{
    CGSize constraint = CGSizeMake(width , 20000.0f);
    CGSize title_size;
    float totalHeight;
    
    SEL selector = @selector(boundingRectWithSize:options:attributes:context:);
    if ([text respondsToSelector:selector]) {
        title_size = [text boundingRectWithSize:constraint
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{ NSFontAttributeName : font }
                                        context:nil].size;
        
        totalHeight = ceil(title_size.height);
    } else {
        title_size = [text sizeWithFont:font
                      constrainedToSize:constraint
                          lineBreakMode:NSLineBreakByWordWrapping];
        totalHeight = title_size.height ;
    }
    
    CGFloat height = MAX(totalHeight, 25.0f);
    return height;
}

-(float) getHeightForTextWithNoDefault:(NSString*) text withFont:(UIFont*) font andWidth:(float) width{
    CGSize constraint = CGSizeMake(width , 20000.0f);
    CGSize title_size;
    float totalHeight;
    
    SEL selector = @selector(boundingRectWithSize:options:attributes:context:);
    if ([text respondsToSelector:selector]) {
        title_size = [text boundingRectWithSize:constraint
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{ NSFontAttributeName : font }
                                        context:nil].size;
        
        totalHeight = ceil(title_size.height);
    } else {
        title_size = [text sizeWithFont:font
                      constrainedToSize:constraint
                          lineBreakMode:NSLineBreakByWordWrapping];
        totalHeight = title_size.height ;
    }
    
    CGFloat height = MAX(totalHeight, 0.0f);
    return height;
}

//-----------TABLE

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)downloadRating{
    
    // NSLog(@"DOWNLOADING RATING");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    NSMutableArray * ratingList = [[NSMutableArray alloc]init];
    
    PFQuery *rateQuery = [PFQuery queryWithClassName:@"Rating"];
    [rateQuery includeKey:@"politician"];
    [rateQuery includeKey:@"user"];
    
    [rateQuery whereKey:@"politician" equalTo:_item.politicianObject];
    
    [rateQuery findObjectsInBackgroundWithBlock:^(NSArray *preRatingList, NSError *error) {
        
        
        if (!error) {
            
            
            
            
            
            int noVipCount = 0;
            float avgRateNumber = 0;
            
            int VipCount = 0;
            float avgVipNumber = 0;
            
            
            _item.recomendacionesVIP = [[NSMutableArray alloc] init];
            _item.recomendacionesNOVIP = [[NSMutableArray alloc] init];
            
            
            for (int rr = 0; rr < preRatingList.count; rr++) {
                
                NSObject * rateObject = preRatingList[rr];
                
                
                PFObject * userObject = [rateObject valueForKey:@"user"];
                
                NSNumber * isVIP = [userObject objectForKey:@"vip"];
                if (isVIP.boolValue == true){
                    
                    infoSourceModel * rateModel = [[infoSourceModel alloc]init];
                    rateModel.title = [userObject objectForKey:@"fbId"];
                    rateModel.fbId = [userObject objectForKey:@"fbId"];
                    
                    NSNumber * rateNumber = [rateObject valueForKey:@"value"];
                    
                    
                    rateModel.rating = rateNumber.intValue;
                    rateModel.name = [userObject objectForKey:@"name"];
                    
                    rateModel.message = [rateObject valueForKey:@"message"];
                    
                    rateModel.isVip = [rateObject valueForKey:@"vip"];
                    
                    
                    [ratingList addObject:rateModel];
                    
                    
                    
                    
                    if (rateModel.fbId != nil){
                        NSNumber * filterValue = [defaults objectForKey:rateModel.fbId];
                        
                        
                        
                        if (filterValue.intValue || filterValue==nil){
                            
                            avgVipNumber = avgVipNumber + rateNumber.floatValue;
                            VipCount++;
                            

                            
                            [_item.recomendacionesVIP addObject:rateModel];
                            
                        }
                        
                    }
                    
                    
                }else{
                    
                    NSNumber * rateNumber = [rateObject valueForKey:@"value"];
                    
                    
                    //--------NO VIP
                    
                    
                    
                    
                    infoSourceModel * rateModel = [[infoSourceModel alloc]init];
                    rateModel.title = [userObject objectForKey:@"fbId"];
                    rateModel.fbId = [userObject objectForKey:@"fbId"];
                    
                    rateModel.rating = rateNumber.intValue;
                    rateModel.name = [userObject objectForKey:@"name"];
                    rateModel.message = [rateObject valueForKey:@"message"];
                    
                    rateModel.isVip = [rateObject valueForKey:@"vip"];
                    
                    
                    
                    NSNumber * filterValue = [defaults objectForKey:@"todos"];
                    
                    
                    
                    if (filterValue.intValue || filterValue==nil){
                        
                        [_item.recomendacionesVIP addObject:rateModel];
                        
                        noVipCount++;
                        avgRateNumber = rateNumber.floatValue + avgRateNumber;
                        

                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
                
                if (noVipCount > 0){
                    infoSourceModel * rateTodos = [[infoSourceModel alloc]init];
                    rateTodos.title = @"todos";
                    rateTodos.rating = avgRateNumber / (float)noVipCount;
                    [ratingList addObject:rateTodos];
                }
                
                
                
            }
            
            
            
            
            if (VipCount > 0 ){
                
                _rating = avgVipNumber / (float)VipCount;
                
            }
            if (noVipCount > 0){
                

                if (VipCount > 0){
                    _rating = (_rating + (avgRateNumber / (float)noVipCount))/2;
                }else{
                    _rating = (avgRateNumber / (float)noVipCount);
                    
                }
            
            }
            
            
            
            
            //------------SAVING RATING
            
            NSString * ratingKey = [NSString stringWithFormat:@"%@%@",@"rating",_item.politicianObject.objectId];

            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[NSNumber numberWithInt:_rating] forKey:ratingKey];
            [defaults synchronize];
            
            //------------SAVING RATING
            

            
            
            _item.recomendaciones = [NSMutableArray arrayWithArray:ratingList];
            
            
            
            
            
            //NSLog(@"FINISHED DOWNLOADING RATING %d",_rating);
            
            [self refreshViews];
            
            
        }else{
            
            NSLog(@"Error downloading Rating");
        }
        
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if (tableView == generalTable){
        
        
        if (section == 0){
            
            
            if (_item.experienciaPolitica.count > 0){
                
                
                return 35;
            }
        }
        
        if (section == 1){
            
            if (_item.experienciaLaboral.count > 0){
                
                
                return 35;
            }
          
        }
        
        
        if (section == 2){
            
            if (_item.educacion.count > 0){
                
                
                return 35;
            }
        
        }
    
    }
    
    if (tableView == reviewTable){
        
        
        
        
        
        return  0;
    }
 
    
    
    
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == generalTable){
        
        
        if (section == 0){
            
            
            
            HeaderGeneralTable * header = [[HeaderGeneralTable alloc]init];
            header.title = @"Experiencia Política";
            header.frame = CGRectMake(0, 0, self.view.frame.size.width, 35);
            
                
                return header;
            
        }
        
        if (section == 1){
            
            HeaderGeneralTable * header = [[HeaderGeneralTable alloc]init];
            header.title = @"Experiencia Laboral";
            header.frame = CGRectMake(0, 0, self.view.frame.size.width, 35);

            
                
                return header;
            
            
        }
        
        
        if (section == 2){
            
            HeaderGeneralTable * header = [[HeaderGeneralTable alloc]init];
            header.title = @"Educación";
            header.frame = CGRectMake(0, 0, self.view.frame.size.width, 35);

                
                return header;
            
            
        }
        
    }
    
    
    UIView * header = [[UIView alloc]init];
    
    
    return header;
}


@end
