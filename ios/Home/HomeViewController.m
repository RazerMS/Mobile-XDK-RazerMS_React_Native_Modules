//
//  HomeViewController.m
//  xdk_testing_objective_c
//
//  Created by Abd Qayyum on 27/08/2020.
//  Copyright © 2020 Abd Qayyum. All rights reserved.
//

#import "HomeViewController.h"
#import <MOLPayXDK/MOLPayLib.h>

@interface HomeViewController () {
  MOLPayLib *xdkLib;
  BOOL isCloseButtonClick;
  NSDictionary *paymentResult;
}

@end

@implementation HomeViewController

- (IBAction)closemolpay:(id)sender{
  [xdkLib closemolpay];
  isCloseButtonClick = YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  isCloseButtonClick = NO;
  
  NSDictionary *paymentRequestDict = @{
    
    // Optional, REQUIRED when use online Sandbox environment and account credentials.
    @"mp_dev_mode": [_PaymentDetails objectForKey:@"mp_dev_mode"],
    
    // Mandatory String. Values obtained from MOLPay.
    @"mp_username": [_PaymentDetails objectForKey:@"mp_username"],
    @"mp_password": [_PaymentDetails objectForKey:@"mp_password"],
    @"mp_merchant_ID": [_PaymentDetails objectForKey:@"mp_merchant_ID"],
    @"mp_app_name": [_PaymentDetails objectForKey:@"mp_app_name"],
    @"mp_verification_key": [_PaymentDetails objectForKey:@"mp_verification_key"],
    
    // Mandatory String. Payment values.
    @"mp_amount": [_PaymentDetails objectForKey:@"mp_amount"], // Minimum 1.01
    @"mp_order_ID": [_PaymentDetails objectForKey:@"mp_order_ID"],
    @"mp_currency": [_PaymentDetails objectForKey:@"mp_currency"],
    @"mp_country": [_PaymentDetails objectForKey:@"mp_country"],
    
    // Optional, but required payment values. User input will be required when values not passed.
    @"mp_channel": [_PaymentDetails objectForKey:@"mp_channel"],
    @"mp_bill_description": [_PaymentDetails objectForKey:@"mp_bill_description"],
    @"mp_bill_name": [_PaymentDetails objectForKey:@"mp_bill_name"],
    @"mp_bill_email": [_PaymentDetails objectForKey:@"mp_bill_email"],
    @"mp_bill_mobile": [_PaymentDetails objectForKey:@"mp_bill_mobile"],
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
  [self presentViewController:navigationController animated:NO completion:nil];
}

-(void)transactionResult:(NSDictionary *)result {
  NSLog(@"%@", result);
  NSLog(@"%ld", [[result objectForKey:@"pInstruction"] integerValue]);
  paymentResult = result;
  if (isCloseButtonClick == NO && [[result objectForKey:@"pInstruction"] integerValue] == 1){
    
  } else {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.didDismiss){
      self.didDismiss(paymentResult);
    }
  }
}

-(void)alert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert" message:@"This is an alert." preferredStyle:UIAlertControllerStyleAlert];
  
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
  
    }];
  
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
