//
//  SeparateImageOfNumbersTool.h
//
//
//  Created by Coody on 2015/11/28.
//  Copyright © 2015年 Coody. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIView;

@interface SeparateImageOfNumbersTool : NSObject
@property (nonatomic , strong , readonly) NSMutableArray *imageNumberArray;
@property (nonatomic , strong , readonly) NSMutableDictionary *separateDic;
-(void)createWithString:(NSString*)sString image:(NSString*)sImage start:(NSString*)sStart;
-(UIView *)getViewByString:(NSString *)tempString;
@end
