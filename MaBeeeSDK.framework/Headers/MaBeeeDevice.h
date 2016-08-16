#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MaBeeeDeviceState) {
  MaBeeeDeviceStateDisconnected,
  MaBeeeDeviceStateConnecting,
  MaBeeeDeviceStateConnected
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
- (void)updateRssi;
- (void)updateBatteryVoltage;
@end
