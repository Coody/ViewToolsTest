//
//  ViewTools.m
//  Prime
//
//  Created by Coody on 2015/8/21.
//  Copyright (c) 2015年 Coody. All rights reserved.
//

#import "ViewTools.h"

// 設定元件標準高度（可自行設定）
#define D_ViewTools_ViewHeight (41.0f)
// 設定元件與左邊畫面的距離
#define D_ViewTools_Label_Left_Margin (15)
// 設定文字大小
#define D_ViewTools_Text_Font [UIFont boldSystemFontOfSize:16.0f]
// 設定文字顏色
#define D_ViewTools_Text_Color [UIColor whiteColor]
// 設定 TextField 內文字的顏色
#define D_ViewTools_TextField_Inner_Color [UIColor grayColor]
// 設定 Image 的名稱（不帶 .png ）
#define D_ViewTools_Arrow_Image (nil)
#define D_ViewTools_Button_Red_Normal_Image (nil)
#define D_ViewTools_Button_Red_HightLight_Image (nil)
#define D_ViewTools_Button_Normal_Image (nil)
#define D_ViewTools_Button_HightLight_Image (nil)
#define D_ViewTools_TextField_Image (nil)
#define D_ViewTools_TextField_Image (nil)

#pragma mark - 裝元件的容器（左->右來安裝）
@interface ContainerView()
@property (nonatomic) CGFloat containerViewHight;
@property (nonatomic) CGFloat leftMargin;
@property (nonatomic) CGFloat rightMargin;
@property (nonatomic) CGFloat middleMargin;
@end

@implementation ContainerView

-(id)init{
    self = [super init];
    if ( self ) {
        _leftMargin = 0.0f;
        _rightMargin = 0.0f;
        _middleMargin = 0.0f;
        _containerViewHight = D_ViewTools_ViewHeight;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,_containerViewHight);
    }
    return self;
}

/** 
 * @brief   - 設定容器的高度
 * @details - 
 */
-(void)setContainerViewHight:(CGFloat)tempHight
{
    _containerViewHight = tempHight;
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,_containerViewHight);
}

/** 
 * @brief   - 設定元件內的左邊間距
 * @details - （可以不設定，則為預設值）
 */
-(void)setLeftMargin:(CGFloat)tempLeftMargin{
    _leftMargin = tempLeftMargin;
    if ( _rightMargin == 0.0f ) {
        _rightMargin = _leftMargin;
    }
}

/**
 * @brief   - 設定元件內的右邊間距
 * @details -（可以不設定，則為預設值；如果有設定左間距，右間距沒設定，會以左間距為主；如果左右都設定，則各自有各自的值）
 */
-(void)setRightMargin:(CGFloat)tempRightMargin;{
    _rightMargin = tempRightMargin;
}

/**
 * @brief   - 設定元件內的彼此之間的距離
 * @details -（可以不設定，則為預設值）
 */
-(void)setMiddleMargin:(CGFloat)tempMiddleMargin{
    _middleMargin = tempMiddleMargin;
}

-(void)addUnits:(NSArray *)tempViewArray{
    
    // 取得元件內最高的 Height 值，並且設置圍  Container View 的主要 Height
    CGFloat realHeight = _containerViewHight;
    
    // 計算內部左右元件 x 的位置 
    CGFloat totalX = 0.0f;
    if ( [tempViewArray count] == 0 ) {
        NSLog(@" \n**** WARNING!!!! 沒有加入任何元件!!!! ****");
        return;
    }
    else if ( [tempViewArray count] == 1 ) {
        UIView *unit = [tempViewArray firstObject];
        unit.frame = CGRectMake(_leftMargin ,
                                unit.frame.origin.y,
                                [UIScreen mainScreen].bounds.size.width - _rightMargin - _leftMargin,
                                unit.frame.size.height);
        if ( unit.frame.size.height > realHeight ) {
            realHeight = unit.frame.size.height;
        }
        [self addSubview:unit];
    }
    else{
        for ( UIView *unit in tempViewArray ) {
            if ( unit == [tempViewArray firstObject] ) {
                unit.frame = CGRectMake(_leftMargin , unit.frame.origin.y, unit.frame.size.width, unit.frame.size.height);
                totalX = totalX + _leftMargin + unit.frame.size.width;
            }
            else if( unit == [tempViewArray lastObject] ){
                unit.frame = CGRectMake( totalX + _middleMargin , unit.frame.origin.y, 
                                        [UIScreen mainScreen].bounds.size.width - totalX - _middleMargin - _rightMargin ,
                                        unit.frame.size.height);
            }
            else{
                unit.frame = CGRectMake( totalX + _middleMargin , unit.frame.origin.y, unit.frame.size.width, unit.frame.size.height);
                totalX = totalX + _middleMargin + unit.frame.size.width;
            }
            if ( unit.frame.size.height > realHeight ) {
                realHeight = unit.frame.size.height;
            }
            [self addSubview:unit];
        }
    }
    
    [self setContainerViewHight:realHeight];
    
}

