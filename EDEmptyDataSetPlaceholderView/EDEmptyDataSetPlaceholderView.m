//
//  EDEmptyDataSetPlaceholderView.m
//  EDEmptyDataSetPlaceholderView
//
//  Created by xulinfeng on 2016/12/9.
//  CopEDight © 2016年 xulinfeng. All rights reserved.
//

#import "EDEmptyDataSetPlaceholderView.h"
#import <objc/runtime.h>

@interface _EDEmptyDataSetPlaceholderViewButton : UIButton
@end
@implementation _EDEmptyDataSetPlaceholderViewButton

- (CGSize)intrinsicContentSize{
    NSString *title = [self titleForState:[self state]];
    CGSize contentSize = [title sizeWithAttributes:@{NSFontAttributeName: [[self titleLabel] font]}];
    contentSize.width += 26 * 2;
    contentSize.height += (6.5 * 2 + 4);
    return contentSize;
}

@end

@interface _EDOffsetView : UIView
@end
@implementation _EDOffsetView
@end

@interface EDEmptyDataSetPlaceholderView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSMutableArray<UIView *> *mutableItemViews;

@end

@interface UIView (EDEmptyDataSetPlaceholderViewOffset)
@property (nonatomic, assign) CGFloat emptyDataSetPlaceholderViewOffset;
@property (nonatomic, assign) CGFloat emptyDataSetPlaceholderViewContentHeight;
@end

@implementation UIView (EDEmptyDataSetPlaceholderViewOffset)

- (CGFloat)emptyDataSetPlaceholderViewOffset{
    return [objc_getAssociatedObject(self, @selector(emptyDataSetPlaceholderViewOffset)) floatValue];
}

