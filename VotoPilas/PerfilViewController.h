//
//  PerfilViewController.h
//  VotoPilas
//
//  Created by Jose on 6/24/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "itemsOfPartido.h"

@interface PerfilViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong,nonatomic) itemsOfPartido * item;

@property int rating;


@end
