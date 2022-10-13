//
//  ZyTEnrollView.m
//  ZyTBiometrico
//
//  Created by Edwin on 06/18/2020.
//  Copyright © 2020 Edwin. All rights reserved.
//

#import "ZyTEnrollView.h"
#if !TARGET_IPHONE_SIMULATOR
#import <BiometricSDK/BiometricSDK.h>
//#import <BiometricSDKUIExtensions/BiometricSDKUIExtensions.h>
#import <BiometricSDKUIFaceModePassiveCore/BiometricSDKUIExtensionsPassiveLiveness.h>
#endif

#if !TARGET_IPHONE_SIMULATOR
@interface ZyTEnrollView ()<FaceCaptureHandlerDelegate>


typedef void(^CompletionResponse)(NSString *coError,NSString *deError,NSError *nsError,UIImage *image);
@property (strong, nonatomic) UIViewController *clientViewController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (nonatomic) CompletionResponse completionResponse;
@property (nonatomic) ZyTBiomatchOptions *zyBiomatchOptions;
@property (strong, nonatomic) id<FaceCaptureHandler> captureHandler;

@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (weak, nonatomic) IBOutlet UIView *infoContainer;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@end
#endif


@implementation ZyTEnrollView

- (instancetype) initWithUI : (UIViewController *) viewController{
    self = [super init];
    if (self) {
        
        NSBundle *bun = [NSBundle bundleWithIdentifier:@"org.cocoapods.zy-lib-idemia-face-ios"];
        
        NSLog(@"==========>>>> cargando ZyTEnroll");
        self = [[UIStoryboard storyboardWithName:@"ZyTBiometrico" bundle:bun] instantiateViewControllerWithIdentifier:@"ZyTEnroll"];
#if !TARGET_IPHONE_SIMULATOR
        
        self.clientViewController = viewController;
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:self];
        self.navigationController.modalPresentationStyle=UIModalPresentationFullScreen;
        self.navigationController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
        [BIORemoteLogger sharedInstance].loggerDisabled = YES;
#endif
        
    }
    return self;
}


#if !TARGET_IPHONE_SIMULATOR

- (void) startCaptureWithOptions: (ZyTBiomatchOptions *) options
                   andCompletion: (CompletionResponse) completionBlock
{
    self.completionResponse = completionBlock;
    self.zyBiomatchOptions = options;
    [self.clientViewController presentViewController:self.navigationController
                                            animated:YES
                                          completion:nil];
}
#endif

//-(void)close{
//    [self dismissViewControllerAnimated:YES completion:^{}];
//}

-(void)viewDidAppear{
    
}

#if !TARGET_IPHONE_SIMULATOR
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    // STEP 12. In viewDidDisappear we should release resources
    if (self.captureHandler) {
        [self.captureHandler destroy];
        self.captureHandler.delegate = nil;
        self.captureHandler = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:false];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    bool navigationBarTranslucida = true ; // NAVIGATIONBAR TRANSLUCIDA
    if (@available(iOS 15.0, *)) {
        
        if (!navigationBarTranslucida){ //
            UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
            [appearance configureWithOpaqueBackground];
            appearance.titleTextAttributes = @{NSForegroundColorAttributeName : UIColor.whiteColor};
            appearance.backgroundColor = [UIColor blackColor];
            //[UIColor colorWithRed:58.0/255.0 green:0.0/255.0 blue:224.0/255.0 alpha:1];
            [UINavigationBar appearance].standardAppearance = appearance;
            [UINavigationBar appearance].scrollEdgeAppearance = appearance;
            
        }
        
        
        
    }else {
        if (!navigationBarTranslucida){
            //color de fondo de la barra
            self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
            //[UIColor colorWithRed:58.0/255.0 green:0.0/255.0 blue:224.0/255.0 alpha:1];
            self.navigationController.navigationBar.translucent=NO;
            
            //color del titulo
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        }else{
            self.navigationController.navigationBar.translucent=NO;
            
        }
        
    }
    
    //STATUSBAR COLOR BLANCK
    UIView *statusBar = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame] ;
    statusBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:statusBar];
    
    
    self.navigationItem.title= self.zyBiomatchOptions.title;
    
    UIImage *btnImage = [UIImage imageNamed:@"arrow_back_white_24pt" inBundle:[NSBundle bundleForClass:[self class]]  compatibleWithTraitCollection:nil];
    
    UIBarButtonItem *cancel =
    [[UIBarButtonItem alloc] initWithImage:btnImage style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    cancel.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = cancel;
    self.infoLabel.hidden = YES;
}

