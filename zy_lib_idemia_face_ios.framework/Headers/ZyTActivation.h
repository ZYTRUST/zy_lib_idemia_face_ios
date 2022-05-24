//
//  ZyTActivation.h
//  HelloWorld
//
//  Created by iOS_ZyTrust on 23/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZyTActivation : NSObject

+(ZyTActivation *) sharedInstance;
//-(void)checkLicense:(void(^)(NSString *detalle, NSError *error)) completionBlock;
-(void)checkLicensev3:(void(^)(NSString *detalle, NSError *error)) completionBlock;

@end

NS_ASSUME_NONNULL_END