@end

#pragma mark - Create UI 元件
@interface ViewTools()
// 一般設定
@property (nonatomic) CGFloat viewHeight;
@property (nonatomic , strong) UIFont *textFont;
@property (nonatomic , strong) UIColor *allTextDefaultColor;
@property (nonatomic , strong) UIColor *btnTextColor;
@property (nonatomic , strong) UIColor *btnLeftTextColor;
@property (nonatomic , strong) UIColor *btnRightTextColor;
@property (nonatomic , strong) UIColor *labelTextColor;
@property (nonatomic , strong) UIColor *textFieldTextColor;
@property (nonatomic , strong) UIColor *textFieldInnerColor;
@property (nonatomic , strong) UIColor *textButtonColor;
// 按鈕
@property (nonatomic , strong) UIImage *buttonImage_Normal;
@property (nonatomic , strong) UIImage *buttonImage_HightLight;
@property (nonatomic , strong) UIImage *buttonImage_Red_Normal;
@property (nonatomic , strong) UIImage *buttonImage_Red_HightLight;
@property (nonatomic , strong) UIImage *arrowImage;
// TextField
@property (nonatomic , strong) UIImage *textFieldImage;

@property (nonatomic , strong) NSArray *recentObjects;

@end

@implementation ViewTools

//+(instancetype)sharedInstance{
//    static ViewTools *viewToolsSharedInstance = nil;
//    static dispatch_once_t pred;
//    dispatch_once( &pred , ^{
//        if ( viewToolsSharedInstance == nil ) {
//            viewToolsSharedInstance = [[self alloc] init];
//        } 
//    });
//    return viewToolsSharedInstance;
//}

-(id)init{
    self = [super init];
    if (self) {
        // 目前建立好的 View 是哪種？
        _recentObjects = nil;
        
        // 初始化設定
        _viewHeight = D_ViewTools_ViewHeight;
        _textFont = D_ViewTools_Text_Font;
        _allTextDefaultColor = D_ViewTools_Text_Color;
        
        // Label Text Color
        _labelTextColor = _allTextDefaultColor;
        
        // button Text Color
        _btnTextColor = _allTextDefaultColor;
        _btnLeftTextColor = _btnRightTextColor = _allTextDefaultColor;
        _textButtonColor = _allTextDefaultColor;
        
        // TextField Text Color
        _textFieldTextColor = _allTextDefaultColor;
        _textFieldInnerColor = _allTextDefaultColor;
        
        // 按鈕
        _buttonImage_Normal = [ViewTools getImageFromeBundleByPath:D_ViewTools_Button_Normal_Image];
        _buttonImage_HightLight = [ViewTools getImageFromeBundleByPath:D_ViewTools_Button_HightLight_Image];
        _buttonImage_Red_Normal = [ViewTools getImageFromeBundleByPath:D_ViewTools_Button_Red_Normal_Image];
        _buttonImage_Red_HightLight = [ViewTools getImageFromeBundleByPath:D_ViewTools_Button_Red_HightLight_Image];
        _arrowImage = [ViewTools getImageFromeBundleByPath:D_ViewTools_Arrow_Image];
        
        _textFieldImage = [ViewTools getImageFromeBundleByPath:D_ViewTools_TextField_Image];
    }
    return self;
}

