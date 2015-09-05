//
//  ViewTools.h
//  Prime
//
//  Created by Coody on 2015/8/21.
//  Copyright (c) 2015年 Coody. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef enum{
    EnumImageType_None = -1,
    EnumImageType_Png,
    EnumImageType_Jpg,
    EnumImageType_Gif
}EnumImageType;

#pragma mark - 容器 View
@interface ContainerView : UIView

/** 
 * @brief   - 設定容器的高度
 * @details - 
 */
-(void)setContainerViewHight:(CGFloat)tempHight;

/** 
 * @brief   - 設定元件內的左邊間距
 * @details - （可以不設定，則為預設值）
 */
-(void)setLeftMargin:(CGFloat)tempLeftMargin;

/**
 * @brief   - 設定元件內的右邊間距
 * @details -（可以不設定，則為預設值；如果有設定左間距，右間距沒設定，會以左間距為主；如果左右都設定，則各自有各自的值）
 */
-(void)setRightMargin:(CGFloat)tempRightMargin;

/**
 * @brief   - 設定元件內的彼此之間的距離
 * @details -（可以不設定，則為預設值）
 */
-(void)setMiddleMargin:(CGFloat)tempMiddleMargin;

/**
 * @brief - 加入上邊界間距
 */
-(void)setTopMargin:(CGFloat)tempTopMargin;

/**
 * @brief - 加入下邊界間距
 */
-(void)setBottomMargin:(CGFloat)tempBottomMargin;


/**
 * @brief - 加入隨意的元件
 */
-(void)addUnits:(NSArray *)tempViewArray;

@end

#pragma mark - Create UI 元件
@interface ViewTools : NSObject

// TODO: 暫時拔掉單例作法，如果畫面想要自行設定可以設定詳細資訊，避免某個畫面設定完後，變更到其他畫面！
//+(instancetype)sharedInstance;

#pragma mark ：取得目前主要元件
/////////////////////////////////////
/** 取得目前主要元件陣列 */
-(NSArray *)getRecentObjects;

#pragma mark ：設定元件
/////////////////////////////////////
/**
 * @brief   - 1. 設定元件
 * @details - 使用 ViewTolls 實體內的元件設定都會改變
 * @details -（在這之後使用 viewTolls 建立的才會使用新的值來做設定）
 */
/** 1.1.1 總設定 View 元件的標準高度 */
-(void)setViewHeight:(CGFloat)tempViewHeight;

/** 1.1.2 總設定 View 內文字的顏色 */
-(void)setAllTextColor:(UIColor *)tempColor; 

/** 1.2 設定 Button 的 Image */
-(void)setButtonImage:(UIImage *)tempButtonImage andButtonHightLightImage:(UIImage *)tempButtonHightLightImage; 

/** 1.3 設定按鈕左邊的文字顏色 */
-(void)setButtonTextColor:(UIColor *)tempColor;

/** 1.4 設定按鈕左邊的文字顏色（使用 ViewTolls 實體內的元件設定都會改變（在這之後使用 viewTolls 建立的才會使用新的值來做設定）） */
-(void)setButtonLeftTextColor:(UIColor *)tempColor;

/** 1.5 設定按鈕右邊的文字顏色（使用 ViewTolls 實體內的元件設定都會改變（在這之後使用 viewTolls 建立的才會使用新的值來做設定）） */
-(void)setButtonRightTextColor:(UIColor *)tempColor;

/** 1.6 設定箭頭的 Image */
-(void)setArrowImage:(UIImage *)arrowImage;

/** 1.7 設定 TextField 的框框 */
-(void)setTextFieldImage:(UIImage *)textFieldImage;

/** 1.8 設定 TextField 的文字顏色 */
-(void)setTextFieldTextColor:(UIColor *)textFieldTextColor;

/** 1.9 設定 TextField 內文字的顏色 */
-(void)setTextFieldInnerColor:(UIColor *)textFieldInnerColor;

/** 1.10 設定 Label 的文字顏色 */
-(void)setLabelTextColor:(UIColor *)tempColor;

/** 1.11 設定 文字Button 的顏色  */
-(void)setTextButtonColor:(UIColor *)tempColor;

/** 1.12 設定文字大小  */
-(void)setTextFont:(UIFont *)textFont;

/** 1.13 設定輸入框中，游標顏色 */
-(void)setTextFieldTintColor:(UIColor *)tempColor;

#pragma mark ：建立按鈕
/////////////////////////////////////
/** 
 * @brief - 2.1 建立特殊按鈕（左邊、右邊都有文字、還有右邊箭頭）
 */
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText 
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow;
/** 
 * @brief - 2.2 建立特殊按鈕（給設定的寬度）（左邊、右邊都有文字、還有右邊箭頭）
 */
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText 
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow 
                      withCustomWidth:(float)tempCustomWidth;

