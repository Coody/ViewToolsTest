//
//  TabButton.h
//  SegmentBtn
//
//  Created by coodychou on 2018/10/23.
//  Copyright © 2018 coodychou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define D_TabButton_SelectedBarBackgroundColor [UIColor darkGrayColor]
#define D_TabButton_SelectedBarColor           [UIColor yellowColor]
#define D_TabButton_NormalButtonTitleColor     [UIColor blackColor]
#define D_TabButton_SelectedButtonTitleColor   [UIColor redColor]
extern CGFloat const kTabButton_DefaultHeight;
extern NSTimeInterval const kTabButton_DefaultAnimationTime;

@protocol TabButtonProtocol <NSObject>
-(void)selectedButton:(NSUInteger)index;
@end

@interface TabButton : UIView
@property (nonatomic , weak) id <TabButtonProtocol> delegate;
@property (nonatomic , readonly) NSArray <UIButton *> *buttonArray;
@property (nonatomic , assign) CGFloat buttonHeight;
@property (nonatomic , assign) CGFloat animationTime;
@property (nonatomic , strong) UIColor *selectedBarBackgroundColor;
@property (nonatomic , strong) UIColor *selectedBarColor;
@property (nonatomic , assign) CGFloat selectedBarHeight;
@property (nonatomic , strong) UIColor *originalBtnTitleColor;
@property (nonatomic , strong) UIColor *selectBtnTitleColor;
-(instancetype)initWithButtons:(nonnull NSArray<UIButton *> *)buttonArray;
-(void)setButtonIndex:(NSUInteger)buttonIndex;
-(void)setButtonIndexWithoutAnimation:(NSUInteger)buttonIndex;
@end