#pragma mark ：取得目前主要元件
/////////////////////////////////////
/** 取得目前主要元件 */
-(NSArray *)getRecentObjects{
    return _recentObjects;
}

#pragma mark - 設定 View
-(void)setViewHeight:(CGFloat)tempViewHeight{
    _viewHeight = tempViewHeight;
}

// private
-(void)setAllTextColor:(UIColor *)tempColor{
    _allTextDefaultColor = tempColor;
    
    // Label Text Color
    _labelTextColor = _allTextDefaultColor;
    
    // button Text Color
    _btnTextColor = _allTextDefaultColor;
    _btnLeftTextColor = _btnRightTextColor = _allTextDefaultColor;
    
    // TextField Text Color
    _textFieldTextColor = _allTextDefaultColor;
    _textFieldInnerColor = _allTextDefaultColor;
}

-(void)setButtonImage:(UIImage *)tempButtonImage andButtonHightLightImage:(UIImage *)tempButtonHightLightImage
{
    _buttonImage_Normal = tempButtonImage;
    _buttonImage_HightLight = tempButtonHightLightImage;
}

-(void)setButtonTextColor:(UIColor *)tempColor{
    _btnTextColor = tempColor;
}

-(void)setButtonLeftTextColor:(UIColor *)tempColor{
    _btnLeftTextColor = tempColor;
}

-(void)setButtonRightTextColor:(UIColor *)tempColor{
    _btnRightTextColor = tempColor;
}

-(void)setLabelTextColor:(UIColor *)tempColor{
    _labelTextColor = tempColor;
}

-(void)setTextButtonColor:(UIColor *)tempColor{
    _textButtonColor = tempColor;
}

-(void)setArrowImage:(UIImage *)arrowImage
{
    _arrowImage = arrowImage;
}

-(void)setTextFieldImage:(UIImage *)textFieldImage{
    _textFieldImage = textFieldImage;
}

-(void)setTextFieldTextColor:(UIColor *)textFieldTextColor{
    _textFieldTextColor = textFieldTextColor;
}

-(void)setTextFieldInnerColor:(UIColor *)textFieldInnerColor{
    _textFieldInnerColor = textFieldInnerColor;
}

-(void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
}

#pragma mark - 建立按鈕（左邊、右邊都有文字、還有右邊箭頭）

// 2.1 建立特殊按鈕（左邊、右邊都有文字、還有右邊箭頭）
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText 
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow
{
    return [self createButtonWithLeftText:tempLeftText 
                            withRightText:tempRightText 
                            withNeedArrow:tempIsNeedArrow 
                          withCustomWidth:[UIScreen mainScreen].bounds.size.width];
}

