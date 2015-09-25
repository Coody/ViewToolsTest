//
//  ViewTools.m
//  Prime
//
//  Created by Coody on 2015/8/21.
//  Copyright (c) 2015年 Coody.
//  This code is distributed under the terms and conditions of the MIT license.
//

#import "ViewTools.h"
#import <CoreText/CoreText.h>

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
#define D_ViewTools_Arrow_Image (@"arrow")
#define D_ViewTools_Button_Red_Normal_Image (nil)
#define D_ViewTools_Button_Red_HightLight_Image (nil)
#define D_ViewTools_Button_Normal_Image (nil)
#define D_ViewTools_Button_HightLight_Image (nil)
#define D_ViewTools_Button_Disable_Image (nil)
#define D_ViewTools_TextField_Image (nil)
#define D_ViewTools_TextField_Image (nil)
#define D_ViewTools_TextField_CancelButton_Image (nil)

#pragma mark - 裝元件的容器（左->右來安裝）
@interface ContainerView()
@property (assign , nonatomic) CGFloat containerViewHight;
@end

@implementation ContainerView

-(id)init{
    self = [super init];
    if ( self ) {
        _isLeftToRight = YES;
        _leftMargin = 0.0f;
        _rightMargin = 0.0f;
        _middleMargin = 0.0f;
        _topMargin = 0.0f;
        _bottomMargin = 0.0f;
        _containerViewHight = D_ViewTools_ViewHeight;
        _bg = [[UIImageView alloc] init];
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
    if( tempHight < 0 ){
        tempHight = 0;
    }
    _containerViewHight = tempHight;
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            [UIScreen mainScreen].bounds.size.width,
                            _containerViewHight);
}

/** 
 * @brief   - 設定容器的寬度
 * @details - 
 */
-(void)setContainerViewWidth:(CGFloat)tempWidth
{
    if( tempWidth < 0 ){
        tempWidth = 0;
    }
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            tempWidth ,
                            self.frame.size.height);
    [_bg setFrame:self.frame];
}

/**
 * @brief - 設定背景圖片
 */
-(void)setBackgroundImage:(UIImage *)tempBGImage{
    if ( tempBGImage != nil ) {
        [_bg setImage:[tempBGImage resizableImageWithCapInsets:UIEdgeInsetsMake(5,5,5,5) 
                                                  resizingMode:UIImageResizingModeStretch]];
    }
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

/**
 * @brief - 加入上邊界間距
 */
-(void)setTopMargin:(CGFloat)tempTopMargin{
    _topMargin = tempTopMargin;
}

/**
 * @brief - 加入下邊界間距（暫時想不出比較好的適配方式）
 */
-(void)setBottomMargin:(CGFloat)tempBottomMargin{
    _bottomMargin = tempBottomMargin;
}

-(void)addUnits:(NSArray *)tempViewArray{
    
    /* 反轉陣列的方法（目前沒用到，但留著做記錄，未來可能會用到） */
    if ( !_isLeftToRight ) {
        NSEnumerator *enumerator = [tempViewArray reverseObjectEnumerator];
        NSMutableArray *reverseArray = [[NSMutableArray alloc] init];
        for ( id unit in enumerator ) {
            [reverseArray addObject:unit];
        }
        tempViewArray = reverseArray;
    }
    
    
    // 優先加入背景
    [self addSubview:_bg];
    
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
                                unit.frame.origin.y + _topMargin,
                                self.frame.size.width - _rightMargin - _leftMargin,
                                unit.frame.size.height);
        if ( unit.frame.size.height + _topMargin + _bottomMargin > realHeight ) {
            realHeight = unit.frame.size.height + _topMargin + _bottomMargin;
        }
        [self addSubview:unit];
    }
    else{
        for ( UIView *unit in tempViewArray ) {
            if ( unit == [tempViewArray firstObject] ) {
                if ( _isLeftToRight ) {
                    unit.frame = CGRectMake(_leftMargin ,
                                            unit.frame.origin.y + _topMargin,
                                            unit.frame.size.width,
                                            unit.frame.size.height);
                    totalX = totalX + _leftMargin + unit.frame.size.width;
                }
                else{
                    unit.frame = CGRectMake(self.frame.size.width - _rightMargin - unit.frame.size.width,
                                            unit.frame.origin.y + _topMargin,
                                            unit.frame.size.width,
                                            unit.frame.size.height);
                    totalX = unit.frame.origin.y;
                }
            }
            else if( unit == [tempViewArray lastObject] ){
                if ( _isLeftToRight ) {
                    unit.frame = CGRectMake(totalX + _middleMargin ,
                                            unit.frame.origin.y + _topMargin,
                                            self.frame.size.width - totalX - _middleMargin - _rightMargin ,
                                            unit.frame.size.height);
                }
                else{
                    unit.frame = CGRectMake(_leftMargin ,
                                            unit.frame.origin.y + _topMargin,
                                            totalX - _leftMargin - _middleMargin ,
                                            unit.frame.size.height);
                }
            }
            else{
                if ( _isLeftToRight ) {
                    unit.frame = CGRectMake(totalX + _middleMargin ,
                                            unit.frame.origin.y + _topMargin,
                                            unit.frame.size.width,
                                            unit.frame.size.height);
                    totalX = totalX + _middleMargin + unit.frame.size.width;
                }
                else{
                    unit.frame = CGRectMake(totalX - _middleMargin - unit.frame.size.width ,
                                            unit.frame.origin.y + _topMargin,
                                            unit.frame.size.width,
                                            unit.frame.size.height);
                    totalX = totalX - _middleMargin - unit.frame.size.width;
                }
            }
            if ( unit.frame.size.height + _topMargin + _bottomMargin > realHeight ) {
                realHeight = unit.frame.size.height + _topMargin + _bottomMargin;
            }
            [self addSubview:unit];
        }
    }
    [self setContainerViewHight:realHeight];
    [_bg setFrame:self.frame];
}

