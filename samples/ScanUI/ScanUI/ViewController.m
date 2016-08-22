//
//  ViewController.m
//  ScanUI
//
//  Created by Takeshi Shoji on 8/22/16.
//  Copyright © 2016 Novars Inc. All rights reserved.
//

#import "ViewController.h"
@import MaBeeeSDK;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
  for (MaBeeeDevice *device in MaBeeeApp.instance.devices) {
    device.pwmDuty = (int)(sender.value * 100);
  }
}

@end
