//
//  customTableView.m
//  VotoPilas
//
//  Created by Jose on 7/2/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "customTableView.h"

@implementation customTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)didMoveToSuperview{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshTableNotification" object:nil];
    
    /*
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reloadData)
     name:@"RefreshTableNotification"
     object:nil];
    */
    //----------------
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshSectionNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reloadData)
     name:@"RefreshSectionNotification"
     object:nil];

    

}

-(void) forceReload{
     [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

@end