-(void)setIsLeftToRight:(BOOL)isLeftToRight{
    if ( _isLeftToRight != isLeftToRight ) {
        _isLeftToRight = isLeftToRight;
        if ( [self.subviews count] > 0 ) {
            NSArray *unitArray = self.subviews;
            for ( UIView *unit in unitArray ) {
                [unit removeFromSuperview];
            }
            
            [self addUnits:unitArray];
        }
    }
}

@end

#pragma mark - Create UI 元件
@interface ViewTools()
// 一般設定
@property (nonatomic) CGFloat viewHeight;
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
@property (nonatomic , strong) UIImage *buttonImage_Disable;
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
        
        // 輸入框中，游標的顏色
        [[UITextField appearance] setTintColor:[UIColor whiteColor]];
        
        // 按鈕
        _buttonImage_Normal = [ViewTools getImageFromeBundleByPath:D_ViewTools_Button_Normal_Image];
        _buttonImage_HightLight = [ViewTools getImageFromeBundleByPath:D_ViewTools_Button_HightLight_Image];
        _buttonImage_Disable = [ViewTools getImageFromeBundleByPath:D_ViewTools_Button_Disable_Image];
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
    if ( tempViewHeight >= 0 ) {
        _viewHeight = tempViewHeight;
    }
    else{
        _viewHeight = 0;
    }
}

