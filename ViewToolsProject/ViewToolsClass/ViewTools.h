//
//  ViewTools.h
//  Prime
//
//  Created by Coody on 2015/8/21.
//  This code is distributed under the terms and conditions of the MIT license.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

///////////////////////////////////////////////////////////////////
// 設定元件標準高度（可自行設定）
#define D_ViewTools_ViewHeight (40.0f)
// 設定元件與左邊畫面的距離
#define D_ViewTools_Label_Left_Margin (12)
#define D_ViewTools_Label_Middle_Margin (12)
#define D_ViewTools_Label_Right_Margin (12)
// 設定文字大小
#define D_ViewTools_Text_Font [UIFont boldSystemFontOfSize:16.0f]
// 設定文字顏色
#define D_ViewTools_Text_Color [UIColor whiteColor]
// 設定 TextField 內文字的顏色
#define D_ViewTools_TextField_Inner_Color [UIColor grayColor]
// 設定產生 Button 時，左右的預留間距
#define D_ViewTools_Button_LeftRight_Margin (6)
///////////////////////////////////////////////////////////////////
// 如果不需要設定請直接使用 nil 即可
// 設定 Image 的名稱（不帶 .png ）
#define D_ViewTools_Arrow_Image (@"arrow")
#define D_ViewTools_Button_Red_Normal_Image (nil)
#define D_ViewTools_Button_Red_HightLight_Image (nil)
#define D_ViewTools_Button_Normal_Image (nil)
#define D_ViewTools_Button_HightLight_Image (nil)
#define D_ViewTools_Button_Disable_Image (nil)
#define D_ViewTools_TextField_Image (nil)
#define D_ViewTools_TextField_Image (nil)
#define D_ViewTools_TextField_CancelButton_Image (nil)


// 箭頭 image 的 tag
extern NSInteger const kArrowImage_Tag;


typedef enum{
    EnumImageType_None = -1,
    EnumImageType_Png,
    EnumImageType_Jpg,
    EnumImageType_Gif
}EnumImageType;


#pragma mark - 容器 View
@interface ContainerView : UIView

@property (readonly , nonatomic) CGFloat leftMargin;
@property (readonly , nonatomic) CGFloat rightMargin;
@property (readonly , nonatomic) CGFloat middleMargin;
@property (readonly , nonatomic) CGFloat topMargin;
@property (readonly , nonatomic) CGFloat bottomMargin;
@property (strong , nonatomic) UIImageView *bg;
@property (assign , nonatomic) BOOL isVertical;
@property (assign , nonatomic) BOOL isRevertArrangement;

/** 
 * @brief   - 設定容器的高度
 * @details - 
 */
-(void)setContainerViewHight:(CGFloat)tempHight;

/** 
 * @brief   - 設定容器的寬度
 * @details - 
 */
-(void)setContainerViewWidth:(CGFloat)tempWidth;

/**
 * @brief - 設定背景圖片
 */
-(void)setBackgroundImage:(UIImage *)tempBGImage;

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
 * @brief   - 加入隨意的元件
 * @details - 只要是 UIView 都可以加入，但是建議以 ViewTools 的建立元件為主。
 */
-(void)addUnits:(NSArray *)tempViewArray;

-(void)removeAllUnits;

/**
 * @brief - 設定要從左邊往右對齊，還是右邊往左對齊
 */
-(void)setIsRevertArrangement:(BOOL)isRevertArrangement;

/**
 * @brief - 重新確認內部位置（如果內部需要重新排列時）
 */
-(void)recheckInnerView;

@end

#pragma mark - Create UI 元件
/**
 * @brief - 設定左右兩邊有文字時，哪一邊的文字要固定寬度？
 */
typedef enum : NSInteger{
    /** 左邊固定寬度 */
    EnumLabelStaticType_LeftStatic = 0,
    /** 右邊固定寬度 */
    EnumLabelStaticType_RightStatic = 1,
    /** 不設定 */
    EnumLabelStaticType_None = 2
}EnumLabelStaticType;

@interface ViewTools : NSObject

@property (nonatomic , strong , readonly) UIFont *textFont;

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
-(CGFloat)getViewHeight;

/** 1.1.2 總設定 View 內文字的顏色 */
-(void)setAllTextColor:(UIColor *)tempColor; 

