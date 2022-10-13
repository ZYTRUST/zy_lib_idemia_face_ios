//
//  ZyTActivation.m
//  HelloWorld
//
//  Created by iOS_ZyTrust on 23/11/18.
//

#import "ZyTActivation.h"
#if !TARGET_IPHONE_SIMULATOR
#import <BiometricSDK/BiometricSDK.h>
#endif

@interface ZyTActivation ()

#if !TARGET_IPHONE_SIMULATOR
@property (strong, nonatomic) BIOLicenseManager *licenseManager;
#endif
-(NSString *) obtainFeature;

@end

@implementation ZyTActivation

-(instancetype)init {
    if(self = [super init]){
//        NSLog(@"init new BIOLicenseManager..");
    }
    return self;
}

+(ZyTActivation *) sharedInstance {
    static ZyTActivation * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedInstance = [[ZyTActivation alloc] init];
    });
    return _sharedInstance;
}
#if !TARGET_IPHONE_SIMULATOR
-(void)checkLicensev3:(void(^)(NSString *detalle, NSError *error)) completionBlock
{


    dispatch_async(dispatch_get_main_queue(), ^{
    
        
        self.licenseManager = [BIOLicenseManager new];
        BIOLicense *license = self.licenseManager.license;
        if(license && license.isValid){
            
            NSString *licencia = [self obtainFeature];
            //[self.licenseManager.license.features componentsJoinedByString:@" / "];
            completionBlock(licencia,nil);
        }
        else{
            
//            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
//            NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:filePath];
            
            NSDictionary *plistData = [[NSBundle bundleForClass:[self class]] infoDictionary];
            
            NSString *profileId = [plistData objectForKey:@"LKMSv3ProfileId"];
//            NSLog(@"profileId = %@", profileId);
            
            NSString *apiKey = [plistData objectForKey:@"LKMSv3ApiKey"];
            NSString *serverUrl = [plistData objectForKey:@"LKMSv3ServerURL"];
            /**NSLog(@"serverUrl = %@", serverUrl);*/
            if (profileId == nil){
                profileId = @"yambalzytrust_portal_01_10_2020_13_46-3c8f515d-12b7-461f-837b-5607193b4322";
            }
            if (apiKey == nil){
                apiKey = @"4F9kp11LdXEo5FP7u11UKj+K4vHleoSR1UOeppG2kL8=";
            }
            if (serverUrl == nil){
                serverUrl = @"https://prd.lkms.xantav.com/api";
            }
            
            BIOLicenseOptions *licenseOption = [BIOLicenseOptions new];
            licenseOption.serverURL = serverUrl;
            licenseOption.profileId = profileId;
            licenseOption.apiKey = apiKey;
            
            [self.licenseManager activateWithOptions:licenseOption withCompletionHandler:^(BIOLicense* license, NSError *error) {
                
                if (!error){
                    completionBlock([self obtainFeature],nil);
                    
                }
                else{
//                    NSLog(@"ERROR: %@", error);
                    completionBlock(nil,error);
                }
            }];
            
        }
    });
    
    
}

-(NSString *)obtainFeature {
    //NSLog(@"ZyT:obtenemos detalle de la licencia..");
    return [self.licenseManager.license.features componentsJoinedByString:@" / "];
}
#endif
@end