// 2.2 建立特殊按鈕（給設定的寬度）（左邊、右邊都有文字、還有右邊箭頭）
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText 
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow 
                      withCustomWidth:(float)tempCustomWidth
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(6, 
                                                                  0, 
                                                                  tempCustomWidth - 12,
                                                                  _viewHeight)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(2, 5, 2, 5)];
    [button setBackgroundImage:[_buttonImage_Normal 
                                resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                resizingMode:UIImageResizingModeStretch] 
                      forState:(UIControlStateNormal)];
    [button setBackgroundImage:[_buttonImage_HightLight  
                                resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                resizingMode:UIImageResizingModeStretch] 
                      forState:(UIControlStateHighlighted)];
    [button setBackgroundImage:[_buttonImage_HightLight  
                                resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                resizingMode:UIImageResizingModeStretch] 
                      forState:(UIControlStateDisabled)];
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // 建立箭頭
    UIImageView *arrowImageView;
    if ( tempIsNeedArrow ) 
    {
        arrowImageView = [[UIImageView alloc] initWithImage:_arrowImage];
        [arrowImageView setFrame:CGRectMake(tempCustomWidth - arrowImageView.frame.size.width - D_ViewTools_Label_Left_Margin - 6,
                                            (_viewHeight - arrowImageView.frame.size.height)*0.5 ,
                                            arrowImageView.frame.size.width,
                                            arrowImageView.frame.size.height)];
        [button addSubview:arrowImageView];
        arrowImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    }
    
    // 將內部元進整理成陣列回傳（多個元件時）
    NSMutableArray *tempReturnObjects = [[NSMutableArray alloc] init];
    
    // 建立左邊文字
    if ( tempLeftText != nil )
    {
        CGSize tempSize = [ViewTools getTextFrameWithWidth:CGFLOAT_MAX withText:tempLeftText withFont:_textFont];
        UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(D_ViewTools_Label_Left_Margin + 6,
                                                                        0,
                                                                        tempSize.width,
                                                                        _viewHeight)];
        [firstLabel setText:tempLeftText];
        [firstLabel setTextAlignment:(NSTextAlignmentLeft)];
        [firstLabel setTextColor:_btnLeftTextColor];
        [firstLabel setFont:_textFont];
        [firstLabel setTag:1];
        [firstLabel setNumberOfLines:0];
        firstLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [button addSubview:firstLabel];
        
        // 將元件加入陣列（等等會暫時存入 recentObject）
        [tempReturnObjects addObject:firstLabel];
    }
    
    // 建立右邊文字
    if ( tempRightText != nil )
    {
        CGSize tempSize = [ViewTools getTextFrameWithWidth:CGFLOAT_MAX withText:tempRightText withFont:_textFont];
        UILabel *secondLabel = [[UILabel alloc] 
                                initWithFrame:CGRectMake(button.frame.size.width - arrowImageView.frame.size.width - 6 - tempSize.width - D_ViewTools_Label_Left_Margin ,
                                                         0,
                                                         tempSize.width,
                                                         _viewHeight)];
        [secondLabel setText:tempRightText];
        [secondLabel setTextAlignment:(NSTextAlignmentRight)];
        [secondLabel setTextColor:_btnRightTextColor];
        [secondLabel setFont:_textFont];
        [secondLabel setTag:2];
        [secondLabel setNumberOfLines:0];
        secondLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [button addSubview:secondLabel];
        
        // 將元件加入陣列（等等會暫時存入 recentObject）
        [tempReturnObjects addObject:secondLabel];
    }
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = tempReturnObjects;
    
    return button;
}

// 2.3 建立一般按鈕
-(UIButton *)createButtonWithText:(NSString *)tempText
{
    return [self createButtonWithText:tempText 
                      withCustomWidth:[UIScreen mainScreen].bounds.size.width];
}

// 2.4 建立一般按鈕（給設定的寬度）
-(UIButton *)createButtonWithText:(NSString *)tempText
                  withCustomWidth:(float)tempCustomWidth
{
    return [self createButtonWithText:tempText 
                      withCustomWidth:tempCustomWidth
                      withIsRedButton:NO];
}

// 2.5 建立一般紅色按鈕
-(UIButton *)createRedButtonWithText:(NSString *)tempText
{
    return [self createRedButtonWithText:tempText 
                         withCustomWidth:[UIScreen mainScreen].bounds.size.width];
}

// 2.6 建立一般紅色按鈕（給設定的寬度）
-(UIButton *)createRedButtonWithText:(NSString *)tempText 
                     withCustomWidth:(float)tempCustomWidth
{
    return [self createButtonWithText:tempText 
                      withCustomWidth:tempCustomWidth 
                      withIsRedButton:YES];
}