/** 1.2 設定 Button 的 Image */
-(void)setButtonImage:(UIImage *)tempButtonImage 
andButtonHightLightImage:(UIImage *)tempButtonHightLightImage 
andButtonDisableImage:(UIImage *)tempDisableImage; 

/** 1.3 設定按鈕的文字顏色 */
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
 * @brief - 2.1.1 左邊文字、右邊文字、箭頭
 */
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText 
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow;
/** 
 * @brief - 2.1.2 左邊特殊文字、右邊特殊文字、箭頭
 */
-(UIButton *)createButtonWithLeftAttributedText:(NSMutableAttributedString *)tempLeftText 
                        withRightAttributedText:(NSMutableAttributedString *)tempRightText 
                                  withNeedArrow:(BOOL)tempIsNeedArrow;

/** 
 * @brief - 2.1.3 左邊特殊文字、左邊間距、右邊特殊文字、右邊間距、箭頭
 */
-(UIButton *)createButtonWithLeftAttributedText:(NSMutableAttributedString *)tempLeftText 
                                 withLineHeight:(CGFloat)tempLeftLineHeight  
                        withRightAttributedText:(NSMutableAttributedString *)tempRightText 
                                 withLineHeight:(CGFloat)tempRightLineHeight 
                                  withNeedArrow:(BOOL)tempIsNeedArrow;

/** 
 * @brief - 2.2.1 左邊文字、右邊文字、箭頭、自定寬度
 */
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText 
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow 
                      withCustomWidth:(float)tempCustomWidth;

/** 
 * @brief - 2.2.2 左邊特殊文字、右邊特殊文字、箭頭、自定寬度
 */
-(UIButton *)createButtonWithLeftAttributeText:(NSMutableAttributedString *)tempLeftText 
                        withRightAttributeText:(NSMutableAttributedString *)tempRightText 
                                 withNeedArrow:(BOOL)tempIsNeedArrow 
                               withCustomWidth:(float)tempCustomWidth;

/** 
 * @brief - 2.2.3 左邊特殊文字、左邊間距、右邊特殊文字、右邊間距、箭頭、自定寬度
 */
-(UIButton *)createButtonWithLeftAttributedText:(NSMutableAttributedString *)tempLeftText 
                                 withLineHeight:(CGFloat)tempLeftLineHeight  
                        withRightAttributedText:(NSMutableAttributedString *)tempRightText 
                                 withLineHeight:(CGFloat)tempRightLineHeight 
                                  withNeedArrow:(BOOL)tempIsNeedArrow 
                                withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 2.2.4 左邊文字、右邊文字、箭頭、固定某一邊的文字長度（另一邊會延伸）
*/
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow 
                      withLabelStatic:(EnumLabelStaticType)tempEnumLabelStaticType;

/**
 * @brief - 2.2.5 左邊文字、右邊文字、箭頭、自定寬度、固定某一邊的文字長度（另一邊會延伸）
 */
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow 
                      withCustomWidth:(float)tempCustomWidth 
                      withLabelStatic:(EnumLabelStaticType)tempEnumLabelStaticType;

///**
// * @brief - 2.2.6 建立特殊按鈕（給設定的 frame ）（左邊、右邊都有文字、還有右邊箭頭，固定某一邊的 Label ，另一邊的寬會延長至某一邊的 Label）
// */
//-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText
//                        withRightText:(NSString *)tempRightText 
//                        withNeedArrow:(BOOL)tempIsNeedArrow 
//                      withCustomFrame:(CGRect)tempCustomFrame 
//                      withLabelStatic:(EnumLabelStaticType)tempEnumLabelStaticType;

/** 
 * @brief - 2.3.1 文字（按鈕）
 */
-(UIButton *)createButtonWithText:(NSString *)tempText;

/** 
 * @brief   - 2.3.2 文字（按鈕，左右留 5 pixel 的空間）
 * @details - 左右有留 5 pixel 的空間
 * @param   - tempText : 中間有置中的文字
 */
-(UIButton *)createButtonWithTextAndMargin:(NSString *)tempText;

/** 
 * @brief - 2.4 文字、自定寬度（按鈕）
 * @param - tempText        : 中間有置中的文字
 * @param - tempCustomWidth : 自行設定寬度
 */
-(UIButton *)createButtonWithText:(NSString *)tempText
                  withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 2.5 文字（紅色按鈕）
 */