/** 
 * @brief - 2.3 建立一般按鈕（中間有置中的文字）
 */
-(UIButton *)createButtonWithText:(NSString *)tempText;

/** 
 * @brief - 2.4 建立一般按鈕（給設定的寬度）（中間有置中的文字）
 */
-(UIButton *)createButtonWithText:(NSString *)tempText
                  withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 2.5 建立紅色按鈕（中間有置中的文字）
 */
-(UIButton *)createRedButtonWithText:(NSString *)tempText;

/** 
 * @brief - 2.6 建立紅色按鈕（給設定的寬度）（中間有置中的文字）
 */
-(UIButton *)createRedButtonWithText:(NSString *)tempText 
                     withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 2.7 建立只有文字的 button （基本型：紅色字體、底下有線）
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText;

/**
 * @brief - 2.8 建立只有文字的 button （可設定顏色、底線是否需要）
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText 
                        withTextColor:(UIColor *)tempColor 
                             withLine:(BOOL)isNeedLine;

/**
 * @brief - 2.9 建立只有文字的 button （可設定顏色、底線是否需要、字體大小）
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText 
                        withTextColor:(UIColor *)tempColor 
                             withLine:(BOOL)isNeedLine 
                         withTextFont:(UIFont *)tempFont;

#pragma mark ：建立 UILabel 文字元件
/////////////////////////////////////
/**
 * @brief - 3.1.1 建立 UILabel 文字元件（寬度為文字寬度）
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment;
/**
 * @brief - 3.1.2 建立 UILabel 特殊文字元件（寬度為文字寬度）
 */
-(UILabel *)createLabelWithAttributeText:(NSAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment;

/**
 * @brief - 3.2.1 建立 UILabel 文字元件（寬度為文字寬度，設定顏色）
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment  
                  withTextColor:(UIColor *)tempTextColor;

/**
 * @brief - 3.2.2 建立 UILabel 文字元件（寬度為文字寬度，設定顏色）
 */
-(UILabel *)createLabelWithAttributeText:(NSAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor;

/**
 * @brief - 3.3.1 建立 UILabel 文字元件（寬度為樣板寬度（左邊、右邊有一點距離））
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                  withIsTemplet:(BOOL)tempIsTemplet;

/**
 * @brief - 3.3.2 建立 UILabel 文字元件（寬度為樣板寬度（左邊、右邊有一點距離））
 */
-(UILabel *)createLabelWithAttributeText:(NSAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withIsTemplet:(BOOL)tempIsTemplet;

/**
 * @brief - 3.4.1 建立 UILabel 文字元件（寬度為樣板寬度（左邊、右邊有一點距離））
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                  withTextColor:(UIColor *)tempTextColor 
                  withIsTemplet:(BOOL)tempIsTemplet;

/**
 * @brief - 3.4.2 建立 UILabel 文字元件（寬度為樣板寬度（左邊、右邊有一點距離））
 */
-(UILabel *)createLabelWithAttributeText:(NSAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor 
                           withIsTemplet:(BOOL)tempIsTemplet;

/**
 * @brief - 3.5.1 設定 UILabel 文字元件（給設定的寬度）
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 3.5.2 設定 UILabel 文字元件（給設定的寬度）
 */
-(UILabel *)createLabelWithAttributeText:(NSAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                         withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 3.6.1 設定 UILabel 文字元件（給設定的寬度）
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment  
                  withTextColor:(UIColor *)tempTextColor
                withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 3.6.2 設定 UILabel 文字元件（給設定的寬度）
 */
-(UILabel *)createLabelWithAttributeText:(NSAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor 
                         withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 
 */

#pragma mark ：建立 UITextField 文字輸入元件
/////////////////////////////////////
/**
 * @brief - 4.1 建立 UITextField 文字輸入元件
 */
-(UIView *)createTextFieldWithText:(NSString *)tempText 
                     withInnerText:(NSString *)tempInnerText 
                 withTextAlignment:(NSTextAlignment)tempTextAlignment;

/**
 * @brief - 4.2 設定 UITextField 文字輸入元件（給設定的寬度）
 */
-(UIView *)createTextFieldWithText:(NSString *)tempText 
                     withInnerText:(NSString *)tempInnerText 
                 withTextAlignment:(NSTextAlignment)tempTextAlignment 
                   withCustomWidth:(float)tempCustomWidth;

/////////////////////////////////////
/**
 * @brief - 給一串字，回傳字的 Size
 * @param - tempWidth: 給寬度（如果想問此字串寬度就直接給 CGFLOAT_MAX）
 * @param - tempText: 字串
 * @param - tempFont: 字型、與字體大小
 */
+(CGSize)getTextFrameWithWidth:(float)tempWidth withText:(NSString *)tempText withFont:(UIFont *)tempFont;

@end
