//
//  ViewController.m
//  ViewToolsProject
//
//  Created by Coody on 2015/9/1.
//  Copyright (c) 2015年 Coody. All rights reserved.
//

#import "ViewController.h"

#import "ContainerView.h"
#import "ViewTools.h"

#define D_Top_Distance (20.0f)
#define D_Center_Distance (10.0f)

@interface ViewController ()
@property (nonatomic , strong) ViewTools *viewTool;
@property (nonatomic , strong) ContainerView *mainView;
@property (nonatomic , strong) NSMutableArray *viewArray;
@property (nonatomic , strong) UIScrollView *scrollView;
@end

@implementation ViewController
#pragma mark - Init
-(id)init{
    self = [super init];
    if ( self ) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
#define D_Test
#ifdef D_Test
        // Unit Test
        
        // ViewTools
        _viewTool = [[ViewTools alloc] init];
        
        // 1.1.1
        [_viewTool setViewHeight:45];
        
        NSLog(@" show view tools Height = %f" , [_viewTool getViewHeight]);
        
        // 1.1.2
        [_viewTool setAllTextColor:[UIColor orangeColor]];
        
        // 目前不塞圖
        // 1.2
//        [_viewTool setButtonImage:nil 
//         andButtonHightLightImage:nil 
//            andButtonDisableImage:nil];
        
        
        
        // 1.3
        [_viewTool setButtonTextColor:[UIColor whiteColor]];
        // 1.4
        [_viewTool setButtonLeftTextColor:[UIColor grayColor]];
        // 1.5
        [_viewTool setButtonRightTextColor:[UIColor blueColor]];
        
        // 目前不另外設定 Arrow 的圖片
        // 1.6
//        [_viewTool setArrowImage:nil];
        // 不設定 TextField 的外框框
        // 1.7
//        [_viewTool setTextFieldImage:nil];
        
        // 1.13
        [_viewTool setTextFieldTintColor:[UIColor blueColor]];
        // 1.8
        [_viewTool setTextFieldTextColor:[UIColor greenColor]];
        // 1.9
        [_viewTool setTextFieldInnerColor:[UIColor darkGrayColor]];
        
        // 1.10
        [_viewTool setLabelTextColor:[UIColor darkGrayColor]];
        // 1.11
        [_viewTool setTextButtonColor:[UIColor grayColor]];
        // 1.12
        [_viewTool setTextFont:[UIFont systemFontOfSize:16.0f]];
        
        
        // ContainerView
        _mainView = [[ContainerView alloc] init];
        _mainView.isVertical = YES;
        [_mainView setTopMargin:D_Top_Distance];
        [_mainView setMiddleMargin:D_Center_Distance];
        [_mainView setLeftMargin:D_Center_Distance];
        [_mainView setRightMargin:D_Center_Distance];
        _viewArray = [[NSMutableArray alloc] init];
        
        
        
#ifdef D_TestConstrain
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        [button1 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [button1 setTitle:@"TEST" forState:(UIControlStateNormal)];
        [button1 setTitle:@"GO!" forState:(UIControlStateHighlighted)];
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        [button2 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [button2 setTitle:@"TEST" forState:(UIControlStateNormal)];
        [button2 setTitle:@"GO!" forState:(UIControlStateHighlighted)];
        [self.view addSubview:button1];
        [self.view addSubview:button2];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[button1]-[button2]-%f-|" , 6.0f , 6.0f] 
                                                                          options:0 
                                                                          metrics:nil 
                                                                            views:@{@"button1":button1,
                                                                                    @"button2":button2}]];
#else
        
        
        
        // 2.1.1
        {
            ContainerView *containerView1 = [[ContainerView alloc] init];
            [containerView1 setLeftMargin:6.0f];
            UIButton *button1 = [_viewTool createButtonWithLeftText:@"測試 2.1.1" withRightText:@"測試1" withNeedArrow:YES];
            [containerView1 addUnits:@[button1]];
            UIButton *button2 = [_viewTool createButtonWithLeftText:@"測試 2.1.1" withRightText:@"測試2" withNeedArrow:NO];
            ContainerView *containerView2 = [[ContainerView alloc] init];
            [containerView2 setLeftMargin:6.0f];
            [containerView2 addUnits:@[button2]];
            [_viewArray addObjectsFromArray:@[containerView1 , containerView2]];
        }
        
        // 2.1.2
        {
            ContainerView *containerView1 = [[ContainerView alloc] init];
            [containerView1 setLeftMargin:6.0f];
            UIButton *button1 = [_viewTool createButtonWithLeftAttributedText:[[NSMutableAttributedString alloc] initWithString:@"測試 2.1.2"] 
                                                      withRightAttributedText:[[NSMutableAttributedString alloc] initWithString:@"測試 2.1.2"] 
                                                                withNeedArrow:YES];
            [containerView1 addUnits:@[button1]];
            
            ContainerView *containerView2 = [[ContainerView alloc] init];
            [containerView2 setLeftMargin:6.0f];
            UIButton *button2 = [_viewTool createButtonWithLeftAttributedText:[[NSMutableAttributedString alloc] initWithString:@"測試 2.1.2"] 
                                                      withRightAttributedText:[[NSMutableAttributedString alloc] initWithString:@"測試 2.1.2"] 
                                                                withNeedArrow:NO];
            [containerView2 addUnits:@[button2]];
            [_viewArray addObjectsFromArray:@[containerView1 , containerView2]];
        }
        
        // 2.1.3 , 2.2.1
        {
            [_viewTool setViewHeight:80.0f];
            UIButton *button1 = [_viewTool createButtonWithLeftText:@"2.2.1x" 
                                                      withRightText:@"2.2.1x" 
                                                      withNeedArrow:YES 
                                                    withCustomWidth:160];
            UIButton *button2 = [_viewTool createButtonWithLeftAttributedText:[[NSMutableAttributedString alloc] initWithString:@"2.1.3\n行高"] 
                                                               withLineHeight:1.2 
                                                      withRightAttributedText:[[NSMutableAttributedString alloc] initWithString:@"2.1.3\n行高"] 
                                                               withLineHeight:2.0 
                                                                withNeedArrow:NO];
            
            ContainerView *containerView1 = [[ContainerView alloc] init];
            [containerView1 setLeftMargin:6.0f];
            [containerView1 setMiddleMargin:6.0f];
            [containerView1 addUnits:@[button1,button2]];
            containerView1.isSeparateAllUnit = YES;
            
            UIButton *button3 = [_viewTool createButtonWithLeftText:@"2.2.1" 
                                                      withRightText:@"2.2.1" 
                                                      withNeedArrow:NO 
                                                    withCustomWidth:160];
            UIButton *button4 = [_viewTool createButtonWithLeftAttributedText:[[NSMutableAttributedString alloc] initWithString:@"2.1.3\n行高"] 
                                                               withLineHeight:2.0 
                                                      withRightAttributedText:[[NSMutableAttributedString alloc] initWithString:@"2.1.3\n行高"] 
                                                               withLineHeight:1.5 
                                                                withNeedArrow:YES];
            ContainerView *containerView2 = [[ContainerView alloc] init];
            [containerView2 setLeftMargin:6.0f];
            [containerView2 setMiddleMargin:6.0f];
            [containerView2 addUnits:@[button3,button4]];
            
            [_viewArray addObjectsFromArray:@[containerView1 , containerView2]];
            [_viewTool setViewHeight:45.0f];
        }
        
        // 2.2.2 , 2.2.4
        {
            ContainerView *containerView1 = [[ContainerView alloc] init];
            [containerView1 setLeftMargin:6.0f];
            [containerView1 setMiddleMargin:6.0f];
            [_viewTool setViewHeight:80.0f];
            UIButton *button1 = [_viewTool createButtonWithLeftAttributeText:[[NSMutableAttributedString alloc] initWithString:@"2.2.2"] 
                                                      withRightAttributeText:[[NSMutableAttributedString alloc] initWithString:@"2.2.2"] 
                                                               withNeedArrow:YES 
                                                             withCustomWidth:140];
            UIButton *button2 = [_viewTool createButtonWithLeftText:@"2.2.4" 
                                                      withRightText:@"2.2.4" 
                                                      withNeedArrow:YES 
                                                    withLabelStatic:EnumLabelStaticType_LeftStatic];
            [containerView1 addUnits:@[button1,button2]];
            
            ContainerView *containerView2 = [[ContainerView alloc] init];
            [containerView2 setLeftMargin:6.0f];
            [containerView2 setMiddleMargin:6.0f];
            UIButton *button3 = [_viewTool createButtonWithLeftAttributeText:[[NSMutableAttributedString alloc] initWithString:@"2.2.2"] 
                                                      withRightAttributeText:[[NSMutableAttributedString alloc] initWithString:@"2.2.2"] 
                                                               withNeedArrow:NO 
                                                             withCustomWidth:140];
            UIButton *button4 = [_viewTool createButtonWithLeftText:@"2.2.4" 
                                                      withRightText:@"2.2.4" 
                                                      withNeedArrow:NO 
                                                    withLabelStatic:EnumLabelStaticType_RightStatic];
            [containerView2 addUnits:@[button3,button4]];
            
            [_viewArray addObjectsFromArray:@[containerView1 , containerView2]];
            
        }
        
        // 2.2.3 , 2.3.1 , 2.5
        {
            [_viewTool setViewHeight:120.0f];
            
            ContainerView *containerView1 = [[ContainerView alloc] init];
            [containerView1 setMiddleMargin:6.0f];
            [containerView1 setRightMargin:6.0f];
            UIButton *button1 = [_viewTool createButtonWithLeftAttributedText:[[NSMutableAttributedString alloc] initWithString:@"2.2.3"] 
                                                               withLineHeight:1.5 
                                                      withRightAttributedText:[[NSMutableAttributedString alloc] initWithString:@"2.2.3"] 
                                                               withLineHeight:2.0 
                                                                withNeedArrow:YES 
                                                              withCustomWidth:140];
            UIButton *button2 = [_viewTool createButtonWithText:@"2.3.1"];
            [containerView1 addUnits:@[button1,button2]];
            
            ContainerView *containerView2 = [[ContainerView alloc] init];
            [containerView2 setMiddleMargin:6.0f];
            [containerView2 setRightMargin:6.0f];
            UIButton *button3 = [_viewTool createButtonWithLeftAttributedText:[[NSMutableAttributedString alloc] initWithString:@"2.3.1"] 
                                                               withLineHeight:1.0 
                                                      withRightAttributedText:[[NSMutableAttributedString alloc] initWithString:@"2.3.1"] 
                                                               withLineHeight:1.0 
                                                                withNeedArrow:NO 
                                                              withCustomWidth:140];
            UIButton *button4 = [_viewTool createRedButtonWithText:@"2.5"];
            [containerView2 addUnits:@[button3,button4]];
            
            [_viewArray addObject:containerView2];
            
            [_viewTool setViewHeight:45.0f];
        }
        
        // 2.2.5 , 2.3.2 , 2.12
        {
            ContainerView *containerView1 = [[ContainerView alloc] init];
            [containerView1 setLeftMargin:6.0f];
            [containerView1 setMiddleMargin:6.0f];
            
            UIButton *button1 = [_viewTool createButtonWithLeftText:@"2.2.5" 
                                                      withRightText:@"2.2.5" 
                                                      withNeedArrow:YES 
                                                    withCustomWidth:140 
                                                    withLabelStatic:(EnumLabelStaticType_LeftStatic)];
            UIButton *button2 = [_viewTool createButtonWithTextAndMargin:@"2.3.2"];
            [containerView1 addUnits:@[button1 , button2]];
            [_viewArray addObject:containerView1];
            
            ContainerView *containerView2 = [[ContainerView alloc] init];
            [containerView2 setLeftMargin:6.0f];
            [containerView2 setMiddleMargin:6.0f];
            
            UIButton *button3 = [_viewTool createButtonWithLeftText:@"2.2.5" 
                                                      withRightText:@"2.2.5" 
                                                      withNeedArrow:NO 
                                                    withCustomWidth:140 
                                                    withLabelStatic:(EnumLabelStaticType_None)];
            UIButton *button4 = [_viewTool createTextButtonWithText:@"2.12" 
                                                      withTextColor:[UIColor redColor] 
                                                           withLine:YES 
                                                       withTextFont:[UIFont boldSystemFontOfSize:18.0f] 
                                           withIsNeedAutoResizeMask:YES];
            [containerView2 addUnits:@[button3 , button4]];
            [_viewArray addObject:containerView2];
        }
        
        // 2.4 , 2.6
        {
            ContainerView *containerView1 = [[ContainerView alloc] init];
            [containerView1 setLeftMargin:6.0f];
            [containerView1 setMiddleMargin:6.0f];
            UIButton *button1 = [_viewTool createButtonWithText:@"2.4" withCustomWidth:140.0f];
            UIButton *button2 = [_viewTool createRedButtonWithText:@"2.6" withCustomWidth:140.0f];
            // TODO: auto resize 例子
            [containerView1 addUnits:@[button1 , button2]];
            [_viewArray addObject:containerView1];
        }
        
        // 2.7 , 2.8
        {
            ContainerView *containerView1 = [[ContainerView alloc] init];
            [containerView1 setLeftMargin:6.0f];
            [containerView1 setMiddleMargin:6.0f];
            
            UIButton *button1 = [_viewTool createButtonWithText:@"2.7" withCustomWidth:140.0f withIsRedButton:YES];
            UIButton *button2 = [_viewTool createButtonWithText:@"2.8" 
                                                withCustomFrame:CGRectMake(0, 5, 130, [_viewTool getViewHeight] - 5) 
                                                withIsRedButton:YES];
            [containerView1 addUnits:@[button1 , button2]];
            
            ContainerView *containerView2 = [[ContainerView alloc] init];
            [containerView2 setLeftMargin:6.0f];
            [containerView2 setMiddleMargin:6.0f];
            
            UIButton *button3 = [_viewTool createButtonWithText:@"2.7" withCustomWidth:140.0f withIsRedButton:NO];
            UIButton *button4 = [_viewTool createButtonWithText:@"2.8" 
                                                withCustomFrame:CGRectMake(0, 10, 130, [_viewTool getViewHeight] - 20) 
                                                withIsRedButton:NO];
            [containerView2 addUnits:@[button3 , button4]];
            
            [_viewArray addObjectsFromArray:@[containerView1 , containerView2]];
        }
        
        // 2.9 , 2.10 , 2.11
        {
            ContainerView *containerView1 = [[ContainerView alloc] init];
            [containerView1 setLeftMargin:6.0f];
            [containerView1 setMiddleMargin:6.0f];
            
            UIButton *button1 = [_viewTool createTextButtonWithText:@"2.9"];
            UIButton *button2 = [_viewTool createTextButtonWithText:@"2.10" 
                                                      withTextColor:[UIColor blueColor] 
                                                           withLine:YES];
            [containerView1 addUnits:@[button1 , button2]];
            
            ContainerView *containerView2 = [[ContainerView alloc] init];
            [containerView2 setLeftMargin:6.0f];
            [containerView2 setMiddleMargin:6.0f];
            
            UIButton *button3 = [_viewTool createTextButtonWithText:@"2.11" 
                                                      withTextColor:[UIColor blueColor] 
                                                           withLine:NO 
                                                       withTextFont:[UIFont boldSystemFontOfSize:20.0f]];
            UIButton *button4 = [_viewTool createTextButtonWithText:@"2.10" 
                                                      withTextColor:[UIColor blueColor] 
                                                           withLine:NO];
            [containerView2 addUnits:@[button3 , button4]];
            
            [_viewArray addObjectsFromArray:@[containerView1 , containerView2]];
        }
        
        // 2.13
        {
            ContainerView *containerView = [[ContainerView alloc] init];
            [containerView setLeftMargin:6.0f];
            UIButton *button = [_viewTool createButtonWithLeftText:@"按下測試 2.13" withRightText:@"注意右邊箭頭" withNeedArrow:YES];
            [button addTarget:self action:@selector(pressedTest213:) forControlEvents:(UIControlEventTouchUpInside)];
            [containerView addUnits:@[button]];
            [_viewArray addObject:containerView];
        }
        
        // 3.1.1 , 3.1.1-2
        {
            ContainerView *containerView = [[ContainerView alloc] init];
            [containerView setLeftMargin:6.0f];
            [containerView setMiddleMargin:6.0f];
            UILabel *label = [_viewTool createLabelWithText:@"3.1.1" withTextAlignment:(NSTextAlignmentCenter)];
//            label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            
            UILabel *label2 = [_viewTool createLabelWithText:@"3.1.2" 
                                          withTextAlignment:(NSTextAlignmentCenter) 
                                       withIsNeedAutoResize:NO];
            [containerView addUnits:@[label , label2]];
            [_viewArray addObject:containerView];
            
            
        }
        
        // 
        {
            
        }
        
        // label 用法
        [self createLabel];
        
        // textField 用法
        [self createTextField];
        
        // Container View 用法
        [self createContainerView];
        
        // 特殊的按鈕
        [self createSpecialButton];
        
        // button
        [self createButton];
        
        [_mainView addUnits:_viewArray];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.contentSize = _mainView.frame.size;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_scrollView setScrollEnabled:YES];
        [_scrollView addSubview:_mainView];
        [self.view addSubview:_scrollView];
        