-(UIButton *)createRedButtonWithText:(NSString *)tempText;

/** 
 * @brief - 2.6 文字、自定寬度（紅色按鈕）
 * @param - tempText        : 中間有置中的文字
 * @param - tempCustomWidth : 自行設定寬度
 */
-(UIButton *)createRedButtonWithText:(NSString *)tempText 
                     withCustomWidth:(float)tempCustomWidth;

/** 
 * @brief - 2.7 文字、自定寬度、是否為紅色按鈕
 * @param - tempText        : 中間有置中的文字
 * @param - tempCustomWidth : 自行設定寬度
 * @param - tempIsRedButton : 是否為紅色按鈕
 */
-(UIButton *)createButtonWithText:(NSString *)tempText 
                  withCustomWidth:(float)tempCustomWidth 
                  withIsRedButton:(BOOL)tempIsRedButton;

/** 
 * @brief - 2.8 文字、自定 Frame 、是否為紅色按鈕
 * @param - tempText        : 中間有置中的文字
 * @param - tempCustomWidth : 自行設定 Frame
 * @param - tempIsRedButton : 是否為紅色按鈕  
 */
-(UIButton *)createButtonWithText:(NSString *)tempText 
                  withCustomFrame:(CGRect)tempCustomFrame 
                  withIsRedButton:(BOOL)tempIsRedButton;

/**
 * @brief - 2.9 文字（文字型按鈕＋底線）
 * @param - tempText : （紅色＋底線）文字
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText;

/**
 * @brief - 2.10 文字、顏色、底線（文字型按鈕＋底線）
 * @param - tempText   : 文字
 * @param - tempColor  : （文字＋底線的）顏色
 * @param - isNeedLine : 是否需要底線？ 
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText 
                        withTextColor:(UIColor *)tempColor 
                             withLine:(BOOL)isNeedLine;
/**
 * @brief - 2.11 文字、顏色、底線、字體大小（文字型按鈕＋底線）
 * @param - tempText   : 文字
 * @param - tempColor  : （文字＋底線的）顏色
 * @param - isNeedLine : 是否需要底線？ 
 * @param - tempFont   : 文字字體
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText 
                        withTextColor:(UIColor *)tempColor 
                             withLine:(BOOL)isNeedLine 
                         withTextFont:(UIFont *)tempFont;

#pragma mark 左右有 Text 的按鈕擴充
/**
 * @brief   - 2.12 額外設定「左右有 Text 按鈕」的 >「箭頭」圖片是否顯示？
 * @details - 強制將 tempButton 的箭頭取消（會自動檢查是否有 Arrow）
 * @warning - 此為類別方法！！且只有 ViewTools 所產生的有箭頭按鈕才可以取消箭頭顯示！
 */
+(void)isNeedArrow:(BOOL)isNeedArrow 
        withButton:(UIButton *)tempButton;


