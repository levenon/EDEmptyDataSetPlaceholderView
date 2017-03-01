//
//  ViewController.m
//  EDEmptyDataSetPlaceholderViewDemo
//
//  Created by xulinfeng on 2017/2/14.
//  Copyright © 2017年 xulinfeng. All rights reserved.
//

#import "ViewController.h"
#import "EDEmptyDataSetPlaceholderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView{
    [super loadView];
    
//    EDEmptyDataSetPlaceholderView *placeholderView = [EDEmptyDataSetPlaceholderView placeholderWithIcon:@"欢迎来到代码世界" title:@"代码的世界是具有创造性的" subtitle:@"是富有奇幻色彩的" buttonTitle:@"现在进入"];
//    [placeholderView appendImage:[UIImage imageNamed:@"icon"] completion:^(UIImageView *imageView, CGFloat *offset, CGFloat *height) {
//        *height = 100;
//        *offset = 20;
//    }];
    
//    EDEmptyDataSetPlaceholderView *placeholderView = [EDEmptyDataSetPlaceholderView placeholder];
//    [placeholderView appendImage:[UIImage imageNamed:@"icon"] completion:^(UIImageView *imageView, CGFloat *offset, CGFloat *height) {
//        *height = 100;
//        *offset = 20;
//    }];
//    
//    [placeholderView appendTitle:@"欢迎来到代码世界" completion:^(UILabel *titleLabel, CGFloat *offset, CGFloat *height) {
//        *offset = 30;
//    }];
//    
//    [placeholderView appendSubTitle:@"代码的世界是具有创造性的" completion:^(UILabel *subtitleLabel, CGFloat *offset, CGFloat *height) {
//        *offset = 30;
//    }];
//    
//    [placeholderView appendSubTitle:@"是富有奇幻色彩的" completion:^(UILabel *subtitleLabel, CGFloat *offset, CGFloat *height) {
//        *offset = 30;
//    }];
//    
//    [placeholderView appendButtonWithTitle:@"现在进入" completion:^(UIButton *button, CGFloat *offset, CGFloat *height) {
//        *offset = 30;
//        *height = 44;
//    }];
    
    EDEmptyDataSetPlaceholderView *placeholderView = [EDEmptyDataSetPlaceholderView placeholder];
    
    [placeholderView appendImage:[UIImage imageNamed:@"step1"] completion:^(UIImageView *imageView, CGFloat *offset, CGFloat *height) {
        *offset = 0;
    }];
    
    [placeholderView appendButtonWithTitle:@"         朕知道了          " completion:^(UIButton *button, CGFloat *offset, CGFloat *height) {
        button.layer.cornerRadius = 4;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [[UIColor whiteColor] CGColor];
        
        button.userInteractionEnabled = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        *offset =  12;
    }];
    
    [placeholderView appendTitle:@"与新朋友相互右滑回答后可实名聊天" completion:^(UILabel *titleLabel, CGFloat *offset, CGFloat *height) {
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor greenColor];
        titleLabel.numberOfLines = 1;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        *offset = 12.f;
    }];
    
    placeholderView.frame = [[self view] bounds];
    
    self.view.backgroundColor = [UIColor blackColor];
    [[self view] addSubview:placeholderView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