-(void)cancel{
    [self cancelCapture];
}
-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"=>>> orientation 1");
    //NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    NSLog(@"=>>> orientation 2");
    //[[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    //[self.navigationController setNavigationBarHidden:true];
    NSLog(@"=>>> orientation 3");
    
    [self createCaptureHandler];
}

#pragma mark -- Enroll methods

- (void) createCaptureHandler {
    
    // STEP 2. Choose mode you're willing to use and other options
    // (all options are described in the documentation)
    // SLAM: FaceCaptureLivenessModeMedium
    // PASSIVE: FaceCaptureLivenessModePassive
    FaceCaptureOptions *bioFaceCaptureOptions;
    
    if([self.zyBiomatchOptions.tipoReto isEqualToString:@"NO_LIVENESS"]){
        bioFaceCaptureOptions=[[FaceCaptureOptions alloc] initWithLivenessMode:FaceCaptureLivenessModeNoLiveness];
    }
    else if([self.zyBiomatchOptions.tipoReto isEqualToString:@"PASSIVE"]){
        
        bioFaceCaptureOptions=[[FaceCaptureOptions alloc] initWithLivenessMode:FaceCaptureLivenessModePassive];
    }
    
    if([[self.zyBiomatchOptions nivelSeguridad] isEqualToString:@"LOW"]){
        bioFaceCaptureOptions.securityLevel = FaceLivenessSecurityLevelLow;
    }
    else if([[self.zyBiomatchOptions nivelSeguridad] isEqualToString:@"MEDIUM"]){
        bioFaceCaptureOptions.securityLevel = FaceLivenessSecurityLevelMedium;
    }
    else if([[self.zyBiomatchOptions nivelSeguridad] isEqualToString:@"HIGH"]){
        bioFaceCaptureOptions.securityLevel = FaceLivenessSecurityLevelHigh;
    }else{
        bioFaceCaptureOptions.securityLevel = FaceLivenessSecurityLevelHigh;
    }
    //NSLog(@"ZyT:security : %lu",(unsigned long)bioFaceCaptureOptions.securityLevel );
    //NSLog(@"ZyT:livenessMode : %lu",(unsigned long)bioFaceCaptureOptions.livenessMode );
    
    bioFaceCaptureOptions.captureTimeout = [[self.zyBiomatchOptions timeout] integerValue];
    
    // STEP 3. Create a capture handler
    [BIOSDK createFaceCaptureHandlerWithOptions:bioFaceCaptureOptions
                          withCompletionHandler:^(id<FaceCaptureHandler>  _Nullable bioCaptureHandler,
                                                  NSError * _Nullable error) {
        
        if (error) {
            [self onZyTCaptureError:error];
            return;
        }
        
        // STEP 4. Set created capture handler
        self.captureHandler = bioCaptureHandler;
        
        // STEP 5. Set the delegate
        self.captureHandler.delegate = self;
        
        // STEP 6. Set the preview
        self.captureHandler.preview = self.previewImageView;
        
        self.textLabel.text = @"Centra tu rostro dentro del contorno";
        
        // STEP 7. Start capturing after ie. 3 sec, to give a user time for preparation
        [self startCaptureWithDelay:3 withCompletion:^(NSError * _Nullable error) {
            if ( error ) {
                [self onZyTCaptureError:error];
                return;
            }
        }];
        
    }];
}

-(void) startCaptureWithDelay:(int) delay
               withCompletion:(void(^)(NSError * _Nullable error)) completion {
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.captureHandler startCaptureWithCompletionHandler:completion];
    });
}

;

