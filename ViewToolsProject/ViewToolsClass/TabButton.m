//
//  TabButton.m
//  SegmentBtn
//
//  Created by coodychou on 2018/10/23.
//  Copyright © 2018 coodychou. All rights reserved.
//

#import "TabButton.h"

// for Tools
#import "ContainerView.h"

static NSTimeInterval const kTabButton_DefaultAnimationTimeMax = 1.0f;
static NSTimeInterval const kTabButton_DefaultAnimationTimeMin = 0.01f;
CGFloat const kTabButton_DefaultHeight = 44.0f;
NSTimeInterval const kTabButton_DefaultAnimationTime = 0.2f;
static CGFloat const kTabButton_DefaultSelectedBarHeight = 4.0f;

@interface TabButton()
@property (nonatomic , strong) ContainerView *mainContainer;
@property (nonatomic , strong) NSArray <UIButton *>*buttonArray;
@property (nonatomic , strong) UIView *selectedBarBackgroundView;
@property (nonatomic , strong) UIView *selectedBarView;
@property (nonatomic , assign) NSUInteger buttonIndex;
@end

@implementation TabButton
-(instancetype)initWithButtons:(nonnull NSArray<UIButton *> *)buttonArray{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kTabButton_DefaultHeight)];
    if( self ){
        _buttonArray = buttonArray;
        [self initialTabButtonDefaultValue];
        
        _mainContainer = [[ContainerView alloc] init];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, kTabButton_DefaultHeight)];
        [_mainContainer setContainerViewHight:kTabButton_DefaultHeight];
        [_mainContainer setContainerViewWidth:[UIScreen mainScreen].bounds.size.width];
        [_mainContainer setIsSeparateAllUnit:YES];
        
        // 如果按鈕初始化失敗則不回傳物件
        if( ![self initialButtons] ){
            return nil;
        }
        
        [self initialSelectBar];
        
        [self setButtonIndexWithoutAnimation:0];
    }
    return self;
}

-(void)initialTabButtonDefaultValue{
    _buttonHeight = kTabButton_DefaultHeight;
    _selectedBarBackgroundColor = D_TabButton_SelectedBarBackgroundColor;
    _selectedBarColor = D_TabButton_SelectedBarColor;
    _selectedBarHeight = kTabButton_DefaultSelectedBarHeight;
    _animationTime = kTabButton_DefaultAnimationTime;
    _originalBtnTitleColor = D_TabButton_NormalButtonTitleColor;
    _selectBtnTitleColor = D_TabButton_SelectedButtonTitleColor;
}

-(void)setSelectedBarBackgroundColor:(UIColor *)selectedBarBackgroundColor{
    if( !selectedBarBackgroundColor ){
        selectedBarBackgroundColor = D_TabButton_SelectedBarBackgroundColor;
    }
    if( _selectedBarBackgroundColor != selectedBarBackgroundColor ){
        _selectedBarBackgroundColor = selectedBarBackgroundColor;
        [_selectedBarBackgroundView setBackgroundColor:_selectedBarBackgroundColor];
    }
}

-(void)setSelectedBarColor:(UIColor *)selectedBarColor{
    if( !selectedBarColor ){
        selectedBarColor = D_TabButton_SelectedBarColor;
    }
    if( _selectedBarColor != selectedBarColor ){
        _selectedBarColor = selectedBarColor;
        [_selectedBarView setBackgroundColor:_selectedBarColor];
    }
}

-(void)setButtonHeight:(CGFloat)buttonHeight{
    if( buttonHeight <= 0 ){
        buttonHeight = kTabButton_DefaultHeight;
    }
    _buttonHeight = buttonHeight;
    [self resetAllButtonHeight];
}

-(void)setButtonIndex:(NSUInteger)buttonIndex{
    [self setButtonSelectedTitleColor:buttonIndex];
    [self setIndexValue:buttonIndex];
    [self setSelectedBarIndex:buttonIndex isNeedAnimation:YES];
}

-(void)setButtonIndexWithoutAnimation:(NSUInteger)buttonIndex{
    [self setButtonSelectedTitleColor:buttonIndex];
    [self setIndexValue:buttonIndex];
    [self setSelectedBarIndex:buttonIndex isNeedAnimation:NO];
}

-(void)setAnimationTime:(CGFloat)animationTime{
    if( _animationTime != animationTime ){
        if( animationTime < kTabButton_DefaultAnimationTimeMin ){
            animationTime = kTabButton_DefaultAnimationTimeMin;
        }
        else if( animationTime > kTabButton_DefaultAnimationTimeMax ){
            animationTime = kTabButton_DefaultAnimationTimeMax;
        }
        _animationTime = animationTime;
    }
}