// 建立一般按鈕的共用方法（不開放）
-(UIButton *)createButtonWithText:(NSString *)tempText 
                  withCustomWidth:(float)tempCustomWidth 
                  withIsRedButton:(BOOL)tempIsRedButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, 
                                                                  0, 
                                                                  tempCustomWidth - 10,
                                                                  _viewHeight)];
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [button setImageEdgeInsets:UIEdgeInsetsMake(2, 5, 2, 5)];
    if ( tempIsRedButton ) {
        [button setBackgroundImage:[_buttonImage_Red_Normal 
                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                    resizingMode:UIImageResizingModeStretch] 
                          forState:(UIControlStateNormal)];
        [button setBackgroundImage:[_buttonImage_Red_HightLight  
                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                    resizingMode:UIImageResizingModeStretch] 
                          forState:(UIControlStateHighlighted)];
        [button setBackgroundImage:[_buttonImage_Red_HightLight 
                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                    resizingMode:UIImageResizingModeStretch] 
                          forState:(UIControlStateDisabled)];
    }
    else{
        [button setBackgroundImage:[_buttonImage_Normal
                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                    resizingMode:UIImageResizingModeStretch] 
                          forState:(UIControlStateNormal)];
        [button setBackgroundImage:[_buttonImage_HightLight
                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                    resizingMode:UIImageResizingModeStretch] 
                          forState:(UIControlStateHighlighted)];
        [button setBackgroundImage:[_buttonImage_HightLight
                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                                    resizingMode:UIImageResizingModeStretch] 
                          forState:(UIControlStateDisabled)];
    }
    
    NSArray *tempRecentObjects = [NSArray array];
    // 建立文字
    if ( tempText != nil )
    {
        CGSize tempSize = [ViewTools getTextFrameWithWidth:CGFLOAT_MAX withText:tempText withFont:_textFont];
        UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake((button.frame.size.width - tempSize.width - 6)*0.5,
                                                                        0,
                                                                        tempSize.width + 6 ,
                                                                        _viewHeight)];
        [firstLabel setText:tempText];
        [firstLabel setTextAlignment:(NSTextAlignmentCenter)];
        [firstLabel setTextColor:_btnTextColor];
        [firstLabel setFont:_textFont];
        [firstLabel setTag:1];
        firstLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin ;
        [button addSubview:firstLabel];
        
        tempRecentObjects = @[firstLabel];
    }
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = tempRecentObjects;
    
    return button;
}

