//
//  ViewController.h
//  Quake Watch
//
//  Created by Brian Kelly on 8/29/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GolgiStuff.h"

@class GolgiStuff;

@interface ViewController : UIViewController 
{
    GolgiStuff *golgiStuff;
    IBOutlet UISlider *thresholdSlider;
    IBOutlet UILabel *thresholdLabel;
    IBOutlet UITextView *logTv;
}

- (IBAction)sliderValueChanged:(UISlider *)sender;
- (IBAction)sliderChangeComplete:(UISlider *)sender;



@end
