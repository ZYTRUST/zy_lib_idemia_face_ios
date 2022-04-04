#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ZyTErrorViewController.h"
#import "ZyTEnrollView.h"
#import "ZyTJoinPointsView.h"
#import "ZyTPassiveLivenessView.h"
#import "ZyTBasicLivenessView.h"
#import "ZyTActivation.h"
#import "ZyTUtil.h"
#import "ZyTBiomatchOptions.h"
#import "ZyIdemFacialRequest.h"
#import "ZyIdemFacialResponse.h"
#import "ZyTFlujoFacial.h"

FOUNDATION_EXPORT double zy_lib_idemia_face_iosVersionNumber;
FOUNDATION_EXPORT const unsigned char zy_lib_idemia_face_iosVersionString[];

