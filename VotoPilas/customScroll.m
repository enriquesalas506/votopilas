//
//  customScroll.m
//  VotoPilas
//
//  Created by Jose on 7/3/15.
//  Copyright (c) 2015 Jose. All rights reserved.
//

#import "customScroll.h"

@implementation customScroll{
    
    NSTimer * timer;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

extern int scrollCurrentPage;


- (void)didMoveToSuperview{
    
    self.delegate = self;
    
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    
    self.pagingEnabled = true;
    
   // self.scrollEnabled = false;
   // self.delaysContentTouches = true;
    
    //finishedHighlightingNote
    
 
}

-  (void)handleLongPress:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        
        
      //  [self setScrollEnabled:true];
      //  [self becomeFirstResponder];
        //Do Whatever You want on End of Gesture
    }
    else if (sender.state == UIGestureRecognizerStateBegan){
        NSLog(@"UIGestureRecognizerStateBegan.");
        //Do Whatever You want on Began of Gesture
    }
}


-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"Left Swipe");
    
    [self moveScrollToNext];
    
}
-(void)swipeRight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"Right Swipe");
    
    [self moveScrollToPrevious];
    
    
}


-(void)moveToScroll:(int)item{
   
    
    CGFloat scrollTo = self.frame.size.width * (item);
    [self setContentOffset:CGPointMake(scrollTo, 0) animated:false];
    
    

    
}

-(void)moveScrollToNext{
    int numberOfSlides = self.contentSize.width / self.frame.size.width;
    int currenSlide = 0;
    
    for (int xx = 0 ; xx < numberOfSlides - 1; xx++) {
        
        CGFloat minX = self.frame.size.width * xx;
        CGFloat maxX = (self.frame.size.width * xx) + self.frame.size.width;
        CGFloat midX = (self.frame.size.width * xx) + (self.frame.size.width / 2);
        CGFloat nextMidX = (self.frame.size.width * xx)+ self.frame.size.width + (self.frame.size.width / 2);
        
        
        CGFloat scrollX = self.contentOffset.x;
        
        
        
        //---------SCROLL TO POSITION
        
        if (scrollX < midX && scrollX >= minX){
            
            //[scrollView setContentOffset:CGPointMake(minX, 0) animated:true];
            currenSlide = xx;

            CGFloat scrollTo = self.frame.size.width * (currenSlide + 1);
            [self setContentOffset:CGPointMake(scrollTo, 0) animated:true];
            
            
            
        }
        
        
        
        if (scrollX >= midX && scrollX < maxX){
            
            //[scrollView setContentOffset:CGPointMake(maxX, 0) animated:true];
            currenSlide = xx++;

            CGFloat scrollTo = self.frame.size.width * (currenSlide + 1);
            [self setContentOffset:CGPointMake(scrollTo, 0) animated:true];
            
            
        }
        
        
        
        //NSLog(@"Currend Slide %d",currenSlide);
        
        
        
        //---------SCROLL TO POSITION
        
        }
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    [self calculateScroll];

   
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //ensure that the end of scroll is fired.
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.15];

}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    int page = self.contentOffset.x / self.frame.size.width;

    NSLog(@"CURRENT PAGE %d",page);
    
    scrollCurrentPage = page;

    
    
    NSNumber * pageNumber = [NSNumber numberWithInt:page];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateCell" object:pageNumber];

}


-(void)moveScrollToPrevious{
    int numberOfSlides = self.contentSize.width / self.frame.size.width;
    int currenSlide = 0;
    
    for (int xx = 1 ; xx < numberOfSlides ; xx++) {
        
        CGFloat minX = self.frame.size.width * xx;
        CGFloat maxX = (self.frame.size.width * xx) + self.frame.size.width;
        CGFloat midX = (self.frame.size.width * xx) + (self.frame.size.width / 2);
        CGFloat nextMidX = (self.frame.size.width * xx)+ self.frame.size.width + (self.frame.size.width / 2);
        
        
        CGFloat scrollX = self.contentOffset.x;
        
        
        
        //---------SCROLL TO POSITION
        
        if (scrollX < midX && scrollX >= minX){
            
            //[scrollView setContentOffset:CGPointMake(minX, 0) animated:true];
            currenSlide = xx;
            
            CGFloat scrollTo = self.frame.size.width * (currenSlide - 1);
            [self setContentOffset:CGPointMake(scrollTo, 0) animated:true];
            
            
            
        }
        
        
        
        if (scrollX >= midX && scrollX < maxX){
            
            //[scrollView setContentOffset:CGPointMake(maxX, 0) animated:true];
            currenSlide = xx++;
            
            CGFloat scrollTo = self.frame.size.width * (currenSlide - 1);
            [self setContentOffset:CGPointMake(scrollTo, 0) animated:true];
            
            
        }
        
        
        
        //NSLog(@"Currend Slide %d",currenSlide);
        
        
        
        //---------SCROLL TO POSITION
        
    }
    
    
}



-(void)calculateScroll{
    
    //NSLog(@"CALLING CALCULATE SCROLL");
    
    int numberOfSlides = self.contentSize.width / self.frame.size.width;
    
    for (int xx = 0 ; xx < numberOfSlides - 1; xx++) {
        
        CGFloat minX = self.frame.size.width * xx;
        CGFloat maxX = (self.frame.size.width * xx) + self.frame.size.width;
        CGFloat midX = (self.frame.size.width * xx) + (self.frame.size.width / 2);
        CGFloat nextMidX = (self.frame.size.width * xx)+ self.frame.size.width + (self.frame.size.width / 2);
        
        
        CGFloat scrollX = self.contentOffset.x;
        
        
        
        //---------SCROLL TO POSITION
        
        if (scrollX <= midX && scrollX >= minX){
            
            
            //NSLog(@"UPDATE WHEN SCROLL 1");
            
            [_controller updateTabWhenScroll:xx];
            
            return;
            
            
        }
        
        
        
        if (scrollX > midX && scrollX <= maxX){
            
           // NSLog(@"UPDATE WHEN SCROLL 2");
            
            [_controller updateTabWhenScroll:xx + 1];
            
            return;
        }
        
        
        
        
        
        
        
        //---------SCROLL TO POSITION
        
    }
    
    
    if (self.contentOffset.x <= 0){
        
         [_controller updateTabWhenScroll:0];
        
    }
    
    if (self.contentOffset.x >= (self.contentSize.width - self.frame.size.width)){
        
        [_controller updateTabWhenScroll:numberOfSlides - 1];
        
    }

    

}
//-------------------------------------------------




@end
