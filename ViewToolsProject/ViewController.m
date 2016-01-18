//
//  ViewController.m
//  ViewToolsProject
//
//  Created by Coody on 2015/9/1.
//  Copyright (c) 2015年 Coody. All rights reserved.
//

#import "ViewController.h"

#import "ViewTools.h"

#define D_Top_Distance (50.0f)
#define D_Center_Distance (10.0f)

@interface ViewController ()
@property (nonatomic , strong) ViewTools *viewTool;
@property (nonatomic , strong) ContainerView *mainView;
@property (nonatomic , strong) NSMutableArray *viewArray;
@end

@implementation ViewController
#pragma mark - Init
-(id)init{
    self = [super init];
    if ( self ) {
        _viewTool = [[ViewTools alloc] init];
        _mainView = [[ContainerView alloc] init];
        _mainView.isVertical = YES;
        [_mainView setTopMargin:D_Top_Distance];
        [_mainView setMiddleMargin:D_Center_Distance];
        [_mainView setLeftMargin:D_Center_Distance];
        _viewArray = [[NSMutableArray alloc] init];
        
        // Test 
        
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
        
//        [self endAddMainView];
        
        [_mainView addUnits:_viewArray];
        
        [self.view addSubview:_mainView];
    }
    return self;
}

#pragma mark - Create UI 元件
-(void)createLabel{
    UILabel *testLabel1 = [_viewTool createLabelWithText:@"元件背景圖案請自行去 ViewTools 的 #define 設定檔案名稱（或路徑＋檔案名稱），或是改寫內部產生路徑當類別方法。\nPS: 目前黑色區塊為辨識 UIView 元件區塊，所自行設定的。" 
                                       withTextAlignment:(NSTextAlignmentLeft) withIsTemplet:YES];
    [testLabel1 setBackgroundColor:[UIColor blackColor]];
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
    [nameLabel setBackgroundColor:[UIColor blackColor]];
    [nameTextView setBackgroundColor:[UIColor blackColor]];
    [nameSendButton setBackgroundColor:[UIColor blackColor]];
    nameSendButton.layer.cornerRadius = 5.0f;
    nameSendButton.layer.masksToBounds = YES;
}

-(void)createSpecialButton{
    UIButton *specialButton = [_viewTool createButtonWithLeftText:@"左邊文字" withRightText:@"右邊文字" withNeedArrow:YES];
    specialButton.layer.borderColor=[UIColor blackColor].CGColor;
    specialButton.layer.borderWidth=5.0f;
    specialButton.layer.masksToBounds = YES;
    specialButton.layer.cornerRadius = 10.0f;
    [specialButton addTarget:self action:@selector(pressedSpecialBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [_viewArray addObject:specialButton];
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

#pragma mark - private methods
-(void)endAddMainView{
//    CGFloat recent_Y_Distance = D_Top_Distance;
//    for ( UIView *unit in _mainView.subviews ) {
//        unit.frame = CGRectMake(unit.frame.origin.x, recent_Y_Distance, unit.frame.size.width, unit.frame.size.height);
//        recent_Y_Distance = recent_Y_Distance + unit.frame.size.height + D_Center_Distance;
//    }
}


@end
