//
//  ZyTUtil.m
//  ZyTBiometrico
//
//  Created by Edwin on 05/27/2020.
//  Copyright © 2020 Edwin. All rights reserved.
//

#import "ZyTUtil.h"
#import "sys/utsname.h"
@implementation ZyTUtil

+(NSString*) getParamMainBundle:(NSString *) param{
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    //A dictionary, constructed from the bundle’s Info.plist file, that contains information about the receiver.
    NSDictionary *plistData = [mainBundle infoDictionary];
    return [plistData objectForKey:param];
}

+(NSString*) getParamMainBundle:(NSString *) param withDefaultValue:(NSString *) valor{
    
    NSString *res = [self getParamMainBundle:param];
    
    if( [self stringIsNilOrEmpty:res] ){
        return valor;
    }
    return res;
}

+(NSData *) getDataResourceLocal:(NSString *) name{
    
    return [NSData dataWithContentsOfFile:[self getPathResourceLocal:name]];
}

+(NSString *) getPathResourceLocal:(NSString *) name{
    
    NSBundle *myBundle = [NSBundle bundleForClass:[self class]];
    return [myBundle pathForResource:name ofType:nil];
}

+(BOOL)stringIsNilOrEmpty:(NSString*)aString {
    if (!aString)
        return YES;
    return [[aString  stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceCharacterSet]] length] == 0;
}

+(NSString *)getModelDeviceName {
    
    struct utsname systeminfo;
    uname(&systeminfo);
    
    return [NSString stringWithCString:systeminfo.machine encoding:NSUTF8StringEncoding];
}
+(NSString *)getDeviceName {
    return  [[UIDevice currentDevice] name];
}
+(NSString *)getDeviceModel {
    return  [[UIDevice currentDevice] model];
}
+(NSString *)getVersionPlataform{
    return  [[UIDevice currentDevice] systemVersion];
}
+(NSString *)getIdentifierForVendor{
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
//+(NSDictionary*) getJpegBase64FromUIImage:(UIImage *)uiImage{
//    NSData *dataImage = UIImageJPEGRepresentation(uiImage, 0.5);
//
//    UIImage *uiResizedImage = [UIImage imageWithData:dataImage];
//
//     NSNumber *width = [NSNumber numberWithFloat:uiResizedImage.size.width];
//     NSNumber *height = [NSNumber numberWithFloat:uiResizedImage.size.height];
//         NSLog(@"width: %@, height: %@",width,height);
//
//     // initialization
//     NSDictionary *dict = @{@"base64Encoded":[self Base64Encode:dataImage],
//                            @"width": width,
//                            @"height": height
//     };
//
//    return dict;
//}

+(NSString *)Base64Encode:(NSData *)data{

    //Point to start of the data and set buffer sizes
    NSUInteger inLength = [data length];
    NSUInteger outLength = ((((inLength * 4)/3)/4)*4) + (((inLength * 4)/3)%4 ? 4 : 0);
    const char *inputBuffer = [data bytes];
    char *outputBuffer = malloc(outLength+1);
    outputBuffer[outLength] = 0;

    //64 digit code
    static char Encode[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    //Start the count
    int cycle = 0;
    int inpos = 0;
    int outpos = 0;
    char temp = '\0';

    //Pad the last to bytes, the outbuffer must always be a multiple of 4.
    outputBuffer[outLength-1] = '=';
    outputBuffer[outLength-2] = '=';

    /* http://en.wikipedia.org/wiki/Base64

        Text content     M         a         n
        ASCII            77        97        110
        8 Bit pattern    01001101  01100001  01101110

        6 Bit pattern    010011    010110    000101    101110
        Index            19        22        5         46
        Base64-encoded   T         W         F         u
    */

    while (inpos < inLength){
        switch (cycle) {

            case 0:
                outputBuffer[outpos++] = Encode[(inputBuffer[inpos] & 0xFC) >> 2];
                cycle = 1;
                break;

            case 1:
                temp = (inputBuffer[inpos++] & 0x03) << 4;
                outputBuffer[outpos] = Encode[temp];
                cycle = 2;
                break;

            case 2:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xF0) >> 4];
                temp = (inputBuffer[inpos++] & 0x0F) << 2;
                outputBuffer[outpos] = Encode[temp];
                cycle = 3;
                break;

            case 3:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xC0) >> 6];
                cycle = 4;
                break;

            case 4:
                outputBuffer[outpos++] = Encode[inputBuffer[inpos++] & 0x3f];
                cycle = 0;
                break;

            default:
                cycle = 0;
                break;
        }
    }
    NSString *pictemp = [NSString stringWithUTF8String:outputBuffer];
    free(outputBuffer);
    return pictemp;
}

@end