// STEP 8. During capturing you'll receive capturing info, they're hints for a user to improve or make it even possible to finish the face acquisition.
- (void)receiveBioCaptureInfo:(BIOCapturingInfo)info withError:(NSError * _Nullable)error {
    
    NSLog(@"=====>>>> Zy Selfie TExt" );
    NSLog(@"%d", info);
    
    if (error) {
        [self onZyTCaptureError:error];
        return;
    }
    
    if(info == BIOCapturingInfoFaceInfoCenterRotateDown ||
       info == BIOCapturingInfoFaceInfoCenterRotateUp ||
       info == BIOCapturingInfoFaceInfoCenterTiltLeft ||
       info == BIOCapturingInfoFaceInfoCenterTiltRight ||
       info == BIOCapturingInfoFaceInfoCenterTurnLeft ||
       info == BIOCapturingInfoFaceInfoCenterTurnRight ||
       info == BIOCapturingInfoDeviceMovementDetected ||
       info == BIOCapturingInfoFaceInfoTooFast ){
        self.textLabel.text = @"Centra tu rostro y no cierres los ojos";
        self.infoLabel.text = @"Centra tu rostro y no cierres los ojos";
    }
    else if(info == BIOCapturingInfoFaceInfoCenterMoveForwards){
        self.textLabel.text = @"Acercar el rostro (no cerrar ojos)";
        self.infoLabel.text = @"Acercar el rostro (no cerrar ojos)";
    }
    else if(info == BIOCapturingInfoFaceInfoCenterMoveBackwards){
        self.textLabel.text = @"Alejar el rostro (sin cerrar los ojos)";
        self.infoLabel.text = @"Alejar el rostro (sin cerrar los ojos)";
    }
    else if(info == BIOCapturingInfoFaceInfoDontMove){
        self.textLabel.text = @"No te muevas";
        self.infoLabel.text = @"No te muevas";
    }
    else if(info == BIOCapturingInfoFaceInfoChallenge2D){
        self.textLabel.text = @"Realice el reto de prueba de vida";
        self.infoLabel.text = @"Realice el reto de prueba de vida";
    }
    
    else if(info == BIOCapturingInfoFaceInfoStandStill){
        self.textLabel.text = @"Queda poco ya casi terminamos";
        self.infoLabel.text = @"Queda poco ya casi terminamos";
    }
    else if(info == BIOCapturingInfoFaceInfoCenterGood){
        self.infoLabel.text = @"Centrado correcto";
        self.infoLabel.text = @"Centrado correcto";
    }
    
    else if(info == BIOCapturingInfoNoFaceMovementDetected){
        self.textLabel.text = @"Enfocar el rostro";
        self.infoLabel.text = @"Enfocar el rostro";
    }
    else if(info == BIOCapturingInfoFaceInfoComeBackField){
        self.textLabel.text = @"Regresar al cuadro";
        self.infoLabel.text = @"Regresar al cuadro";
    }
    
    /*
     else if(info == BIOCapturingInfoFaceInfoMoveDarkerArea){
     self.textLabel.text = @"Demasiada iluminación";
     self.infoLabel.text = @"Demasiada iluminación";
     }
     else if(info == BIOCapturingInfoFaceInfoGetOutField){
     self.textLabel.text = @"Salir del cuadro";
     self.infoLabel.text = @"Salir del cuadro";
     }
     else if(info == BIOCapturingInfoFaceInfoTurnLeft){
     self.textLabel.text = @"Girar a la izquierda";
     self.infoLabel.text = @"Girar a la izquierda";
     }
     else if(info == BIOCapturingInfoFaceInfoTurnRight){
     self.textLabel.text = @"Girar a la derecha";
     self.infoLabel.text = @"Girar a la derecha";
     }
     else if(info == BioCapturingInfo){
     
     if(challengeInfo){
     self.infoLabel.text =
     [NSString stringWithFormat:@"Reto: %ld/%ld",
     (long)challengeInfo.currentChallengeNumber,
     (long)challengeInfo.totalChallenges];
     }
     }*/
    else{
        self.textLabel.text = @"Centra tu rostro y no cierres los ojos";
        self.infoLabel.text = @"Centra tu rostro y no cierres los ojos";
        //self.infoLabel.text =NSStringFromBIOCapturingInfo(info);
        NSLog(@"==>>> infoLabel Captura :::");
        NSLog(@"%@", NSStringFromBIOCapturingInfo(info));
    }
}

// STEP 9. When capturing is done, this callback returns detected face as BIOFaceImage
- (void)captureFinishedWithImages:(NSArray<BIOImage *> *)images
                   withBiometrics:(BIOBiometrics *)biometrics
                        withError:(NSError *)error {
    
    if (error) {
        [self onZyTCaptureError:error];
        return;
    }
    else if (images.count > 0) {
        
        UIImage *capturedImage = [UIImage imageFromBIOImage:images[0]];
        
        //        UIImageView *imageView =
        //        [[UIImageView alloc] initWithFrame:self.infoContainer.bounds];
        //        [imageView setImage:capturedImage];
        //        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        //        [self.infoContainer addSubview:imageView];
        //
        //        double delayInSeconds = 5;
        //        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        //        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //            [self onZyTCaptureSucces:capturedImage];
        //        });
        
        [self onZyTCaptureSucces:capturedImage];
    }
}

