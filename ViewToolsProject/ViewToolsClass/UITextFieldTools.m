//
//  UITextFieldTools.m
//  Prime
//
//  Created by Coody on 2015/9/12.
//  Copyright (c) 2015年 Coody. All rights reserved.
//

#import "UITextFieldTools.h"

#import <UIKit/UIKit.h>

@implementation UITextFieldTools

-(id)init{
    self = [super init];
    if ( self ) {
        // 最大長度截斷
        _substringLength = NSUIntegerMax;
        
        // 確認最小長度
        _minStringLength = NSUIntegerMax;
        _isMinStringLegal = NO;
        
        // 確認正規表達式字串
        _predicateString = @"";
        _isPredicateLegal = NO;
    }
    return self;
}

/**
 * @brief   - 會確認目前 UITextField 的字串的長度，並且截斷成所限制的長度設定回去
 * @warning - 請先設定 _substringLength 你要限制的長度
 */
-(void)checkStringLengthWithSender:(id)sender{
    if ( [sender isMemberOfClass:[UITextField class]] ) {
        if ( _substringLength == NSUIntegerMax ) {
            return;
        }
        UITextField *textField = (UITextField *)sender;
        if ( [textField.text length] > _substringLength ) {
            textField.text = [textField.text substringToIndex:_substringLength];
        }
        
        if ( [_delegate respondsToSelector:@selector(endCheckWithSender:)] ) {
            [_delegate endCheckWithSender:sender];
        }
    }
}

/**
 * @brief   - 會確認目前 UITextField 的字串的最小長度，將結果存入 property: isMinStringLegal
 * @warning - 請先設定 _minStringLength 你要確認的最小長度
 */
-(void)checkStringMinWithSender:(id)sender{
    if ( [sender isMemberOfClass:[UITextField class]] ) {
        if ( _minStringLength == NSUIntegerMax ) {
            return;
        }
        UITextField *textField = (UITextField *)sender;
        if ( [textField.text length] >= _minStringLength ) {
            _isMinStringLegal = YES;
        }
        else{
            _isMinStringLegal = NO;
        }
        
        if ( [_delegate respondsToSelector:@selector(endCheckWithSender:)] ) {
            [_delegate endCheckWithSender:sender];
        }
    }
}

/**
 * @brief - 會依照正規表達式來確認 UITextField 的字串是否符合規則
 * @warning - 請先設定 _predicateString 正規表達式的規則（例：要英文數字以及電話號碼就 @[a-zA-Z0-9] 即可）
 */
-(void)checkWordWithSender:(id)sender{
    if ( [sender isMemberOfClass:[UITextField class]] ) {
        UITextField *textField = (UITextField *)sender;
        if ( _predicateString == nil || 
            [_predicateString isEqualToString:@""]||
            textField.delegate != nil ) {
            return;
        }
        
        NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , _predicateString];
        _isPredicateLegal = [phonePredicate evaluateWithObject:textField.text];
        
        if ( [_delegate respondsToSelector:@selector(endCheckWithSender:)] ) {
            [_delegate endCheckWithSender:sender];
        }
    }
}

/**
 * @brief - 會確認所有曾在 UITextFieldTools 中，設定過的設定值
 *
 */
-(void)checkAllSettingsInTools:(id)sender{
    [self checkStringMinWithSender:sender]; // 最小字串
    [self checkStringLengthWithSender:sender];  // 最大長度截斷
    [self checkWordWithSender:sender];  // 是否符合正規表達式
    
    if ( [_delegate respondsToSelector:@selector(endCheckWithSender:)] ) {
        [_delegate endCheckWithSender:sender];
    }
}

#pragma mark - 類別方法
/** 
 * @brief - 是否有四個以上字元？
 */
+(BOOL)checkFourDifferentKindOfWords:(NSString *)tempCheckString{
    BOOL isLegal = NO;
    if ( [tempCheckString length] > 0 ) {
        int differentWordCount = 0;
        NSString *newCheckString = [tempCheckString lowercaseString];
        while ( [newCheckString length] > 0 ) {
            NSString *word = [newCheckString substringToIndex:1];
            newCheckString = [newCheckString stringByReplacingOccurrencesOfString:word withString:@""];
            differentWordCount = differentWordCount + 1;
            // 只要檢查到有四個字元不相等（ differentWordCount >= 4 ），就直接跳出不用再尋找。
            if ( differentWordCount >= 4 ) {
                isLegal = YES;
                break;
            }
        }
    }
    return isLegal;
}

#pragma mark - UITextField's Delegate
-(BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    if( textField.text != nil && ![textField.text isEqualToString:@""] ){
        // 有字串才判斷
        NSString *checkString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSPredicate *tempPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , _predicateString];
        _isPredicateLegal = [tempPredicate evaluateWithObject:checkString];
        return _isPredicateLegal;
    }
    else{
        return YES;
    }
}

@end
