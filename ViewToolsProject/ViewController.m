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
@property (nonatomic , strong) UIView *mainView;
@end

@implementation ViewController
#pragma mark - Init
-(id)init{
    self = [super init];
    if ( self ) {
        _viewTool = [[ViewTools alloc] init];
        _mainView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        // Test 
        
        // label 用法
        UILabel *testLabel1 = [_viewTool createLabelWithText:@"測試一下！！測試一下！！測試一下！！測試一下！！測試一下！！測試一下！！" 
                                           withTextAlignment:(NSTextAlignmentLeft) withIsTemplet:YES];
        [testLabel1 setBackgroundColor:[UIColor blackColor]];
        [_mainView addSubview:testLabel1];
        
        // textField 用法
        UIView *testTextField = [_viewTool createTextFieldWithText:@"有字" withInnerText:@"請輸入內容" withTextAlignment:(NSTextAlignmentLeft)];
        //// get TextField in UIView
        UITextField *realTextField = [[_viewTool getRecentObjects] firstObject];
        //// and you can add action listener to real UITextField
        
        // Container View 用法
        
        // button
        UIButton *testBtn1 = [_viewTool createButtonWithText:@"TEST!!"];
        [testBtn1 setBackgroundColor:[UIColor blackColor]];
        testBtn1.layer.cornerRadius = 5.0;
        testBtn1.layer.masksToBounds = YES;
        [_mainView addSubview:testBtn1];
        
        [self endAddMainView];
        [self.view addSubview:_mainView];
    }
    return self;
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
    CGFloat recent_Y_Distance = D_Top_Distance;
    for ( UIView *unit in _mainView.subviews ) {
        unit.frame = CGRectMake(unit.frame.origin.x, recent_Y_Distance, unit.frame.size.width, unit.frame.size.height);
        recent_Y_Distance = recent_Y_Distance + unit.frame.size.height + D_Center_Distance;
    }
}


@end
