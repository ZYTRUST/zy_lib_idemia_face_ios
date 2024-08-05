//
//  ZyTImagenRequest.h
//  ZyTBiometrico
//
//  Created by Edwin on 05/20/2020.
//  Copyright © 2020 Edwin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZyIdemFacialRequest : NSObject

@property (nonatomic) NSString *zyTipoReto;
@property (nonatomic) NSString *zyTimeOut;
@property (nonatomic) NSString *zyNivelSeguridad;
@property (nonatomic) NSNumber *zyNumeroPuntos;

@end

NS_ASSUME_NONNULL_END
