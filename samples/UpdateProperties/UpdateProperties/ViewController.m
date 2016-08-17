//
//  ViewController.m
//  UpdateProperties
//
//  Created by Takeshi Shoji on 2016/08/17.
//  Copyright © 2016年 Novars Inc. All rights reserved.
//

#import "ViewController.h"
@import MaBeeeSDK;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

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

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [MaBeeeApp.instance addObserver:self selector:@selector(receiveNotification:)];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MaBeeeApp.instance removeObserver:self];
}

- (IBAction)scanButtonPressed:(UIButton *)sender {
  MaBeeeScanViewController *vc = MaBeeeScanViewController.new;
  [vc show:self];
}

- (IBAction)updateButtonPressed:(UIButton *)sender {
  for (MaBeeeDevice *device in MaBeeeApp.instance.devices) {
    [device updateRssi];
    [device updateBatteryVoltage];
  }
}

- (void)receiveNotification:(NSNotification *)notification {

  if ([MaBeeeDeviceRssiDidUpdateNotification isEqualToString:notification.name]) {
    NSUInteger identifier = [notification.userInfo[@"MaBeeeDeviceIdentifier"] unsignedIntegerValue];
    MaBeeeDevice *device = [MaBeeeApp.instance deviceWithIdentifier:identifier];
    NSString *line = [NSString stringWithFormat:@"%@ RSSI: %d", device.name, device.rssi];
    [self appendLine:line];
    return;
  }

  if ([MaBeeeDeviceBatteryVoltageDidUpdateNotification isEqualToString:notification.name]) {
    NSUInteger identifier = [notification.userInfo[@"MaBeeeDeviceIdentifier"] unsignedIntegerValue];
    MaBeeeDevice *device = [MaBeeeApp.instance deviceWithIdentifier:identifier];
    NSString *line = [NSString stringWithFormat:@"%@ Volgate: %f", device.name, device.batteryVoltage];
    [self appendLine:line];
    return;
  }
}

- (void)appendLine:(NSString *)line {
  self.textView.text = [self.textView.text stringByAppendingFormat:@"%@\n", line];
}

@end
