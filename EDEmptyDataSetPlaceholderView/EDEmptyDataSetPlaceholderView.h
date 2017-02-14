//
//  EDEmptyDataSetPlaceholderView
//  pyyx
//
//  Created by xulinfeng on 2016/12/9.
//  Copyright © 2016年 xulinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDEmptyDataSetPlaceholderView : UIView

@property (nonatomic, strong, readonly) UIView *contentView;

@property (nonatomic, assign) UIEdgeInsets contentInsets;

+ (instancetype)placeholder;
+ (instancetype)placeholderWithIcon:(NSString *)icon;
+ (instancetype)placeholderWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)placeholderWithIcon:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle;
+ (instancetype)placeholderWithIcon:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle buttonTitle:(NSString *)buttonTitle;

- (instancetype)initWithIcon:(NSString *)icon;
- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;
- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle;
- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle buttonTitle:(NSString *)buttonTitle;

- (void)appendIcon:(NSString *)icon completion:(void (^)(UILabel *iconLabel, CGFloat *offset, CGFloat *height))completion;
- (void)appendImage:(UIImage *)image completion:(void (^)(UIImageView *imageView, CGFloat *offset, CGFloat *height))completion;
- (void)appendTitle:(NSString *)title completion:(void (^)(UILabel *titleLabel, CGFloat *offset, CGFloat *height))completion;
- (void)appendSubTitle:(NSString *)subtitle completion:(void (^)(UILabel *subtitleLabel, CGFloat *offset, CGFloat *height))completion;
- (void)appendButtonWithTitle:(NSString *)title completion:(void (^)(UIButton *button, CGFloat *offset, CGFloat *height))completion;
- (void)appendView:(UIView *)view completion:(void (^)(UIView *view, CGFloat *offset, CGFloat *height))completion;

@end

