//
//  ScanTableViewController.m
//  ScanUI
//
//  Created by Takeshi Shoji on 8/22/16.
//  Copyright © 2016 Novars Inc. All rights reserved.
//

#import "ScanTableViewController.h"
@import MaBeeeSDK;

@interface ScanTableViewController ()
@property (nonatomic, strong) NSArray<MaBeeeDevice *> *devices;
@end

@implementation ScanTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                           target:self
                                           action:@selector(doneButtonPressed:)];
}

- (void)doneButtonPressed:(UIBarButtonItem *)doneButton {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [MaBeeeApp.instance addObserver:self selector:@selector(receiveNotification:)];
  [MaBeeeApp.instance startScan:^(NSArray<MaBeeeDevice *> *devices) {
    self.devices = devices;
    [self.tableView reloadData];
  }];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [MaBeeeApp.instance removeObserver:self];
  [MaBeeeApp.instance stopScan];
}

- (void)receiveNotification:(NSNotification *)notification {
  [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaBeeeDeviceCell"];
  MaBeeeDevice *device = self.devices[indexPath.row];
  NSString *state = [self stateString:device];
  cell.textLabel.text = [NSString stringWithFormat:@"%@, %d, %@", device.name, device.rssi, state];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  MaBeeeDevice *device = self.devices[indexPath.row];
  switch (device.state) {
    case MaBeeeDeviceStateDisconnected:
      [MaBeeeApp.instance connect:device];
      break;
    case MaBeeeDeviceStateConnecting:
      [MaBeeeApp.instance disconnect:device];
      break;
    case MaBeeeDeviceStateConnected:
      [MaBeeeApp.instance disconnect:device];
      break;
  }
}

- (NSString *)stateString:(MaBeeeDevice *)device {
  NSString *stateString;
  switch (device.state) {
    case MaBeeeDeviceStateDisconnected:
      stateString = @"Disconnected";
      break;
    case MaBeeeDeviceStateConnecting:
      stateString = @"Connecting";
      break;
    case MaBeeeDeviceStateConnected:
      stateString = @"Connected";
      break;
  }
  return stateString;
}

@end
