//
//  ZyTFlujoFacial.m
//  ZyTBiometrico
//
//  Created by Edwin on 06/24/2020.
//  Copyright © 2020 Edwin. All rights reserved.
//

#import "ZyTFlujoFacial.h"
#import "ZyTUtil.h"
#import "ZyTActivation.h"
//#import "ZyTJoinPointsView.h"
#import "ZyTEnrollView.h"
//#import "ZyTPassiveLivenessView.h"
#import "ZyTBiomatchOptions.h"


@interface ZyTFlujoFacial()



typedef void(^CompletionFlujoResponse)(ZyIdemFacialResponse *response);
@property (weak, nonatomic) UIViewController *clientViewController;
@property (nonatomic) ZyIdemFacialResponse *response;
@property (nonatomic) ZyIdemFacialRequest *request;
@property (nonatomic) ZyTBiomatchOptions *options;
@property (nonatomic) CompletionFlujoResponse completionFlujoResponse;


@end


@implementation ZyTFlujoFacial

+ (instancetype) shared {
    static ZyTFlujoFacial * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype) initWithUI: (UIViewController *) viewController
{
    if (self = [super init]) {
        self.clientViewController = viewController;
    }
    return self;
}

- (instancetype) initWithOutUI
{
    if (self = [super init]) {
        UIViewController *rootViewController = [[UIViewController alloc] init];
        self.clientViewController = rootViewController;
        
    }
    return self;
}

- (void) capturarSelfie: (ZyIdemFacialRequest *) request
         withCompletion:(CompletionFlujoResponse) completionBlock
{
    
    self.completionFlujoResponse = completionBlock;
    self.response = ZyIdemFacialResponse.new;
    self.request = request;
    
    if (TARGET_IPHONE_SIMULATOR != 0) {
        // target is current running in the simulator
        // NO CORRE EN SIMULADOR
        NSLog(@"==========>>>> NO CORRE EN SIMULADOR");
        
        self.response.coError = @"22007";
        self.response.deError = @"22007:LIBRERIA ZYTRUST ES SOLO PARA DISPOSITIVOS FISICOS REALES";
        self.completionFlujoResponse(self.response);
        return;
    }
    
    
    self.options =  ZyTBiomatchOptions.new;
    
    self.options.timeout = request.zyTimeOut;
    self.options.tipoReto = request.zyTipoReto;
    self.options.nivelSeguridad = request.zyNivelSeguridad;
    self.options.numeroPuntos = request.zyNumeroPuntos;
    
    // VERIFICAMOS LICENCIA DE IDEMIA
    [self checkLicense];
    
}

#pragma mark -- METODOS DE FLUJO DE CAPTURA FACIAL
-(void) checkLicense
{
    NSLog(@"==========>>>> checkLicense");
    
    // 1. VALIDACION DE LICENCIA SMARTBIO
    [ZyTActivation.sharedInstance checkLicensev3:^(NSString * _Nonnull detalle,
                                                   NSError * _Nonnull error) {
        
        
        
        if(!error){
            if([self.request.zyTipoReto isEqualToString:@"NO_LIVENESS"]){
                [self startCustomCaptureView];
            }
            else if([self.request.zyTipoReto isEqualToString:@"CR2D"]){
                [self startJoinThePointView];
            }
            else if([self.request.zyTipoReto isEqualToString:@"PASSIVE"]){
                [self startCustomCaptureView];
            }
            else if([self.request.zyTipoReto isEqualToString:@"SLAM"]){
                [self startCustomCaptureView];
            }else{
                NSLog(@"==========>>>> INICIALIZACION POR DEFECTO");
                self.options.nivelSeguridad = @"LOW";
                self.options.tipoReto = @"PASSIVE";
                self.options.timeout = @"30";
                [self startCustomCaptureView];
            }
        }
        else{
            // HUBO UN ERROR CON LA LICENCIA DE IDEMIA
            NSLog(@"==========>>>> ERROR EN LICENCIA DE IDEMIA");
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            self.response.coError = @"9103";
            self.response.deError = @"9103:Error en licencia";
            self.response.descripcionError = [NSString stringWithFormat:@"%@", error];
            self.completionFlujoResponse(self.response);
        }
    }];
}

- (void)startJoinThePointView{
    
    /*ZyTJoinPointsView *vc =
    [[ZyTJoinPointsView alloc] initWithUI:self.clientViewController];
    
    [vc startCaptureWithOptions:self.options
                  andCompletion:^(NSString *coError,NSString *deError,NSError *nsError,
                                  UIImage *image) {
        
        [self result:coError withDetailError:deError withError:nsError withImage:image];
        
    }];*/
}

- (void)startCustomCaptureView {
    
    ZyTEnrollView *vc =
    [[ZyTEnrollView alloc] initWithUI:self.clientViewController];
    
    [vc startCaptureWithOptions:self.options
                  andCompletion:^(NSString *coError,NSString *deError,NSError *nsError,
                                  UIImage *image) {
        
        [self result:coError withDetailError:deError withError:nsError withImage:image];
        
        
    }];
}

- (void)startPassiveLivenessView {
    
    /*ZyTPassiveLivenessView *vc = [[ZyTPassiveLivenessView alloc] initWithUI:self.clientViewController];
    
    [vc startCaptureWithOptions:self.options
                  andCompletion:^(NSString *coError,NSString *deError,NSError *nsError, UIImage *image) {
        
        [self result:coError withDetailError:deError withError:nsError withImage:image];
        
    }];*/
}

- (void) result: (NSString *)coError
withDetailError:(NSString *)deError
      withError:(NSError *) nsError
      withImage:(UIImage *)image {
    if(image){
        // Result OK Captura de Rostro
        self.response.coError = @"8000";
        self.response.deError = @"Todas las operaciones de realizaron correctamente";
        NSData *faceImage = UIImageJPEGRepresentation(image, 0.5);
        NSNumber *width =
        [NSNumber numberWithFloat:[UIImage imageWithData:faceImage].size.width];
        NSNumber *height =
        [NSNumber numberWithFloat:[UIImage imageWithData:faceImage].size.height];
        self.response.bioFaceHeigh = height;
        self.response.bioFaceWidth = width;
        
        NSString *base64Encoded = [ZyTUtil Base64Encode:faceImage];
        
        self.response.bioFaceImg = [base64Encoded stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        self.completionFlujoResponse(self.response);
        
    }
    else{
        // HUBO UN ERROR CON LA CAPTURA
        self.response.coError = coError;
        self.response.deError = deError;
        self.response.descripcionError = [NSString stringWithFormat:@"%@", nsError];
        self.completionFlujoResponse(self.response);
        
    }
    
}


@end

