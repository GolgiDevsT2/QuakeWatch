//
//  ViewController.m
//  Quake Watch
//
//  Created by Brian Kelly on 8/29/14.
//  Copyright (c) 2014 Golgi. All rights reserved.
//

#import "ViewController.h"
#import "AppData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(golgiStuff == nil){
        golgiStuff = [[GolgiStuff alloc] initWithViewController:self];
    }
    
    [thresholdSlider setValue:(float)[AppData getNfnThreshold]];
    [self updateThresholdLabel:[AppData getNfnThreshold]];
    
    [logTv setText:[AppData getQuakeLog]];

}

- (void)updateThresholdLabel:(NSInteger)threshold
{
    [thresholdLabel setText:[NSString stringWithFormat:@"Notification Magnitude Threshold: %ld.0", (long)threshold]];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    NSLog(@"slider value = %f", sender.value);
    
    NSInteger val = floor(sender.value + 0.5);
    
    [self updateThresholdLabel:val];
    
    [AppData setNfnThreshold:val];
}

- (IBAction)sliderChangeComplete:(UISlider *)sender
{
    [self sliderValueChanged:sender];
    [sender setValue:[AppData getNfnThreshold]];
    
}

@end
