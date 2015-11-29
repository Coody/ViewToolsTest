//
//  SeparateImageOfNumbersTool.h
//
//
//  Created by Coody on 2015/11/28.
//  Copyright © 2015年 Coody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeparateImageOfNumbersTool : NSObject

-(void)createWithString:(NSString*)sString image:(NSString*)sImage start:(NSString*)sStart;
@property (nonatomic , strong) NSMutableArray *imageNumberArray;
@end
