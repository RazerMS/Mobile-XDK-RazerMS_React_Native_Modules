#ifndef RMSXdkPaymentModule_h
#define RMSXdkPaymentModule_h


#endif /* RMSXdkPaymentModule_h */
//  RMSXdkPaymentModule.h
#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
@interface RMSXdkPaymentModule : NSObject<RCTBridgeModule>
- (void)start: (NSDictionary *)paymentDetails;
@property (nonatomic, copy) void (^didDismiss)(NSDictionary *data);
@end