#endif
#endif
        
        /*
         ViewTools
         */
        
        
        
        /*
         ContainerView
         */
        
    }
    return self;
}

#pragma mark - Create UI 元件
-(void)createLabel{
    UILabel *testLabel1 = [_viewTool createLabelWithText:@"元件背景圖案請自行去 ViewTools 的 #define 設定檔案名稱（或路徑＋檔案名稱），或是改寫內部產生路徑當類別方法。\nPS: 目前黑色區塊為辨識 UIView 元件區塊，所自行設定的。" 
                                       withTextAlignment:(NSTextAlignmentLeft) 
                                    withIsNeedAutoResize:YES];
    [_viewArray addObject:testLabel1];
}

-(void)createTextField{
    UIView *testTextField = [_viewTool createTextFieldWithText:@"有字" withInnerText:@"請輸入內容" withTextAlignment:(NSTextAlignmentLeft)];
    //// get TextField in UIView
    UITextField *realTextField = [[_viewTool getRecentObjects] firstObject];
    //// and you can add action listener to real UITextField （得到 TextField 實體以後可以自行加入動作等等......）
    [_viewArray addObject:testTextField];
}

-(void)createContainerView{
    //
    ContainerView *testContainerView1 = [[ContainerView alloc] init];
    testContainerView1.isSeparateAllUnit = YES;
    
    // 設定 ContainerView 內左間距
    [testContainerView1 setLeftMargin:15.0f];
    // 設定 ContainerView 內的元件與元件之間間距
    [testContainerView1 setMiddleMargin:6.0f];
    
    // 產生一個 Label
    UILabel *nameLabel = [_viewTool createLabelWithText:@"姓名" withTextAlignment:(NSTextAlignmentCenter)];
    
    // 產生一個 TextField 的 View
    UIView *nameTextView = [_viewTool createTextFieldWithText:@"" withInnerText:@"請輸入姓名" withTextAlignment:(NSTextAlignmentLeft) withCustomWidth:100.0f];
    // 取得真正 TextField
    UITextField *nameTextField = [[_viewTool getRecentObjects] firstObject];
    
    // 產生一個 Button
    UIButton *nameSendButton = [_viewTool createButtonWithText:@"Send!!"];
    [nameSendButton setTitle:@"Done!!" forState:(UIControlStateHighlighted)];
    
    // 將元件加入 ContainerView 讓他計算
    [testContainerView1 addUnits:@[ nameLabel , nameTextView , nameSendButton ]];
    
    // 將 Container View 加入 mainView
    [_viewArray addObject:testContainerView1];
    
    
    // 設定測試 Button 顏色讓畫面更清楚（因為目前沒有放圖片）
    nameSendButton.layer.cornerRadius = 5.0f;
    nameSendButton.layer.masksToBounds = YES;
}

