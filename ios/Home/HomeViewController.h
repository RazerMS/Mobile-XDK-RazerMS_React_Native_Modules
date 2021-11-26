//
//  HomeViewController.h
//  xdk_testing_objective_c
//
//  Created by Abd Qayyum on 27/08/2020.
//  Copyright © 2020 Abd Qayyum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MOLPayXDK/MOLPayLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController <MOLPayLibDelegate>
@property(nonatomic) NSDictionary *PaymentDetails;
@property (nonatomic, copy) void (^didDismiss)(NSDictionary *data);
@end

NS_ASSUME_NONNULL_END
