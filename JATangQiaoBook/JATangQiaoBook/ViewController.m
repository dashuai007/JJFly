//
//  ViewController.m
//  JATangQiaoBook
//
//  Created by xiazhongchong on 17/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *neededName = @"DFWaWaSC-W5";
    BOOL isLoaded = [self queryFoneDownloaded:neededName];
    if (!isLoaded) {
        [self downloaded:neededName];
    } else {
        NSLog(@"already downloaded");
    }
}

#pragma mark - 下载字体，下载完成通知更新字体
- (void)downloaded:(NSString *)fontName {
    //用字体的postscript 名字创建一个字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];

    //创建一个字体描述对象
    CTFontDescriptorRef des = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)des];
    CFRelease(des);

    __block BOOL errorDuringDownload = NO;
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler((__bridge CFArrayRef)descs, NULL, ^bool(CTFontDescriptorMatchingState state, CFDictionaryRef  _Nonnull progressParameter) {
        double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
        if (state == kCTFontDescriptorMatchingDidFinish) {
            if (!errorDuringDownload) {
                NSLog(@"download finish");
            }
        } else if (state == kCTFontDescriptorMatchingDownloading) {
            NSLog(@"%.2f%%", progressValue);
        }
        return YES;
    });
}


- (BOOL)queryFoneDownloaded:(NSString *)fontName {
    
    UIFont *font = [UIFont fontWithName:fontName size:12.0f];
    if (font && [font.fontName compare:fontName] == NSOrderedSame) {
        return YES;
    }
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
