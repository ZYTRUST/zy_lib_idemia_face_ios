//
//  ZyTImagenResponse.h
//  ZyTBiometrico
//
//  Created by Edwin on 05/20/2020.
//  Copyright © 2020 Edwin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZyIdemFacialResponse : NSObject

@property (nonatomic) NSString *coError;
@property (nonatomic) NSString *deError;
@property (nonatomic) NSString *descripcionError;
@property (nonatomic) NSString *bioFaceImg;
@property (nonatomic) NSNumber *bioFaceHeigh;
@property (nonatomic) NSNumber *bioFaceWidth;

@end

NS_ASSUME_NONNULL_END
