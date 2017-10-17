//
//  TouXiViewController.m
//  BaiTouJia
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TouXiViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface TouXiViewController ()
@property(nonatomic,strong)NSString *movieUrl;
@end

@implementation TouXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *CombineImage = [[UIButton alloc] initWithFrame:CGRectMake(20, 60, 100, 40)];
    [CombineImage setTitle:@"合成" forState:UIControlStateNormal];
    [CombineImage setBackgroundColor:[UIColor redColor]];
    [CombineImage addTarget:self action:@selector(testCompressionSession) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CombineImage];
    
    UIButton *play = [[UIButton alloc] initWithFrame:CGRectMake(20, 160, 100, 40)];
    [play setTitle:@"播放" forState:UIControlStateNormal];
    [play setBackgroundColor:[UIColor redColor]];
    [play addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:play];
}
- (void) testCompressionSession

{
    
    NSArray *imageArr = [NSArray arrayWithObjects:[[UIImage imageNamed:@"1.png"] CGImage],[[UIImage imageNamed:@"2.png"] CGImage],[[UIImage imageNamed:@"3.png"] CGImage],[[UIImage imageNamed:@"4.png"] CGImage],[[UIImage imageNamed:@"5.png"] CGImage],[[UIImage imageNamed:@"6.png"] CGImage],[[UIImage imageNamed:@"7.png"] CGImage], nil];
    
    
    
    CGSize size = CGSizeMake(480, 320);
    
    
    
    
    
    NSString *betaCompressionDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.mp4"];
    self.movieUrl = betaCompressionDirectory;
    
    
    NSError *error = nil;
    
    
    
    unlink([betaCompressionDirectory UTF8String]);
    
    
    
    //----initialize compression engine
    
    AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:betaCompressionDirectory]
                                  
                                                           fileType:AVFileTypeQuickTimeMovie
                                  
                                                              error:&error];
    
    NSParameterAssert(videoWriter);
    
    if(error)
        
        NSLog(@"error = %@", [error localizedDescription]);
    
    
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey,
                                   
                                   [NSNumber numberWithInt:size.width], AVVideoWidthKey,
                                   
                                   [NSNumber numberWithInt:size.height], AVVideoHeightKey, nil];
    
    AVAssetWriterInput *writerInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    
    
    
    NSDictionary *sourcePixelBufferAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                           
                                                           [NSNumber numberWithInt:kCVPixelFormatType_32ARGB], kCVPixelBufferPixelFormatTypeKey, nil];
    
    
    
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput
                                                     
                                                                                                                     sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
    
    NSParameterAssert(writerInput);
    
    NSParameterAssert([videoWriter canAddInput:writerInput]);
    
    
    
    if ([videoWriter canAddInput:writerInput])
        
        NSLog(@"I can add this input");
    
    else
        
        NSLog(@"i can't add this input");
    
    
    
    [videoWriter addInput:writerInput];
    
    
    
    [videoWriter startWriting];
    
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    
    
    //---
    
    // insert demo debugging code to write the same image repeated as a movie
    
    
    
    CGImageRef theImage = [[UIImage imageNamed:@"1.png"] CGImage];
    
    
    
    dispatch_queue_t    dispatchQueue = dispatch_queue_create("mediaInputQueue", NULL);
    
    int __block         frame = 0;
    
    
    
    [writerInput requestMediaDataWhenReadyOnQueue:dispatchQueue usingBlock:^{
        
        while ([writerInput isReadyForMoreMediaData])
            
        {
            
            if(++frame >= imageArr.count * 40)
                
            {
                
                [writerInput markAsFinished];
                
                [videoWriter finishWriting];
                
                
                
                break;
                
            }
            
            int idx = frame/40;
            
            
            
            CVPixelBufferRef buffer = (CVPixelBufferRef)[self pixelBufferFromCGImage:(__bridge CGImageRef)([imageArr objectAtIndex:idx]) size:size];
            
            if (buffer)
                
            {
                
                if(![adaptor appendPixelBuffer:buffer withPresentationTime:CMTimeMake(frame, 80)])
                    
                    NSLog(@"FAIL");
                
                else
                    
                    NSLog(@"Success:%d", frame);
                
                CFRelease(buffer);
                
            }
            
        }
        
    }];
    
    
    
    NSLog(@"outside for loop");
    
    
    
}





- (CVPixelBufferRef )pixelBufferFromCGImage:(CGImageRef)image size:(CGSize)size

{
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey, nil];
    
    CVPixelBufferRef pxbuffer = NULL;
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, size.width, size.height, kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef) options, &pxbuffer);
    
    // CVReturn status = CVPixelBufferPoolCreatePixelBuffer(NULL, adaptor.pixelBufferPool, &pxbuffer);
    
    
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    
    NSParameterAssert(pxdata != NULL);
    
    
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pxdata, size.width, size.height, 8, 4*size.width, rgbColorSpace, kCGImageAlphaPremultipliedFirst);
    
    NSParameterAssert(context);
    
    
    
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image), CGImageGetHeight(image)), image);
    
    
    
    CGColorSpaceRelease(rgbColorSpace);
    
    CGContextRelease(context);
    
    
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    
    
    return pxbuffer;
    
}

-(void)playAction
{
    
    NSLog(@"************%@",self.movieUrl);
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:self.movieUrl];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.view.layer.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:playerLayer];
    [player play];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
