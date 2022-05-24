//
//  ZyTUtil.h
//  ZyTBiometrico
//
//  Created by Edwin on 05/27/2020.
//  Copyright © 2020 Edwin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZyTUtil : NSObject

+(NSString*) getParamMainBundle:(NSString *) param;
+(NSString*) getParamMainBundle:(NSString *) param withDefaultValue:(NSString *) valor;
+(NSData *) getDataResourceLocal:(NSString *) name;
+(NSString *) getPathResourceLocal:(NSString *) name;
+(BOOL)stringIsNilOrEmpty:(NSString*)aString;
+(NSString *)Base64Encode:(NSData *)data;
+(NSString *)getVersionPlataform;
+(NSString *)getDeviceName;
+(NSString *)getDeviceModel;
+(NSString *)getModelDeviceName;
+(NSString *)getIdentifierForVendor;
@end

NS_ASSUME_NONNULL_END
