//
//  PartidoProfileViewController.m
//  VotoPilas
//
//  Created by Jose on 7/21/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "PartidoProfileViewController.h"
#import <Parse/Parse.h>
#import "UIImageView+WebCache.h"


extern UIView * statusBar;


@interface PartidoProfileViewController (){
    
    UIScrollView * scroll;
}

@end

@implementation PartidoProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    scroll = [[UIScrollView alloc]init];
    scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:scroll];
    
    //----------------------------------------------
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //-----------------------------------------------
    
    
    UIImageView * partidoImg = [[UIImageView alloc]init];
    partidoImg.contentMode = UIViewContentModeScaleAspectFill;
    partidoImg.clipsToBounds = true;
    partidoImg.frame = CGRectMake(0, 0, self.view.frame.size.width, 225);
    if (_partido.image != nil){
        [partidoImg sd_setImageWithURL:[NSURL URLWithString:_partido.image.url]];
    }
    [scroll addSubview:partidoImg];
    
    //------
    
    UIView * shadow = [[UIView alloc]init];
    shadow.frame =CGRectMake(0, 0, partidoImg.frame.size.width, partidoImg.frame.size.height);
    shadow.backgroundColor = [UIColor blackColor];
    shadow.alpha = 0.2;
    [partidoImg addSubview:shadow];
    
    
    UIView * gview = [[UIView alloc] initWithFrame:CGRectMake(0.0, partidoImg.frame.size.height - 80, partidoImg.frame.size.width, 80)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gview.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.5 alpha:0] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [gview.layer insertSublayer:gradient atIndex:0];
    
    [partidoImg addSubview:gview];
    
    //-----------------------------
    
    UILabel * partidoName = [[UILabel alloc]init];
    partidoName.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    partidoName.frame = CGRectMake(25, partidoImg.frame.size.height - 50, partidoImg.frame.size.width - 50, 20);
    partidoName.textColor = [UIColor whiteColor];
    partidoName.adjustsFontSizeToFitWidth = true;
    partidoName.minimumScaleFactor = 6.0 / partidoName.font.pointSize;
    partidoName.text = _partido.name;
    [partidoImg addSubview:partidoName];
    
    UILabel * partidoDate = [[UILabel alloc]init];
    partidoDate.font = [UIFont fontWithName:@"Helvetica" size:17];
    partidoDate.frame = CGRectMake(25, partidoImg.frame.size.height - 25, partidoImg.frame.size.width - 50, 20);
    partidoDate.textColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    partidoDate.adjustsFontSizeToFitWidth = true;
    partidoDate.minimumScaleFactor = 6.0 / partidoName.font.pointSize;
    partidoDate.text = [NSString stringWithFormat:@"%d",_partido.foundation.intValue];
    [partidoImg addSubview:partidoDate];
    
    //--------------------------------
    
    UILabel * direccionLabel = [[UILabel alloc]init];
    direccionLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    direccionLabel.frame = CGRectMake(15, partidoImg.frame.size.height + 15, partidoImg.frame.size.width - 50, 20);
    direccionLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    direccionLabel.adjustsFontSizeToFitWidth = true;
    direccionLabel.minimumScaleFactor = 6.0 / direccionLabel.font.pointSize;
    direccionLabel.text = [@"Dirección" uppercaseString];
    [scroll addSubview:direccionLabel];
    
    
    UILabel * direction = [[UILabel alloc]init];
    direction.font = [UIFont fontWithName:@"Helvetica" size:16];
    direction.frame = CGRectMake(15, direccionLabel.frame.origin.y + direccionLabel.frame.size.height + 5, partidoImg.frame.size.width - 50, 20);
    direction.textColor = [UIColor colorWithWhite:0 alpha:1.0];
    direction.adjustsFontSizeToFitWidth = true;
    direction.minimumScaleFactor = 6.0 / direction.font.pointSize;
    direction.text = _partido.address;
    [scroll addSubview:direction];
    
    //245	245	246
    
    UIView * line0 = [[UIView alloc]init];
    line0.frame = CGRectMake(direction.frame.origin.x, direction.frame.origin.y + direction.frame.size.height + 10, self.view.frame.size.width - 15, 1);
    line0.backgroundColor = [UIColor colorWithWhite:(245.0 / 255.0) alpha:1.0];
    [scroll addSubview:line0];
    
    
    //----------SITIO WEB
    
    UILabel * websiteLabel = [[UILabel alloc]init];
    websiteLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    websiteLabel.frame = CGRectMake(15, line0.frame.origin.y + 15, partidoImg.frame.size.width - 50, 20);
    websiteLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    websiteLabel.adjustsFontSizeToFitWidth = true;
    websiteLabel.minimumScaleFactor = 6.0 / direccionLabel.font.pointSize;
    websiteLabel.text = [@"Sitio Web" uppercaseString];
    [scroll addSubview:websiteLabel];
    
    
    UIButton * website = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    website.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    website.frame = CGRectMake(15, websiteLabel.frame.origin.y + websiteLabel.frame.size.height + 5, partidoImg.frame.size.width - 50, 20);
    //website.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    website.titleLabel.adjustsFontSizeToFitWidth = true;
    website.titleLabel.minimumScaleFactor = 6.0 / direction.font.pointSize;
    [website setTitle:_partido.website forState:UIControlStateNormal];
    [website.titleLabel setTextAlignment:NSTextAlignmentLeft];
    website.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    
    
    [scroll addSubview:website];
    [website addTarget:self action:@selector(goToSite:) forControlEvents:UIControlEventTouchUpInside];
    
    //245	245	246
    
    UIView * line1 = [[UIView alloc]init];
    line1.frame = CGRectMake(direction.frame.origin.x, website.frame.origin.y + website.frame.size.height + 10, self.view.frame.size.width - 15, 1);
    line1.backgroundColor = [UIColor colorWithWhite:(245.0 / 255.0) alpha:1.0];
    [scroll addSubview:line1];
    
    
    //--------------------------------
    
    UILabel * officesLabel = [[UILabel alloc]init];
    officesLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    officesLabel.frame = CGRectMake(15, line1.frame.origin.y + 15, partidoImg.frame.size.width - 50, 20);
    officesLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    officesLabel.adjustsFontSizeToFitWidth = true;
    officesLabel.minimumScaleFactor = 6.0 / direccionLabel.font.pointSize;
    officesLabel.text = [@"Número de oficinas" uppercaseString];
    [scroll addSubview:officesLabel];
    
    
    UILabel * offices = [[UILabel alloc]init];
    offices.font = [UIFont fontWithName:@"Helvetica" size:16];
    offices.frame = CGRectMake(15, officesLabel.frame.origin.y + officesLabel.frame.size.height + 5, partidoImg.frame.size.width - 50, 20);
    offices.textColor = [UIColor colorWithWhite:0 alpha:1.0];
    offices.adjustsFontSizeToFitWidth = true;
    offices.minimumScaleFactor = 6.0 / direction.font.pointSize;
    offices.text = [NSString stringWithFormat:@"%d OFICINAS",_partido.number_of_offices.intValue];
    [scroll addSubview:offices];
    
    //245	245	246
    
    UIView * line2 = [[UIView alloc]init];
    line2.frame = CGRectMake(direction.frame.origin.x, offices.frame.origin.y + offices.frame.size.height + 10, self.view.frame.size.width - 15, 1);
    line2.backgroundColor = [UIColor colorWithWhite:(245.0 / 255.0) alpha:1.0];
    [scroll addSubview:line2];

    //------------------------
    
    //--------------------------------
    
    UILabel * phoneLabel = [[UILabel alloc]init];
    phoneLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    phoneLabel.frame = CGRectMake(15, line2.frame.origin.y + 15, partidoImg.frame.size.width - 50, 20);
    phoneLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    phoneLabel.adjustsFontSizeToFitWidth = true;
    phoneLabel.minimumScaleFactor = 6.0 / direccionLabel.font.pointSize;
    phoneLabel.text = [@"Número de telefono" uppercaseString];
    [scroll addSubview:phoneLabel];
    
    
    UILabel * phone = [[UILabel alloc]init];
    phone.font = [UIFont fontWithName:@"Helvetica" size:16];
    phone.frame = CGRectMake(15, phoneLabel.frame.origin.y + phoneLabel.frame.size.height + 5, partidoImg.frame.size.width - 50, 20);
    phone.textColor = [UIColor colorWithWhite:0 alpha:1.0];
    phone.adjustsFontSizeToFitWidth = true;
    phone.minimumScaleFactor = 6.0 / direction.font.pointSize;
    phone.text = [NSString stringWithFormat:@"%@",_partido.phone];
    [scroll addSubview:phone];
    
    //245	245	246
    
    UIView * line3 = [[UIView alloc]init];
    line3.frame = CGRectMake(direction.frame.origin.x, phone.frame.origin.y + phone.frame.size.height + 10, self.view.frame.size.width - 15, 1);
    line3.backgroundColor = [UIColor colorWithWhite:(245.0 / 255.0) alpha:1.0];
    [scroll addSubview:line3];
    
    //------------------------
    
    
    //--------------------------------
    
    UILabel * descriptionLabel = [[UILabel alloc]init];
    descriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    descriptionLabel.frame = CGRectMake(15, line3.frame.origin.y + 15, partidoImg.frame.size.width - 50, 20);
    descriptionLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    descriptionLabel.adjustsFontSizeToFitWidth = true;
    descriptionLabel.minimumScaleFactor = 6.0 / direccionLabel.font.pointSize;
    descriptionLabel.text = [@"Descripción" uppercaseString];
    [scroll addSubview:descriptionLabel];
    
    
    UILabel * description = [[UILabel alloc]init];
    description.font = [UIFont fontWithName:@"Helvetica" size:12];
    description.frame = CGRectMake(15, descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height + 5, partidoImg.frame.size.width - 50, 100);
    description.textColor = [UIColor colorWithWhite:0 alpha:1.0];
    description.adjustsFontSizeToFitWidth = true;
    description.minimumScaleFactor = 6.0 / direction.font.pointSize;
    description.numberOfLines = 0;
    description.lineBreakMode = NSLineBreakByWordWrapping;
    if (_partido.partido_description != nil){
    description.text = [NSString stringWithFormat:@"%@",_partido.partido_description];
    }
        [scroll addSubview:description];
    
    //245	245	246
    
    UIView * line4 = [[UIView alloc]init];
    line4.frame = CGRectMake(direction.frame.origin.x, description.frame.origin.y + description.frame.size.height + 10, self.view.frame.size.width - 15, 1);
    line4.backgroundColor = [UIColor colorWithWhite:(245.0 / 255.0) alpha:1.0];
    [scroll addSubview:line4];
    
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, line4.frame.origin.y + 15);
    
    //------------------------


    

    
    //scroll.backgroundColor = [UIColor greenColor];
    

    
    


    
    
    // Do any additional setup after loading the view.
}

-(void)goToSite:(UIButton *)boton{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:boton.titleLabel.text]];

    
}

-(void)viewWillAppear:(BOOL)animated{
    statusBar.hidden = true;
    self.navigationController.navigationBar.backgroundColor =  [UIColor clearColor];

}

-(void)viewWillDisappear:(BOOL)animated{
    
    statusBar.hidden = false;
    
    self.navigationController.navigationBar.backgroundColor =  [UIColor colorWithRed:(34.0 / 255.0) green:(175.0 / 255.0) blue:(241.0 / 255.0) alpha:1.0];
    
    
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