-(void)setOriginalBtnTitleColor:(UIColor *)originalBtnTitleColor{
    if( !originalBtnTitleColor ){
        originalBtnTitleColor = D_TabButton_NormalButtonTitleColor;
    }
    if( _originalBtnTitleColor != originalBtnTitleColor ){
        _originalBtnTitleColor = D_TabButton_NormalButtonTitleColor;
        for ( UIButton *btn in _buttonArray ) {
            [btn setTitleColor:_originalBtnTitleColor forState:(UIControlStateNormal)];
        }
    }
}

-(void)setSelectBtnTitleColor:(UIColor *)selectBtnTitleColor{
    if( !selectBtnTitleColor ){
        selectBtnTitleColor = D_TabButton_SelectedButtonTitleColor;
    }
    if( _selectBtnTitleColor != selectBtnTitleColor ){
        [self setButtonSelectedTitleColor:self.buttonIndex];
    }
}

-(void)setButtonSelectedTitleColor:(NSUInteger)index{
    UIButton *selectedBtn = [self.buttonArray objectAtIndex:index];
    [selectedBtn setTitleColor:self.selectBtnTitleColor forState:(UIControlStateNormal)];
    if( index != self.buttonIndex ){
        UIButton *originalSelectedBtn = [_buttonArray objectAtIndex:self.buttonIndex];
        [originalSelectedBtn setTitleColor:self.originalBtnTitleColor forState:(UIControlStateNormal)];
    }
}

#pragma mark - Private
-(BOOL)initialButtons{
    BOOL isOK = NO;
    if( [_buttonArray count] >= 1 ){
        isOK = YES;
        // 取第一個按鈕高度來設定整體高度
        UIButton *btn = [_buttonArray firstObject];
        if( btn.frame.size.height != self.buttonHeight ){
            // 設定高度
            self.buttonHeight = btn.frame.size.height;
        }
        [_mainContainer addUnits:_buttonArray];
        [self addSubview:_mainContainer];
        
        // 設定 Action
        NSUInteger index = 0;
        for ( UIButton *btn in _buttonArray ) {
            btn.tag = index;
            [btn addTarget:self action:@selector(pressedButton:) forControlEvents:(UIControlEventTouchUpInside)];
            index++;
        }
    }
    else{
        TTLog(@" Fail to Initial Buttons !!!");
    }
    return isOK;
}

-(void)initialSelectBar{
    if( !_selectedBarBackgroundView ){
        _selectedBarBackgroundView = 
        [[UIView alloc] initWithFrame:CGRectMake(0 , self.frame.size.height - _selectedBarHeight + 1,
                                                 self.frame.size.width , self.selectedBarHeight - 2)];
        [_selectedBarBackgroundView setBackgroundColor:self.selectedBarBackgroundColor];
    }
    [self addSubview:_selectedBarBackgroundView];
    if( !_selectedBarView ){
        UIButton *btn = [_buttonArray firstObject];
        _selectedBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - _selectedBarHeight,
                                                                btn.frame.size.width, self.selectedBarHeight)];
        [_selectedBarView setBackgroundColor:self.selectedBarColor];
    }
    [self addSubview:_selectedBarView];
}

-(void)resetAllButtonHeight{
    for ( UIButton *btn in _buttonArray ) {
        [btn setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y,
                                 btn.frame.size.width, _buttonHeight)];
    }
    [self setFrame:CGRectMake(self.frame.origin.x , self.frame.origin.y, 
                              self.frame.size.width , _buttonHeight)];
    [self.mainContainer setContainerViewHight:_buttonHeight];
}

-(void)setSelectedBarIndex:(NSUInteger)index isNeedAnimation:(BOOL)isNeedAnimation{
    if( isNeedAnimation ){
        __weak __typeof(self)weakSelf = self;
        [UIView animateWithDuration:self.animationTime animations:^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf setSelectedBarIndex:index];
        }];
    }
    else{
        [self setSelectedBarIndex:index];
    }
}

-(void)setSelectedBarIndex:(NSUInteger)index{
    UIButton *btn = [_buttonArray objectAtIndex:index];
    self.selectedBarView.center = CGPointMake(btn.center.x, 
                                              self.selectedBarView.center.y);
}

-(void)setIndexValue:(NSUInteger)indexValue{
    if( indexValue >= [_buttonArray count] ){
        indexValue = 0;
    }
    _buttonIndex = indexValue;
}

-(void)pressedButton:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if( _delegate && [_delegate respondsToSelector:@selector(selectedButton:)] ){
        [_delegate selectedButton:btn.tag];
    }
    [self setButtonIndex:btn.tag];
}

@end
