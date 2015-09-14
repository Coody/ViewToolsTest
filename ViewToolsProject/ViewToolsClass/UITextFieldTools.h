//
//  UITextFieldTools.h
//  Prime
//
//  Created by Coody on 2015/9/12.
//  Copyright (c) 2015年 Coody. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief - 擴充 UITextField 的辨識字元、截斷字元功能
 */
@interface UITextFieldTools : NSObject

/** 所需要限制的長度 */
@property (nonatomic , assign) NSUInteger substringLength;

/** 所需要比對的「正規表達式(Regular Expression)」字串 */
@property (nonatomic , strong) NSString *predicateString;
/** 正規表達式確認後的結果 */
@property (nonatomic , readonly) BOOL isPredicateLegal;

/**
 * @brief   - 會確認目前 UITextField 的字串的長度，並且截斷成所限制的長度設定回去
 * @warning - 請先設定 _substringLength 你要限制的長度
 */
-(void)checkStringLengthWithSender:(id)sender;
-(void)checkWordWithSender:(id)sender;

@end