- (void)setEmptyDataSetPlaceholderViewOffset:(CGFloat)emptyDataSetPlaceholderViewOffset{
    objc_setAssociatedObject(self, @selector(emptyDataSetPlaceholderViewOffset), @(emptyDataSetPlaceholderViewOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)emptyDataSetPlaceholderViewContentHeight{
    return [objc_getAssociatedObject(self, @selector(emptyDataSetPlaceholderViewContentHeight)) floatValue];
}

- (void)setEmptyDataSetPlaceholderViewContentHeight:(CGFloat)emptyDataSetPlaceholderViewContentHeight{
    objc_setAssociatedObject(self, @selector(emptyDataSetPlaceholderViewContentHeight), @(emptyDataSetPlaceholderViewContentHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

@implementation EDEmptyDataSetPlaceholderView

+ (instancetype)placeholder;{
    return [self placeholderWithIcon:0];
}

+ (instancetype)placeholderWithIcon:(NSString *)icon;{
    return [self placeholderWithIcon:icon title:nil];
}

+ (instancetype)placeholderWithIcon:(NSString *)icon title:(NSString *)title;{
    return [self placeholderWithIcon:icon title:title subtitle:nil];
}

+ (instancetype)placeholderWithIcon:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle;{
    return [self placeholderWithIcon:icon title:title subtitle:subtitle buttonTitle:nil];
}

+ (instancetype)placeholderWithIcon:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle buttonTitle:(NSString *)buttonTitle;{
    return [[self alloc] initWithIcon:icon title:title subtitle:subtitle buttonTitle:buttonTitle];
}

- (instancetype)initWithIcon:(NSString *)icon;{
    return [self initWithIcon:icon title:nil];
}

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;{
    return [self initWithIcon:icon title:title subtitle:nil];
}

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle;{
    return [self initWithIcon:icon title:title subtitle:subtitle buttonTitle:nil];
}

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle buttonTitle:(NSString *)buttonTitle;{
    if (self = [self init]) {
        if (icon) {
            [self appendIcon:icon completion:nil];
        }
        if (title) {
            [self appendTitle:title completion:nil];
        }
        if (subtitle) {
            [self appendSubTitle:subtitle completion:nil];
        }
        if (buttonTitle) {
            [self appendButtonWithTitle:buttonTitle completion:nil];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _initialize];
    }
    return self;
}

- (void)appendIcon:(NSString *)icon completion:(void (^)(UILabel *iconLabel, CGFloat *offset, CGFloat *height))completion;{
    UILabel *iconLabel = [self defaultIconLabel];
    iconLabel.text = icon;
    
    [self _appendView:iconLabel offset:0 completion:(id)completion];
}

- (void)appendImage:(UIImage *)image completion:(void (^)(UIImageView *imageView, CGFloat *offset, CGFloat *height))completion;{
    UIImageView *imageView = [self defaultImageView];
    imageView.image = image;
    
    [self _appendView:imageView offset:10 completion:(id)completion];
}

- (void)appendTitle:(NSString *)title completion:(void (^)(UILabel *titleLabel, CGFloat *offset, CGFloat *height))completion;{
    UILabel *titleLabel = [self defaultTitleLabel];
    titleLabel.text = title;
    
    [self _appendView:titleLabel offset:9 completion:(id)completion];
}

- (void)appendSubTitle:(NSString *)subtitle completion:(void (^)(UILabel *subtitleLabel, CGFloat *offset, CGFloat *height))completion;{
    UILabel *subtitleLabel = [self defaultSubtitleLabel];
    subtitleLabel.text = subtitle;
    
    [self _appendView:subtitleLabel offset:4 completion:(id)completion];
}

- (void)appendButtonWithTitle:(NSString *)title completion:(void (^)(UIButton *button, CGFloat *offset, CGFloat *height))completion;{
    UIButton *button = [self defaultButton];
    [button setTitle:title forState:UIControlStateNormal];
    
    [self _appendView:button offset:10 completion:(id)completion];
}

- (void)appendView:(UIView *)view completion:(void (^)(UIView *view, CGFloat *offset, CGFloat *height))completion{
    [self _appendView:view offset:0 completion:completion];
}

- (void)_appendView:(UIView *)view offset:(CGFloat)offset completion:(void (^)(UIView *view, CGFloat *offset, CGFloat *height))completion{
    CGFloat contentHeight = 0;
    if (completion) {
        completion(view, &offset, &contentHeight);
    }
    view.emptyDataSetPlaceholderViewOffset = offset;
    view.emptyDataSetPlaceholderViewContentHeight = contentHeight;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [[self contentView] addSubview:view];
    [[self mutableItemViews] addObject:view];
    
    [self _updateItemViewslayout];
}

#pragma mark - accessor

- (void)setContentInsets:(UIEdgeInsets)contentInsets{
    _contentInsets = contentInsets;
    
    [self _updateContentViewLayout];
}

- (UILabel *)defaultIconLabel{
    UILabel *iconLabel = [UILabel new];
    iconLabel.textColor = [UIColor colorWithRed:0.f green:1.f blue:0.f alpha:1];
    iconLabel.textAlignment = NSTextAlignmentCenter;
    return iconLabel;
}

- (UIImageView *)defaultImageView{
    UIImageView *imageView = [UIImageView new];
    
    return imageView;
}

- (UILabel *)defaultTitleLabel{
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    return titleLabel;
}

- (UILabel *)defaultSubtitleLabel{
    UILabel *subtitleLabel = [UILabel new];
    subtitleLabel.font = [UIFont systemFontOfSize:14];
    subtitleLabel.textColor = [UIColor colorWithWhite:0 alpha:0.3];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    return subtitleLabel;
}

- (UIButton *)defaultButton{
    UIButton *button = [_EDEmptyDataSetPlaceholderViewButton new];
    button.userInteractionEnabled = NO;
    button.layer.borderWidth = 1.f;
    button.layer.cornerRadius = 4.f;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [[UIColor colorWithRed:0.f green:1.f blue:0.f alpha:1] CGColor];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor colorWithRed:0.f green:1.f blue:0.f alpha:1] forState:UIControlStateNormal];
    
    return button;
}

- (_EDOffsetView *)defaultOffsetView{
    _EDOffsetView *offsetView = [_EDOffsetView new];
    offsetView.userInteractionEnabled = NO;
    return offsetView;
}

- (UIView *)DZNEmptyDataSetView{
    UIView *superview = self;
    while (superview && ![superview isKindOfClass:NSClassFromString(@"DZNEmptyDataSetView")]){
        superview = [superview superview];
    };
    return superview;
}

#pragma mark - protected

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self _updateContentSize];
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    [self _updateContentSize];
}

#pragma mark - private

- (void)_initialize{
    
    self.mutableItemViews = [NSMutableArray array];
    
    self.contentView = [UIView new];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:[self contentView]];
    
    self.contentInsets = UIEdgeInsetsMake(CGFLOAT_MAX, CGFLOAT_MAX, CGFLOAT_MAX, CGFLOAT_MAX);
}

