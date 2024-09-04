//
//  ZyTFacialOptions.h
//  ZyTBiometrico
//
//  Created by Edwin on 06/18/2020.
//  Copyright © 2020 Edwin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZyTBiomatchOptions : NSObject

+ (instancetype) shared;

@property (nonatomic) NSString *coError;
@property (nonatomic) NSString *deError;


//FACIAL PROPERTIES
@property (nonatomic) NSString *timeout;
@property (nonatomic) NSString *tipoReto;
@property (nonatomic) NSString *nivelSeguridad;
@property (nonatomic) NSNumber *numeroPuntos;


@property (nonatomic,getter=isAnimated) BOOL animated;
@property (nonatomic) NSString *title;

@end

NS_ASSUME_NONNULL_END
