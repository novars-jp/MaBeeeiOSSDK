#import "MaBeeeDevice.h"
@import CoreBluetooth;

// Notifications
extern NSString *MaBeeeCentralManagerDidUpdateNotification;
extern NSString *MaBeeeDeviceDidConnectNotification;
extern NSString *MaBeeeDeviceDidDisconnectNotification;
extern NSString *MaBeeeDeviceDisconnectModeDidUpdateNotification;
extern NSString *MaBeeeDeviceRssiDidUpdateNotification;
extern NSString *MaBeeeDeviceBatteryVoltageDidUpdateNotification;

// Callback
typedef void (^MaBeeeScanHandler)(NSArray<MaBeeeDevice *> *devices);

@interface MaBeeeApp : NSObject

// Singleton instance
+ (MaBeeeApp *)instance;

// Finalize App
- (void)finalizeApp;

// Observer
- (void)addObserver:(id)observer selector:(SEL)selector;
- (void)removeObserver:(id)observer;

// Properties
#if TARGET_OS_IPHONE
- (CBManagerState)centralManagerState;
#else
- (CBCentralManagerState)centralManagerState;
#endif

// Devices
- (NSArray<MaBeeeDevice *> *)devices;
- (MaBeeeDevice *)deviceWithIdentifier:(NSUInteger)identifier;

// Scan, Connect
- (void)startScan:(MaBeeeScanHandler)scanHandler;
- (void)stopScan;
- (BOOL)isScanning;
- (void)connect:(MaBeeeDevice *)device;
- (void)disconnect:(MaBeeeDevice *)device;

@end