-(CGFloat)getViewHeight{
    return _viewHeight;
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

-(void)setButtonImage:(UIImage *)tempButtonImage 
andButtonHightLightImage:(UIImage *)tempButtonHightLightImage 
andButtonDisableImage:(UIImage *)tempDisableImage
{
    _buttonImage_Normal = tempButtonImage;
    _buttonImage_HightLight = tempButtonHightLightImage;
    _buttonImage_Disable = tempDisableImage;
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

-(void)setTextFieldTintColor:(UIColor *)tempColor{
    [[UITextField appearance] setTintColor:tempColor];
}

#pragma mark - 建立按鈕（左邊、右邊都有文字、還有右邊箭頭）

// 2.1.1 建立特殊按鈕（左邊、右邊都有文字、還有右邊箭頭）
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText 
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow
{
    return [self createButtonWithLeftText:tempLeftText 
                            withRightText:tempRightText 
                            withNeedArrow:tempIsNeedArrow 
                          withCustomWidth:[UIScreen mainScreen].bounds.size.width];
}

// 2.1.2 建立 Attribute 字串的特殊按鈕
-(UIButton *)createButtonWithLeftAttributedText:(NSMutableAttributedString *)tempLeftText 
                        withRightAttributedText:(NSMutableAttributedString *)tempRightText 
                                  withNeedArrow:(BOOL)tempIsNeedArrow
{
    return [self createButtonWithLeftAttributeText:tempLeftText 
                            withRightAttributeText:tempRightText 
                                     withNeedArrow:tempIsNeedArrow 
                                   withCustomWidth:[UIScreen mainScreen].bounds.size.width];
}

// 2.1.3 建立 Attribute 字串的特殊按鈕
-(UIButton *)createButtonWithLeftAttributedText:(NSMutableAttributedString *)tempLeftText 
                                 withLineHeight:(CGFloat)tempLeftLineHeight  
                        withRightAttributedText:(NSMutableAttributedString *)tempRightText 
                                 withLineHeight:(CGFloat)tempRightLineHeight 
                                  withNeedArrow:(BOOL)tempIsNeedArrow
{
    return [self createButtonWithLeftAttributedText:tempLeftText 
                                     withLineHeight:tempLeftLineHeight 
                            withRightAttributedText:tempRightText 
                                     withLineHeight:tempRightLineHeight 
                                      withNeedArrow:tempIsNeedArrow 
                                    withCustomWidth:[UIScreen mainScreen].bounds.size.width];
}

// 2.2.1 建立特殊按鈕（給設定的寬度）（左邊、右邊都有文字、還有右邊箭頭）
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText 
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow 
                      withCustomWidth:(float)tempCustomWidth
{
    return [self createButtonWithLeftText:tempLeftText 
                            withRightText:tempRightText 
                            withNeedArrow:tempIsNeedArrow 
                          withCustomWidth:tempCustomWidth 
                          withLabelStatic:EnumLabelStaticType_None];
}

// 2.2.2 建立Attributed 字串的特殊按鈕（給設定的寬度）（左邊、右邊都有文字、還有右邊箭頭）
-(UIButton *)createButtonWithLeftAttributeText:(NSMutableAttributedString *)tempLeftText 
                        withRightAttributeText:(NSMutableAttributedString *)tempRightText 
                                 withNeedArrow:(BOOL)tempIsNeedArrow 
                               withCustomWidth:(float)tempCustomWidth
{
    return [self createButtonWithLeftAttributedText:tempLeftText 
                                     withLineHeight:1.0f 
                            withRightAttributedText:tempRightText 
                                     withLineHeight:1.0f 
                                      withNeedArrow:tempIsNeedArrow
                                    withCustomWidth:tempCustomWidth];
}

// 2.2.3
-(UIButton *)createButtonWithLeftAttributedText:(NSMutableAttributedString *)tempLeftText 
                                 withLineHeight:(CGFloat)tempLeftLineHeight  
                        withRightAttributedText:(NSMutableAttributedString *)tempRightText 
                                 withLineHeight:(CGFloat)tempRightLineHeight 
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
    [button setBackgroundImage:[_buttonImage_Disable  
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
    
    ViewTools *privateViewTools = [[ViewTools alloc] init];
    [privateViewTools setTextFont:_textFont];
    
    // 建立左邊文字
    if ( tempLeftText != nil )
    {
        UILabel *firstLabel = [privateViewTools createLabelWithAttributeText:tempLeftText 
                                                              withLineHeight:tempLeftLineHeight
                                                           withTextAlignment:(NSTextAlignmentLeft)];
        firstLabel.frame = CGRectMake(D_ViewTools_Label_Left_Margin + 6,
                                      0,
                                      firstLabel.frame.size.width,
                                      _viewHeight);
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
        UILabel *secondLabel = [privateViewTools createLabelWithAttributeText:tempRightText 
                                                               withLineHeight:tempRightLineHeight 
                                                            withTextAlignment:(NSTextAlignmentRight)];
        secondLabel.frame = CGRectMake(button.frame.size.width - arrowImageView.frame.size.width - 6 - secondLabel.frame.size.width - D_ViewTools_Label_Left_Margin ,
                                       0,
                                       secondLabel.frame.size.width,
                                       _viewHeight);
        [secondLabel setTag:2];
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

// 2.2.4 建立特殊按鈕（給設定的寬度）（左邊、右邊都有文字、還有右邊箭頭，固定某一邊的 Label ，另一邊的寬會延長至某一邊的 Label）
-(UIButton *)createButtonWithLeftText:(NSString *)tempLeftText
                        withRightText:(NSString *)tempRightText 
                        withNeedArrow:(BOOL)tempIsNeedArrow 
                      withCustomWidth:(float)tempCustomWidth 
                      withLabelStatic:(EnumLabelStaticType)tempEnumLabelStaticType
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
    [button setBackgroundImage:[_buttonImage_Disable  
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
    
    ViewTools *privateViewTools = [[ViewTools alloc] init];
    
    // 建立左邊文字
    UILabel *firstLabel;
    if ( tempLeftText != nil )
    {
        firstLabel = [privateViewTools createLabelWithText:tempLeftText 
                                         withTextAlignment:(NSTextAlignmentLeft)];
        if ( tempEnumLabelStaticType == EnumLabelStaticType_RightStatic ) {
            CGSize tempSize = CGSizeMake(0,0);
            if ( tempRightText != nil ) {
                tempSize = [ViewTools getTextFrameWithWidth:CGFLOAT_MAX 
                                                   withText:tempRightText 
                                                   withFont:_textFont];
            }
            
            firstLabel.frame = CGRectMake(D_ViewTools_Label_Left_Margin + 6,
                                          0,
                                          button.frame.size.width - D_ViewTools_Label_Left_Margin*2 - arrowImageView.frame.size.width - tempSize.width - 6,
                                          _viewHeight);
        }
        else{
            firstLabel.frame = CGRectMake(D_ViewTools_Label_Left_Margin + 6,
                                          0,
                                          firstLabel.frame.size.width,
                                          _viewHeight);
        }
        
        [firstLabel setTag:1];
        [firstLabel setNumberOfLines:0];
        firstLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        [button addSubview:firstLabel];
        
        // 將元件加入陣列（等等會暫時存入 recentObject）
        [tempReturnObjects addObject:firstLabel];
    }
    
    // 建立右邊文字
    UILabel *secondLabel;
    if ( tempRightText != nil )
    {
        secondLabel = [privateViewTools createLabelWithText:tempRightText 
                                          withTextAlignment:(NSTextAlignmentRight)];
        if ( tempEnumLabelStaticType == EnumLabelStaticType_LeftStatic ) {
            secondLabel.frame = CGRectMake(firstLabel.frame.origin.x + firstLabel.frame.size.width,
                                           0,
                                           button.frame.size.width - D_ViewTools_Label_Left_Margin*2 - arrowImageView.frame.size.width - firstLabel.frame.size.width - 12 ,
                                           _viewHeight);
        }
        else{
            secondLabel.frame = CGRectMake(button.frame.size.width - arrowImageView.frame.size.width - 6 - secondLabel.frame.size.width - D_ViewTools_Label_Left_Margin ,
                                           0,
                                           secondLabel.frame.size.width,
                                           _viewHeight);
        }
        [secondLabel setTag:2];
        secondLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
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

// 2.4.1 建立一般按鈕（給設定的寬度）
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

// 2.7 建立一般按鈕共用方法（給定 Text , CustomWidth , 是否為 Red Button ）
-(UIButton *)createButtonWithText:(NSString *)tempText 
                  withCustomWidth:(float)tempCustomWidth 
                  withIsRedButton:(BOOL)tempIsRedButton
{
    return [self createButtonWithText:tempText 
                      withCustomFrame:CGRectMake(5, 
                                                 0, 
                                                 tempCustomWidth  - 10,
                                                 _viewHeight)
                      withIsRedButton:tempIsRedButton];
}

// 2.8 建立一般按鈕共用方法（給定 Text , CustomFrame , 是否為 Red Button ）
-(UIButton *)createButtonWithText:(NSString *)tempText 
                  withCustomFrame:(CGRect)tempCustomFrame 
                  withIsRedButton:(BOOL)tempIsRedButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:tempCustomFrame];
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
        //        [button setBackgroundImage:[_buttonImage_Disable
        //                                    resizableImageWithCapInsets:UIEdgeInsetsMake( 10, 10, 10, 10) 
        //                                    resizingMode:UIImageResizingModeStretch] 
        //                          forState:(UIControlStateDisabled)];
    }
    
    [button setTitle:tempText forState:UIControlStateNormal];
    [button setTitleColor:_btnTextColor forState:UIControlStateNormal];
    [button.titleLabel setFont:_textFont];
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = @[button];
    
    return button;
}

/**
 * @brief - 2.9 建立只有文字的 button （基本型：紅色字體、底下有線）
 */
-(UIButton *)createTextButtonWithText:(NSString *)tempText
{
    return [self createTextButtonWithText:tempText 
                            withTextColor:[UIColor redColor] 
                                 withLine:YES];
}

/**
 * @brief - 2.10 建立只有文字的 button （可設定顏色、底線是否需要）
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
 * @brief - 2.11 建立只有文字的 button （可設定顏色、底線是否需要、字體大小）
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
// 3.1.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment 
                       withTextColor:_labelTextColor];
}

// 3.1.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                                withTextColor:_labelTextColor];
}

// 3.1.3
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                          withLineHeight:(CGFloat)tempLineHeight
                       withTextAlignment:(NSTextAlignment)tempTextAlignment
{
    return [self createLabelWithAttributeText:tempText
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:tempLineHeight 
                                withTextColor:_labelTextColor];
}

// 3.2.1
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

// 3.2.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor
{
    return [self createLabelWithAttributeText:tempText
                            withTextAlignment:tempTextAlignment 
                              withCustomFrame:CGRectMake(0,0,CGFLOAT_MAX,_viewHeight) 
                                withTextColor:tempTextColor];
}

// 3.2.3
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight  
                           withTextColor:(UIColor *)tempTextColor
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:tempLineHeight 
                              withCustomFrame:CGRectMake(0,0,CGFLOAT_MAX,_viewHeight) 
                                withTextColor:tempTextColor];
}

// 3.3.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                  withIsTemplet:(BOOL)tempIsTemplet
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment 
                       withTextColor:_labelTextColor
                       withIsTemplet:tempIsTemplet];
}

// 3.3.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withIsTemplet:(BOOL)tempIsTemplet
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                                withTextColor:_labelTextColor 
                                withIsTemplet:tempIsTemplet];
}

// 3.3.3
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                           withIsTemplet:(BOOL)tempIsTemplet
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:tempLineHeight 
                                withTextColor:_labelTextColor 
                                withIsTemplet:tempIsTemplet];
}

// 3.4.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                  withTextColor:(UIColor *)tempTextColor 
                  withIsTemplet:(BOOL)tempIsTemplet
{
    if ( tempIsTemplet == YES ) {
        CGSize tempSize = [ViewTools getTextFrameWithWidth:CGFLOAT_MAX 
                                                  withText:tempText 
                                                  withFont:_textFont];
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

// 3.4.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor 
                           withIsTemplet:(BOOL)tempIsTemplet
{
    if ( tempIsTemplet == YES ) {
        return [self createLabelWithAttributeText:tempText 
                                withTextAlignment:tempTextAlignment 
                                  withCustomFrame:CGRectMake(D_ViewTools_Label_Left_Margin,
                                                             0,
                                                             [UIScreen mainScreen].bounds.size.width - D_ViewTools_Label_Left_Margin*2,
                                                             CGFLOAT_MAX) 
                                    withTextColor:tempTextColor];
    }
    else{
        return [self createLabelWithAttributeText:tempText 
                                withTextAlignment:tempTextAlignment];
    }
}

// 3.4.3
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                           withTextColor:(UIColor *)tempTextColor 
                           withIsTemplet:(BOOL)tempIsTemplet
{
    if ( tempIsTemplet == YES ) {
        return [self createLabelWithAttributeText:tempText 
                                withTextAlignment:tempTextAlignment 
                                   withLineHeight:tempLineHeight 
                            withStaticCustomFrame:CGRectMake(D_ViewTools_Label_Left_Margin,
                                                             0,
                                                             [UIScreen mainScreen].bounds.size.width - D_ViewTools_Label_Left_Margin*2,
                                                             CGFLOAT_MAX) 
                                    withTextColor:tempTextColor];
    }
    else{
        return [self createLabelWithAttributeText:tempText 
                                   withLineHeight:tempLineHeight 
                                withTextAlignment:tempTextAlignment];
    }
}

// 3.5.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment 
                withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment  
                       withTextColor:_labelTextColor
                     withCustomWidth:tempCustomWidth];
}

// 3.5.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                         withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                                withTextColor:_labelTextColor 
                              withCustomWidth:tempCustomWidth];
}

/**
 * @brief - 3.5.3 設定 UILabel 文字元件（給設定的寬度）
 */
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                         withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:tempLineHeight 
                                withTextColor:_labelTextColor 
                              withCustomWidth:tempCustomWidth];
}

// 3.6.1
-(UILabel *)createLabelWithText:(NSString *)tempText 
              withTextAlignment:(NSTextAlignment)tempTextAlignment  
                  withTextColor:(UIColor *)tempTextColor
                withCustomWidth:(float)tempCustomWidth
{
    CGSize tempSize = [ViewTools getTextFrameWithWidth:tempCustomWidth 
                                              withText:tempText 
                                              withFont:_textFont];
    return [self createLabelWithText:tempText 
                   withTextAlignment:tempTextAlignment 
                     withCustomFrame:CGRectMake(0, 0, tempSize.width, tempSize.height)
                       withTextColor:tempTextColor];
}

// 3.6.2
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                           withTextColor:(UIColor *)tempTextColor 
                         withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                              withCustomFrame:CGRectMake(0, 0, tempCustomWidth, CGFLOAT_MAX) 
                                withTextColor:tempTextColor];
}

//3.6.3 設定 UILabel 文字元件（給設定的寬度）
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight  
                           withTextColor:(UIColor *)tempTextColor 
                         withCustomWidth:(float)tempCustomWidth
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:tempLineHeight 
                              withCustomFrame:CGRectMake(0, 0, tempCustomWidth, CGFLOAT_MAX)  
                                withTextColor:tempTextColor];
}