-(void)createSpecialButton{
    UIButton *specialButton = [_viewTool createButtonWithLeftText:@"左邊文字" withRightText:@"右邊文字" withNeedArrow:YES withLabelStatic:(EnumLabelStaticType_LeftStatic)];
    specialButton.layer.borderColor=[UIColor blackColor].CGColor;
    specialButton.layer.borderWidth=5.0f;
    specialButton.layer.masksToBounds = YES;
    specialButton.layer.cornerRadius = 10.0f;
    [specialButton addTarget:self action:@selector(pressedSpecialBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [_viewArray addObject:specialButton];
    
    
    UIButton *testBtn = [_viewTool createButtonWithLeftIconImage:[[UIImage alloc] init] withRightText:@"test" withIsSystemDefaultStyle:YES];
    
    [_viewArray addObject:testBtn];
    
}

-(void)createButton{
    UIButton *testBtn1 = [_viewTool createButtonWithText:@"Send!!!"];
    [testBtn1 setTitle:@"Done?" forState:(UIControlStateHighlighted)];
    testBtn1.layer.cornerRadius = 5.0;
    testBtn1.layer.masksToBounds = YES;
    [_viewArray addObject:testBtn1];
}

#pragma makr - Pressed
-(void)pressedSpecialBtn:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test" message:@"按下左右兩邊有文字按鈕！" delegate:nil 
                                          cancelButtonTitle:@"確定" otherButtonTitles:nil];
    [alert show];
}

-(void)pressedTest213:(id)sender{
    [ViewTools isNeedArrow:NO withButton:(UIButton *)sender];
}


#pragma mark - appear & disappear
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - didload & memnry warning
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
