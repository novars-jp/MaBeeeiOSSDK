#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MaBeeeDeviceState) {
  MaBeeeDeviceStateDisconnected,
  MaBeeeDeviceStateConnecting,
  MaBeeeDeviceStateConnected
};

typedef NS_ENUM(NSInteger, MaBeeeDeviceDisconnectMode) {
  MaBeeeDeviceDisconnectModeReset,
  MaBeeeDeviceDisconnectModeContinue
};

@interface MaBeeeDevice : NSObject
@property (readonly, nonatomic) NSUInteger identifier;
@property (readonly, nonatomic, strong) NSString *peripheralId;
@property (readonly, nonatomic, strong) NSString *name;
@property (readonly, nonatomic) int rssi;
@property (readonly, nonatomic) NSDate *rssiUpdatedAt;
@property (readonly, nonatomic) float batteryVoltage;
@property (readonly, nonatomic) NSDate *batteryVoltageUpdatedAt;
@property (readonly, nonatomic) MaBeeeDeviceState state;
@property (nonatomic) int pwmDuty;
@property (nonatomic) MaBeeeDeviceDisconnectMode disconnectMode;
- (void)updateRssi;
- (void)updateBatteryVoltage;
@end