/**
 * @brief - 2.7 建立只有文字的 button （基本型：紅色字體、底下有線）
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText
{
    return [self createTextButtonWithText:tempText 
                            withTextColor:[UIColor redColor] 
                                 withLine:YES];
}

/**
 * @brief - 2.8 建立只有文字的 button （可設定顏色、底線是否需要）
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText 
                        withTextColor:(UIColor *)tempColor 
                             withLine:(BOOL)isNeedLine
{
    return [self createTextButtonWithText:tempText 
                            withTextColor:tempColor 
                                 withLine:isNeedLine 
                             withTextFont:_textFont];
}

/**
 * @brief - 2.9 建立只有文字的 button （可設定顏色、底線是否需要、字體大小）
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText 
                        withTextColor:(UIColor *)tempColor 
                             withLine:(BOOL)isNeedLine 
                         withTextFont:(UIFont *)tempFont
{
    CGSize tempSize = [ViewTools getTextFrameWithWidth:CGFLOAT_MAX withText:tempText withFont:_textFont];
    if ( tempSize.width > [UIScreen mainScreen].bounds.size.width ) {
        tempSize = [ViewTools getTextFrameWithWidth:[UIScreen mainScreen].bounds.size.width 
                                           withText:tempText 
                                           withFont:tempFont];
    }
    if ( tempSize.height <= _viewHeight ) {
        tempSize.height = _viewHeight;
    }
    
    
    UIButton *textButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [textButton setFrame:CGRectMake(0, 0, tempSize.width, tempSize.height)];
    if ( isNeedLine ) {
        ///////
        NSDictionary *attrDict = @{NSFontAttributeName:tempFont,
                                   NSForegroundColorAttributeName:tempColor};
        NSMutableAttributedString *title =[[NSMutableAttributedString alloc] initWithString:tempText 
                                                                                 attributes:attrDict]; 
        [title addAttribute:NSUnderlineStyleAttributeName 
                      value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] 
                      range:NSMakeRange(0,[tempText length])];
        [textButton setAttributedTitle:title forState:UIControlStateNormal];
    }
    else{
        [textButton setTitle:tempText forState:UIControlStateNormal];
    }
    [[textButton titleLabel] setFont:tempFont];
    [textButton setTitleColor:tempColor forState:UIControlStateNormal];
    return textButton;
}

#pragma mark - 建立 Label
// 3.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment 
                       withTextColor:_labelTextColor];
}

// 3.2
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment  
                  withTextColor:(UIColor *)tempTextColor
{
    CGSize tempSize = [ViewTools getTextFrameWithWidth:CGFLOAT_MAX withText:tempText withFont:_textFont];
    CGFloat tempHeight = _viewHeight;
    if ( tempSize.width > [UIScreen mainScreen].bounds.size.width ) {
        tempSize = [ViewTools getTextFrameWithWidth:[UIScreen mainScreen].bounds.size.width withText:tempText withFont:_textFont];
        tempHeight = tempSize.height;
    }
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment
                     withCustomFrame:CGRectMake(0,0,tempSize.width,tempHeight) 
                       withTextColor:tempTextColor];
}

// 3.3
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                  withIsTemplet:(BOOL)tempIsTemplet
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment 
                       withTextColor:_labelTextColor
                       withIsTemplet:tempIsTemplet];
}

// 3.4
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                  withTextColor:(UIColor *)tempTextColor 
                  withIsTemplet:(BOOL)tempIsTemplet
{
    if ( tempIsTemplet == YES ) {
        CGSize tempSize = [ViewTools getTextFrameWithWidth:CGFLOAT_MAX withText:tempText withFont:_textFont];
//        CGSize tempSize = [ViewTools getTextFrameWithWidth:CGFLOAT_MAX 
//                                         withAttributeText:tempText 
//                                                  withFont:_textFont];
        CGFloat tempHeight = _viewHeight;
        if ( tempSize.width > [UIScreen mainScreen].bounds.size.width - D_ViewTools_Label_Left_Margin*2 ) {
            // 改成限制寬度來計算高度
            tempSize = [ViewTools getTextFrameWithWidth:([UIScreen mainScreen].bounds.size.width - D_ViewTools_Label_Left_Margin*2) 
                                               withText:tempText 
                                               withFont:_textFont];
            tempHeight = tempSize.height;
        }
        return [self createLabelWithText:tempText 
                       withTextAlignment:tempTextAlignment 
                         withCustomFrame:CGRectMake(D_ViewTools_Label_Left_Margin, 
                                                    0, 
                                                    [UIScreen mainScreen].bounds.size.width - D_ViewTools_Label_Left_Margin*2,
                                                    tempHeight) 
                           withTextColor:tempTextColor];
    }
    else{
        return [self createLabelWithText:tempText
                       withTextAlignment:tempTextAlignment];
    }
}

// 3.5
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment  
                       withTextColor:_labelTextColor
                     withCustomWidth:tempCustomWidth];
}

// 3.6
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment  
                  withTextColor:(UIColor *)tempTextColor
                withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment 
                     withCustomFrame:CGRectMake(0, 0, tempCustomWidth, _viewHeight)
                       withTextColor:tempTextColor];
}

// （內部方法，不開放）
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                withCustomFrame:(CGRect)tempFrame
                  withTextColor:(UIColor *)tempTextColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:tempFrame];
    [label setTextAlignment:tempTextAlignment];
    [label setText:tempText];
    [label setFont:_textFont];
    [label setTextColor:tempTextColor];
    [label setNumberOfLines:0];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = @[label];
    
    return label;
}

#pragma mark - 建立 TextField
/**
 * @brief - 4.1 設定 UITextField 文字輸入元件
 */
-(UIView *)createTextFieldWithText:(NSString *)tempText 
                          withInnerText:(NSString *)tempInnerText 
                      withTextAlignment:(NSTextAlignment)tempTextAlignment
{
    return [self createTextFieldWithText:tempText 
                           withInnerText:tempInnerText 
                       withTextAlignment:tempTextAlignment 
                         withCustomWidth:[UIScreen mainScreen].bounds.size.width];
}

/**
 * @brief - 4.2 設定 UITextField 文字輸入元件（給設定的寬度）
 */
