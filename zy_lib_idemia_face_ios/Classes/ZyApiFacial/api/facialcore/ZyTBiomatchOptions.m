//
//  ZyTFacialOptions.m
//  ZyTBiometrico
//
//  Created by Edwin on 06/18/2020.
//  Copyright © 2020 Edwin. All rights reserved.
//

#import "ZyTBiomatchOptions.h"

@implementation ZyTBiomatchOptions

+ (instancetype) shared {
    static ZyTBiomatchOptions * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
@end
