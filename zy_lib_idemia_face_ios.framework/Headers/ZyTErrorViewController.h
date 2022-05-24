//
//  ZyTErrorView.h
//  ZyTBiometrico
//
//  Created by Edwin on 06/26/2020.
//  Copyright © 2020 Edwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZyTBiomatchOptions.h"


@interface ZyTErrorViewController : UIViewController

// USADO SI ERROR ES MOSTRADO EN SUBVIEW:
//typedef void(^CompletionError)(NSString *coError);
//@property (nonatomic) CompletionError completionError;
//@property (nonatomic) ZyTFacialOptions *zyFacialoptions;

- (instancetype) initWithUI: (UIViewController *) viewController;

- (void) showViewWithOptions: (ZyTBiomatchOptions *) options
andCompletion: (void(^)(NSString *coError)) completionBlock;

@end