- (void)_updateContentViewLayout{
    NSMutableArray *constraints = [NSMutableArray array];
    if (self.contentInsets.top != CGFLOAT_MAX || self.contentInsets.bottom != CGFLOAT_MAX) {
        if (self.contentInsets.top != CGFLOAT_MAX) {
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:[self contentView] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.contentInsets.top];
            [constraints addObject:constraint];
        }
        if (self.contentInsets.bottom != CGFLOAT_MAX) {
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:[self contentView] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:self.contentInsets.bottom];
            [constraints addObject:constraint];
        }
    } else {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:[self contentView] attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [constraints addObject:constraint];
    }
    if (self.contentInsets.left != CGFLOAT_MAX || self.contentInsets.right != CGFLOAT_MAX) {
        if (self.contentInsets.left != CGFLOAT_MAX) {
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:[self contentView] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.contentInsets.left];
            [constraints addObject:constraint];
        }
        if (self.contentInsets.right != CGFLOAT_MAX) {
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:[self contentView] attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:self.contentInsets.right];
            [constraints addObject:constraint];
        }
    } else {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:[self contentView] attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [constraints addObject:constraint];
    }
    [self removeConstraints:[[self constraints] copy]];
    [self addConstraints:constraints];
}

- (void)_updateItemViewslayout{
    
    NSArray *itemViews = [[self mutableItemViews] copy];
    NSMutableArray *constraints = [NSMutableArray array];
    [itemViews enumerateObjectsUsingBlock:^(UIView *itemView, NSUInteger index, BOOL *stop) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        [constraints addObject:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        [constraints addObject:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [constraints addObject:constraint];
        
        CGFloat offset = [itemView emptyDataSetPlaceholderViewOffset];
        if (!index) {
            constraint = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:offset];
            [constraints addObject:constraint];
        } else {
            UIView *previousItemView = itemViews[index - 1];
            constraint = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:previousItemView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:offset];
            [constraints addObject:constraint];
        }
        if (index == [itemViews count] - 1) {
            constraint = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
            [constraints addObject:constraint];
        }
        
        if (itemView.emptyDataSetPlaceholderViewContentHeight > 0) {
            constraint = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:itemView.emptyDataSetPlaceholderViewContentHeight];
            [itemView addConstraint:constraint];
        }
    }];
    
    [[self contentView] removeConstraints:[[[self contentView] constraints] copy]];
    [[self contentView] addConstraints:constraints];
}

- (void)_updateContentSize{
    UIView *DZNEmptyDataSetView = [self DZNEmptyDataSetView];
    if (DZNEmptyDataSetView && ![self translatesAutoresizingMaskIntoConstraints]) {
        CGSize size = [[self DZNEmptyDataSetView] bounds].size;
        NSMutableArray *constraints = [NSMutableArray array];
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:size.height];
        [constraints addObject:constraint];
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:size.width];
        [constraints addObject:constraint];
        
        [self addConstraints:constraints];
    }
}

@end
