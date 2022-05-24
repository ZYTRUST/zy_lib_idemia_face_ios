//
//  ZyTBasicLivenessView.h
//  ZyTBiometrico
//
//  Created by Edwin on 06/15/2020.
//  Copyright © 2020 Edwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZyTBiomatchOptions.h"


@interface ZyTBasicLivenessView : UIViewController

- (instancetype) initWithUI: (UIViewController *) viewController;

- (void) startCaptureWithOptions: (ZyTBiomatchOptions *) options
        andCompletion: (void(^)(NSString *coError,NSString *deError,NSError *nsError,
        UIImage *image)) completionBlock;
@end
