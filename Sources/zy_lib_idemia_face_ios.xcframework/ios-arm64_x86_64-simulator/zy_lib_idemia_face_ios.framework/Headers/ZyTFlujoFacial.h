//
//  ZyTFlujoFacial.h
//  ZyTBiometrico
//
//  Created by Edwin on 06/24/2020.
//  Copyright © 2020 Edwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZyIdemFacialRequest.h"
#import "ZyIdemFacialResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZyTFlujoFacial : NSObject

- (instancetype) shared;

- (instancetype) initWithUI: (UIViewController *) viewController;

- (instancetype) initWithOutUI;

- (void) capturarSelfie: (ZyIdemFacialRequest *) request
         withCompletion:(void(^)(ZyIdemFacialResponse *response)) completionBlock;

@end

NS_ASSUME_NONNULL_END