// STEP 9B.2. In case capturing is locked, wait for an unlock and start again
-(void)captureIsLockedFor:(NSInteger)seconds {
    
    [self returnError:@"9104"
      withDescription:@"9104:La captura se encuentra bloqueda por unos momentos"
          withNsError:nil];
    //[self onZyTCaptureError:@"9104" :@"9104:La captura se encuentra bloqueda por unos minutos"];
}

#pragma mark -- Return methods
-(void)cancelCapture //:(NSString *)coError :(NSString *)deError {
{
    //[self onReturnToBlock:coError withDetailError:deError withError:nil withImage:nil];
    [self returnError:@"9104"
      withDescription:@"9104:El usuario cancelo la operación"
          withNsError:nil];
}

-(void)onZyTCaptureError:(NSError *)error {
    //    NSLog(@"error code: %ld BIOCapturingErrorCaptureTimeout:",
    //          (long)error.code,BIOCapturingErrorCaptureTimeout);
    if(error.code == BIOCapturingErrorCaptureTimeout){
        //        [self mostrarError:@"9116" withDetailError:@"9116:Finalizo el tiempo de captura." withError:error];
        [self returnError:@"9116"
          withDescription:@"9116:Finalizo el tiempo de captura."
              withNsError:error];
    }
    else{
        [self returnError:@"9105"
          withDescription:@"9105:La captura no retorno data"
              withNsError:error];
        //        [self onReturnToBlock:@"9105" withDetailError:@"9105:La captura no retorno data" withError:error withImage:nil];
    }
}

-(void)onZyTCaptureSucces:(UIImage *)capturedImage{
    
    self.completionResponse(nil, nil, nil, capturedImage);
    
    // CERRAMOS LA VENTANA CON ANIMACION(NO SE ABRIRA OTRA VENTANA)
    [self dismissViewControllerAnimated:YES completion:^{}];
    //[self onReturnToBlock:nil withDetailError:nil withError:nil withImage:capturedImage];
}
- (void)returnError:(NSString *)coError
    withDescription:(NSString *)deError
        withNsError:(NSError *) nsError{
    
    if([coError isEqualToString:@"9104"]){
        NSLog(@"ZyT:CAncelar.......");
        // CERRAMOS LA VENTANA CON ANIMACION(NO SE ABRIRA LA VENTANA DE ERROR.)
        [self dismissViewControllerAnimated:YES completion:^{
            self.completionResponse(coError, deError,nsError, nil);
        }];
    }
    else{
        // CERRAMOS LA VENTANA SIN ANIMACION(SE ABRIRA LA VENTANA DE ERROR.)
        [self dismissViewControllerAnimated:NO completion:^{
            self.completionResponse(coError, deError,nsError, nil);
        }];
    }
}

//- (void)mostrarErrorEmbed:(NSString *)coError
//     withDetailError:(NSString *)deError
//           withError:(NSError *) nsError
//{
//   ZyTErrorViewController *vc = [[ZyTErrorViewController alloc]initWithUIs:self];
//
//    vc.zyFacialoptions = self.zyFacialoptions;
//    vc.zyFacialoptions.deError=deError;
//
//    vc.completionError = ^(NSString *coError) {
//        NSLog(@"ZyT:on completion en EnrollView..........");
//        //CUANDO SE CIERRA LA VENTANA DE ERROR
//        [self onReturnToBlock:coError withDetailError:deError withError:nsError withImage:nil];
//    };
//
//    [self addChildViewController:vc];
//    [self.infoContainer addSubview:vc.view];
//    vc.view.translatesAutoresizingMaskIntoConstraints=YES;
//    vc.view.frame = self.infoContainer.bounds;
//    vc.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
//                                 UIViewAutoresizingFlexibleHeight);
//    [vc didMoveToParentViewController:self];
//}
//
//- (void)mostrarError:(NSString *)coError
//     withDetailError:(NSString *)deError
//           withError:(NSError *) nsError
//{
//    NSLog(@"ZyT:abriendo error");
//    [self dismissViewControllerAnimated:NO completion:^{
//    }];
//    ZyTErrorViewController *errorView = [[ZyTErrorViewController alloc]
//                                    initWithUIs:self.clientViewController];
//     [errorView showViewWithOptions:self.zyFacialoptions
//                      andCompletion:^(NSString * _Nonnull coError) {
//
//      [self onReturnToBlock:coError withDetailError:deError withError:nsError withImage:nil];
//     }];
//
//}
#endif

@end