// 3.7.1 給定設定的 Frame
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

// 3.7.2 給定設定的 Frame
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                         withCustomFrame:(CGRect)tempFrame 
                           withTextColor:(UIColor *)tempTextColor
{
    return [self createLabelWithAttributeText:tempText 
                            withTextAlignment:tempTextAlignment 
                               withLineHeight:1.0f 
                              withCustomFrame:tempFrame 
                                withTextColor:tempTextColor];
}

// 3.7.3 給定設定的 Frame
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight
                         withCustomFrame:(CGRect)tempFrame 
                           withTextColor:(UIColor *)tempTextColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:tempFrame];
    // 加入 Center
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:tempTextAlignment];
    [paragraphStyle setLineHeightMultiple:tempLineHeight];
    [tempText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tempText.string length])];
    [label setFont:_textFont];
    [label setTextColor:tempTextColor];
    label.numberOfLines = 0;
    [label setAttributedText:tempText];
    CGSize tempSize = [label sizeThatFits:CGSizeMake(tempFrame.size.width, tempFrame.size.height)];
    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, tempSize.width, tempSize.height)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // 將元件陣列暫時存入 recentObjects
    _recentObjects = nil;
    _recentObjects = @[label];
    
    return label;
}

// 3.7.4 不理會重算大小，給固定設定的 Frame（待修正，如果 frame 的寬高設定太小有可能字不夠放進來）
-(UILabel *)createLabelWithAttributeText:(NSMutableAttributedString *)tempText 
                       withTextAlignment:(NSTextAlignment)tempTextAlignment 
                          withLineHeight:(CGFloat)tempLineHeight 
                   withStaticCustomFrame:(CGRect)tempFrame 
                           withTextColor:(UIColor *)tempTextColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:tempFrame];
    // 加入 Center
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:tempTextAlignment];
    [paragraphStyle setLineHeightMultiple:tempLineHeight];
    [tempText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tempText.string length])];
    [label setFont:_textFont];
    [label setTextColor:tempTextColor];
    label.numberOfLines = 0;
    [label setAttributedText:tempText];
    CGSize tempSize = [label sizeThatFits:CGSizeMake(tempFrame.size.width, tempFrame.size.height)];
    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, tempFrame.size.width , tempSize.height)];
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
// 求一般 NSString 的 frame
+(CGSize)getTextFrameWithWidth:(float)tempWidth withText:(NSString *)tempText withFont:(UIFont *)tempFont{
    return ([tempText boundingRectWithSize:CGSizeMake(tempWidth, CGFLOAT_MAX) 
                                   options:NSStringDrawingUsesLineFragmentOrigin 
                                attributes:@{NSFontAttributeName:tempFont} 
                                   context:nil].size);
}

/** 最好不要用，這個方法算出來的 Frame 有時會出錯！ */
+(CGSize)getTextFrameWithWidth:(float)tempWidth withAttributeText:(NSAttributedString *)tempText withFont:(UIFont *)tempFont{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)tempText);
    CGSize targetSize = CGSizeMake(tempWidth, CGFLOAT_MAX);
    CGSize fitSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [tempText length]), NULL, targetSize, NULL);
    CFRelease(framesetter);
    return fitSize;
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
        cachedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
        
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
