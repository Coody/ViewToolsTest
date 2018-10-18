//
//  TestViewController.m
//  ViewToolsProject
//
//  Created by coodychou on 2018/10/17.
//  Copyright © 2018 Coody. All rights reserved.
//

#import "TestViewController.h"

// for Tools
#import "ContainerView.h"
#import "ViewTools.h"

@interface TestViewController ()
@property (nonatomic , strong) UIButton *firstBtn;
@property (nonatomic , strong) UIView *textView;
@property (nonatomic , strong) UILabel *textLabel;
@property (nonatomic , strong) ContainerView *container;
@property (nonatomic , strong) ViewTools *viewTool;
@end

@implementation TestViewController
-(instancetype)init{
    self = [super init];
    if( self ){
        [self.view setBackgroundColor:[UIColor blackColor]];
        
        _viewTool = [[ViewTools alloc] init];
        _container = [[ContainerView alloc] init];
        [_container setIsVertical:YES];
        [_container setTopMargin:40.0f];
        [_container setMiddleMargin:12.0f];
        
        _firstBtn = [_viewTool createButtonWithText:@"test"];
        _textView = [_viewTool createTextFieldWithText:@"test" withInnerText:@"123" withTextAlignment:(NSTextAlignmentCenter)];
        _textLabel = [_viewTool createLabelWithText:@"test3" withTextAlignment:(NSTextAlignmentLeft)];
        [_container addUnits:@[ _textLabel , _textView , _firstBtn ]];
        [self.view addSubview:_container];
        
        [self performSelector:@selector(changeView) withObject:nil afterDelay:5.0f];
    }
    return self;
}

-(void)changeView{
    [UIView animateWithDuration:1.0f animations:^{
        [_container removeUnit:_textView];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
