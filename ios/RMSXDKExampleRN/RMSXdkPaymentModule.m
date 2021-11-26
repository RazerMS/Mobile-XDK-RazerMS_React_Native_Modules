//
//  RMSXdkPaymentModule.m
#import "RMSXdkPaymentModule.h"
#import "HomeViewController.h"
#import <React/RCTLog.h>
#import <React/RCTView.h>
#import <MOLPayXDK/MOLPayLib.h>

@interface RMSXdkPaymentModule() {
  MOLPayLib *xdkLib;
  BOOL isCloseButtonClick;
  NSDictionary *paymentResult;
  RCTResponseSenderBlock callBack;
}
@end

@implementation RMSXdkPaymentModule

// To export a module named RMSXdkPaymentModule
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(startPaymentEvent:(NSDictionary *)paymentDetails resultCallback:(RCTResponseSenderBlock)callback) {
  NSLog(@"Payment details %@", paymentDetails);
  callBack = callback;
  
  dispatch_async(dispatch_get_main_queue(), ^{
//    HomeViewController *homeViewController = [[HomeViewController alloc] init];
//    NSMutableDictionary *paymentDetailsMutable = [paymentDetails mutableCopy];
//    homeViewController.PaymentDetails = paymentDetailsMutable;
//
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
//    homeViewController.didDismiss = ^(NSDictionary *data) {
//      [[[[UIApplication sharedApplication] windows] firstObject] makeKeyAndVisible];
//      callback(@[data]);
//    };
//
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navigationController animated:YES completion:nil];
    [self start: paymentDetails];
  });
}

- (IBAction)closemolpay:(id)sender{
  [xdkLib closemolpay];
  isCloseButtonClick = YES;
}

-(void) start: (NSDictionary *)paymentDetails {
  isCloseButtonClick = NO;
  
  NSDictionary *paymentRequestDict = @{
    
    // Optional, REQUIRED when use online Sandbox environment and account credentials.
    @"mp_dev_mode": [paymentDetails objectForKey:@"mp_dev_mode"],
    
    // Mandatory String. Values obtained from MOLPay.
    @"mp_username": [paymentDetails objectForKey:@"mp_username"],
    @"mp_password": [paymentDetails objectForKey:@"mp_password"],
    @"mp_merchant_ID": [paymentDetails objectForKey:@"mp_merchant_ID"],
    @"mp_app_name": [paymentDetails objectForKey:@"mp_app_name"],
    @"mp_verification_key": [paymentDetails objectForKey:@"mp_verification_key"],
    
    // Mandatory String. Payment values.
    @"mp_amount": [paymentDetails objectForKey:@"mp_amount"], // Minimum 1.01
    @"mp_order_ID": [paymentDetails objectForKey:@"mp_order_ID"],
    @"mp_currency": [paymentDetails objectForKey:@"mp_currency"],
    @"mp_country": [paymentDetails objectForKey:@"mp_country"],
    
    // Optional, but required payment values. User input will be required when values not passed.
    @"mp_channel": [paymentDetails objectForKey:@"mp_channel"],
    @"mp_bill_description": [paymentDetails objectForKey:@"mp_bill_description"],
    @"mp_bill_name": [paymentDetails objectForKey:@"mp_bill_name"],
    @"mp_bill_email": [paymentDetails objectForKey:@"mp_bill_email"],
    @"mp_bill_mobile": [paymentDetails objectForKey:@"mp_bill_mobile"],
  };
  
  NSLog(@"%@", paymentRequestDict);
  
  xdkLib = [[MOLPayLib alloc] initWithDelegate:self andPaymentDetails:paymentRequestDict];
  xdkLib.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closemolpay:)];
  xdkLib.navigationItem.hidesBackButton = YES;
  
  if (@available(iOS 15.0, *)) {
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    [appearance configureWithOpaqueBackground];
    appearance.titleTextAttributes = @{NSForegroundColorAttributeName : UIColor.whiteColor};
    appearance.backgroundColor = [UIColor whiteColor];
    [UINavigationBar appearance].standardAppearance = appearance;
    [UINavigationBar appearance].scrollEdgeAppearance = appearance;
  }
  
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:xdkLib];
  [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navigationController animated:YES completion:nil];
}

-(void)transactionResult:(NSDictionary *)result {
  NSLog(@"Result %@", result);
  if (isCloseButtonClick == NO && [[result objectForKey:@"pInstruction"] integerValue] == 1){
    
  } else {
    callBack(@[result]);
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
  }
}

@end