-(UIView *)createTextFieldWithText:(NSString *)tempText 
                     withInnerText:(NSString *)tempInnerText 
                 withTextAlignment:(NSTextAlignment)tempTextAlignment 
                   withCustomWidth:(float)tempCustomWidth
{
    // 回傳的總 View 容器
    UIView *allView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tempCustomWidth, _viewHeight)];
    
    // 底圖
    UIImageView *inputView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 
                                                                           tempCustomWidth,
                                                                           _viewHeight)];
    inputView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [inputView setImage:[_textFieldImage 
                         resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
                         resizingMode:UIImageResizingModeStretch]];
    [allView addSubview:inputView];
    
    // TextField
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10,
                                                                           0,
                                                                           tempCustomWidth - 20,
                                                                           _viewHeight)];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [textField setTextAlignment:tempTextAlignment];
    [textField setFont:_textFont];
    [textField setTextColor:_textFieldTextColor];
    if ( tempText ) {
        [textField setText:tempText];
    }
    
    if ( tempInnerText ) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] 
                                           initWithString:tempInnerText
                                           attributes:@{NSForegroundColorAttributeName:_textFieldInnerColor}];
    }
    else{
        [textField setPlaceholder:@""];
    }
    [allView addSubview:textField];
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = @[textField];
    
    return allView;
}

#pragma mark - 其他工具
// 求一般 NSString 的 frame
+(CGSize)getTextFrameWithWidth:(float)tempWidth withText:(NSString *)tempText withFont:(UIFont *)tempFont{
    return ([tempText boundingRectWithSize:CGSizeMake(tempWidth, CGFLOAT_MAX) 
                                   options:NSStringDrawingUsesLineFragmentOrigin 
                                attributes:@{NSFontAttributeName:tempFont} 
                                   context:nil].size);
}

+(CGSize)getTextFrameWithWidth:(float)tempWidth withAttributeText:(NSAttributedString *)tempText withFont:(UIFont *)tempFont{
    return ([tempText boundingRectWithSize:CGSizeMake(tempWidth, CGFLOAT_MAX) 
                                   options:NSStringDrawingUsesFontLeading
                                   context:nil].size);
}

+(UIImage *)getImageFromeBundleByPath:(NSString *)tempPath{
    return [ViewTools getImageFromeFullPath:[NSString stringWithFormat: @"%@/%@", [NSBundle mainBundle].bundlePath, tempPath] 
                                   withType:EnumImageType_Png];
}

+(UIImage *)getImageFromeFullPath:(NSString *)tempFullPath withType:(EnumImageType)tempImageType{
    NSString *fullPath;
    switch (tempImageType)
    {
        case EnumImageType_None:
        {
            fullPath = [tempFullPath stringByAppendingString:@""];
        }
            break;
        case EnumImageType_Png:
        {
            fullPath = [tempFullPath stringByAppendingString:@".png"];
        }
            break;
        case EnumImageType_Gif:
        {
            fullPath = [tempFullPath stringByAppendingString:@".gif"];
        }
            break;
        case EnumImageType_Jpg:
        {
            fullPath = [tempFullPath stringByAppendingString:@".jpg"];
        }
            break;
        default:
            break;
    }
    
    
    
    UIImage *cachedImage;
    
#ifdef D_AFNetworking
    NSURL *localUrl = [NSURL URLWithString:fullPath];
    
    // 是否已存在 AFNetworking 的 cache 中
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: localUrl];
    
    [request addValue: @"image/*" forHTTPHeaderField: @"Accept"];
    
    cachedImage = [[UIImageView sharedImageCache] cachedImageForRequest: request];
#endif
    
    if (nil == cachedImage)
    {
        cachedImage = [UIImage imageWithContentsOfFile: fullPath];
        
#ifdef D_AFNetworking
        [[UIImageView sharedImageCache] cacheImage:cachedImage forRequest:request];
#endif
        if(nil == cachedImage)
        {
            NSLog(@"\n\n*****\n Class: %@ , File \"%@\" not exist!!\n*****\n\n", self, fullPath);
        }
    }
    
    return cachedImage;
}

@end
