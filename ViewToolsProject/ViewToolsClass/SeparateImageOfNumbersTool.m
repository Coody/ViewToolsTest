//
//  SeparateImageOfNumbersTool.m
//  Prime
//
//  Created by Coody on 2015/11/28.
//  Copyright © 2015年 Coody. All rights reserved.
//

#import "SeparateImageOfNumbersTool.h"

// for depend <SGT_Core_Tools>
#import "SGT_Utilities.h"

#import "App_Default_UI_Component.h"
#import "AppConstants.h"

@interface SeparateImageOfNumbersTool()
{
    int m_asciiCodeStart;
    CGRect m_cropRect;
    
}
@property(nonatomic, strong) NSString *m_sText;
@property(nonatomic, strong) UIImage *m_imaRun;
@end

@implementation SeparateImageOfNumbersTool

- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code
        m_asciiCodeStart = 32;
        m_cropRect = CGRectMake(0, 0, 0, 0);
        self.m_imaRun = nil;
        self.m_sText = @"";
        _imageNumberArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(CGRect)getFitFrame
{
    return CGRectMake( 0,0 ,m_cropRect.size.width, m_cropRect.size.height );
}

-(void)createWithString:(NSString*)sString image:(NSString*)sImage start:(NSString*)sStart
{
    self.m_sText = sString;
    [self changeImage:sImage start:sStart];
}

-(UIImage *)getImageWithAscii:(int)iAscii newFrame:(CGRect)fitFrame{
    int iSpace =  iAscii - m_asciiCodeStart;
    CGRect rect = CGRectMake( iSpace* m_cropRect.size.width,0 ,m_cropRect.size.width, m_cropRect.size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self.m_imaRun CGImage], rect);
    
    UIImage *subIma = [UIImage imageWithCGImage:imageRef ];
    //[subIma drawInRect:fitFrame];
    
    
    UIGraphicsBeginImageContextWithOptions(fitFrame.size, NO, 0.0);
    [subIma drawInRect:fitFrame];  // scales image to rect
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    return resImage;
}

-(void)changeImage:(NSString*)sImage start:(NSString*)sStart
{    
    
    UIImage *numberImag = [App_Default_UI_Component getImageFromeBundleByPath:sImage];
    
    float fWidth = (float)numberImag.size.width/10.0;
    float fHeight = numberImag.size.height;
    
    if (SYSTEM_VERSION_LESS_THAN(@"8.1") && SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //NSInteger scale = (int)[[UIScreen mainScreen] scale];
        CGFloat   sysScale = [[UIScreen mainScreen] respondsToSelector: @selector(nativeScale)]? [[UIScreen mainScreen] nativeScale] : [[UIScreen mainScreen] scale];
        
        NSInteger scale = (int)(sysScale + 0.5);
        fWidth = fWidth*scale;
        fHeight = fHeight*scale;
        
        UIImage *image = nil;
        
        NSString *fileName;
        while (scale > 0 && !image)
        {
            fileName = [sImage stringByAppendingString:scale > 1 ? [NSString stringWithFormat:@"@%ldx", (long)scale] : @".png"];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
            image = [UIImage imageWithContentsOfFile:filePath];
            scale--;
        }
        
        self.m_imaRun = image;
    }
    else
    {
        float fscale = numberImag.scale;
        fWidth = fWidth*fscale;
        fHeight = fHeight*fscale;
        
        self.m_imaRun = [App_Default_UI_Component getPNGImgaeFromBuddleByName:sImage];
    }
    
    m_cropRect = CGRectMake(0, 0, fWidth, fHeight);
    // NSString to ASCII
    NSString *string = sStart;
    m_asciiCodeStart = [string characterAtIndex:0];
    
    [self setText:_m_sText];
}

-(void)setText:(NSString*)sString
{
    self.m_sText = sString;
    
    if ([_m_sText length] > 0)
    {    
        CGRect fitFrame = [self getFitFrame];        
        
        for (int i = 0; i < [sString length]; i++)
        {            
            int iAscii = [sString characterAtIndex:i];
            
            UIImage *numberImage = [self getImageWithAscii:iAscii newFrame:fitFrame];
            [_imageNumberArray addObject:numberImage];            
        }
    }
}

@end