#pragma mark ：建立 UILabel 文字元件
/////////////////////////////////////
/**
 * @brief - 3.1.1 文字、位置、無 AutoLayout、寬度為文字寬度
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment;

/**
 * @brief - 3.1.1-2 文字、位置、AutoLayout、寬度為文字寬度
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
           withIsNeedAutoLayout:(BOOL)isNeedAutoLayout;

/**
 * @brief - 3.1.2 特殊文字、位置
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment;

/**
 * @brief - 3.1.3 特殊文字、行高、位置
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                          withLineHeight:(CGFloat)tempLineHeight
                       withTextAlignment:(NSTextAlignment)tempTextAlignment;

/**
 * @brief - 3.2.1 文字、位置、文字顏色、無 AutoLayout、寬度為文字寬度
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment  
                  withTextColor:(UIColor *)tempTextColor;

/**
 * @brief - 3.2.1-2 文字、位置、文字顏色、AutoLayout、寬度為文字寬度
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment  
                  withTextColor:(UIColor *)tempTextColor 
           withIsNeedAutoLayout:(BOOL)isNeedAutoLayout;

/**
 * @brief - 3.2.2 特殊文字、位置、文字顏色、寬度為文字寬度
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor;

/**
 * @brief - 3.2.3 特殊文字、位置、行高、文字顏色、寬度為文字寬度
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight  
                           withTextColor:(UIColor *)tempTextColor;

/**
 * @brief - 3.3.1 文字、位置、設定樣板寬度（左右有一點間距）
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                  withIsTemplet:(BOOL)tempIsTemplet;

/**
 * @brief - 3.3.2 特殊文字、位置、設定樣板寬度（左右有一點間距）
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withIsTemplet:(BOOL)tempIsTemplet;


/**
 * @brief - 3.3.3 特殊文字、位置、行高、設定樣板寬度（左右有一點間距）
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                           withIsTemplet:(BOOL)tempIsTemplet;

/**
 * @brief - 3.4.1 文字、位置、文字顏色、設定樣板寬度（左右有一點間距）
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                  withTextColor:(UIColor *)tempTextColor 
                  withIsTemplet:(BOOL)tempIsTemplet;

/**
 * @brief - 3.4.2 特殊文字、位置、文字顏色、設定樣板寬度（左右有一點間距）
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor 
                           withIsTemplet:(BOOL)tempIsTemplet;

/**
 * @brief - 3.4.3 特殊文字、位置、行高、文字顏色、設定樣板寬度（左右有一點間距）
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                           withTextColor:(UIColor *)tempTextColor 
                           withIsTemplet:(BOOL)tempIsTemplet;

/**
 * @brief - 3.5.1 文字、位置、自定寬度
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 3.5.2 特殊文字、位置、自定寬度
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                         withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 3.5.3 特殊文字、位置、行高、自定寬度
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                         withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 3.6.1 文字、位置、文字顏色、自定寬度
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment  
                  withTextColor:(UIColor *)tempTextColor
                withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 3.6.2 特殊文字、位置、文字顏色、自定寬度
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor 
                         withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 3.6.3 特殊顏色、位置、行高、文字顏色、自定寬度
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight  
                           withTextColor:(UIColor *)tempTextColor 
                         withCustomWidth:(float)tempCustomWidth;

/**
 * @brief - 3.7.1 文字、位置、自定 Frame 、文字顏色
 */
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                withCustomFrame:(CGRect)tempFrame
                  withTextColor:(UIColor *)tempTextColor;

/**
 * @brief - 3.7.2 特殊文字、位置、自定 Frame 、文字顏色
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                         withCustomFrame:(CGRect)tempFrame 
                           withTextColor:(UIColor *)tempTextColor;

/**
 * @brief - 3.7.3 特殊文字、位置、行高、自定 Frame、文字顏色
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight
                         withCustomFrame:(CGRect)tempFrame 
                           withTextColor:(UIColor *)tempTextColor;

/**
 * @brief - 3.7.3 特殊文字、位置、行高、「固定」Frame、文字顏色（待修正，如果 frame 的寬高設定太小有可能字不夠放進來）
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                   withStaticCustomFrame:(CGRect)tempFrame 
                           withTextColor:(UIColor *)tempTextColor;

#pragma mark ：建立 UITextField 文字輸入元件
/////////////////////////////////////
/**
 * @brief - 4.1 文字、Inner文字、位置（附加 UITextField 的 UIView ）
 */
-(UIView *)createTextFieldWithText:(NSString *)tempText 
                     withInnerText:(NSString *)tempInnerText 
                 withTextAlignment:(NSTextAlignment)tempTextAlignment;

/**
 * @brief - 4.2 文字、Inner文字、位置、自定寬度（附加 UITextField 的 UIView ）
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
+(CGSize)getTextSizeWithWidth:(float)tempWidth 
                     withText:(NSString *)tempText 
                     withFont:(UIFont *)tempFont;

/**
 * @brief - 給一個 Attribute String，回傳字的 Size
 * @param - tempWidth: 給寬度（如果想問此字串寬度就直接給 CGFLOAT_MAX）
 * @param - tempText: Attribute 字串
 * @param - tempFont: 字型、與字體大小
 */
+(CGSize)getTextSizeWithWidth:(float)tempWidth 
            withAttributeText:(NSAttributedString *)tempText 
                     withFont:(UIFont *)tempFont;

/**
 * @brief - 
 */
+ (NSInteger)numberOfCharactersThatFitLabelWithText:(NSString *)tempText withFont:(UIFont *)tempFont withSize:(CGSize)tempSize;

//+ (NSString *)actuallyRenderedText:(NSString *)tempText withFrame:(CGRect)tempFrame;

/** 
 * @brief - 反轉陣列
 */
+ (NSArray *)revertArray:(NSArray *)tempOriginalArray;

@end
