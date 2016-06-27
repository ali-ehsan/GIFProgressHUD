//
//  GIFProgressHUD.m
//  GIFProgressHUD
//
//  Created by Ali Ehsan on 6/18/16.
//  Copyright © 2016 TkXel. All rights reserved.
//

#import "GIFProgressHUD.h"
#import "GIFImageView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static CGFloat const kDefaultGIFImageSize = 80;

@interface GIFProgressHUD ()

// Properties
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailTitleLabel;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) GIFImageView *gifImageView;

// View Creation Methods
+ (GIFProgressHUD *)gifViewWithGIFImageView:(GIFImageView *)gifImageView title:(NSString *)title detailTitle:(NSString *)detailTitle;
- (void)setupContainerView;

// Show and Hide Methods
- (void)hideWithAnimation:(BOOL)animation;
- (void)addToView:(UIView *)view animated:(BOOL)animated;


// Find Methods
+ (GIFProgressHUD *)HUDForView:(UIView *)view;
+ (NSArray *)allHUDsForView:(UIView *)view;

// Setup Methods
- (void)makeLabels;
- (void)makeTitleLabel;
- (void)makeDetailTitleLabel;
- (void)makeContainerView;

@end

@implementation GIFProgressHUD

#pragma mark - Initialize Methods

- (id)init {
    self = [super init];
    if (self) {
        
        // Default values.
        _gifImageSizeRelativeToScreenResolution = NO;
        _containerColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        _containerCornerRadius = 5.0;
        _scaleFactor = 1.0;
        _resolutionScaleFactor = 0.25;
        _animationDuration = 0.3;
        _minimumPadding = 8;
        _minimumMargin = 16;
        _paddingBetweenGIFImageAndTitle = 8;
        _paddingBetweenTitleAndDetailTitle = 4;
        _titleFont = [UIFont systemFontOfSize:17];
        _titleColor = [UIColor whiteColor];
        _detailTitleFont = [UIFont systemFontOfSize:11];
        _detailTitleColor = [UIColor whiteColor];
        
        // Setup views.
        [self makeLabels];
        [self makeContainerView];
    }
    return self;
}

#pragma mark - Factory Methods

+ (GIFProgressHUD *)showHUDWithGIFName:(NSString *)gifImage addedToView:(UIView *)view animated:(BOOL)animated {
    return [self showHUDWithGIFName:gifImage title:@"" detailTitle:@"" addedToView:view animated:animated];
}

+ (GIFProgressHUD *)showHUDWithGIFName:(NSString *)gifImage title:(NSString *)title addedToView:(UIView *)view animated:(BOOL)animated {
    return [self showHUDWithGIFName:gifImage title:title detailTitle:@"" addedToView:view animated:animated];
}

+ (GIFProgressHUD *)showHUDWithTitle:(NSString *)title addedToView:(UIView *)view animated:(BOOL)animated {
    return [self showHUDWithGIFName:nil title:title detailTitle:@"" addedToView:view animated:animated];
}

+ (GIFProgressHUD *)showHUDWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle addedToView:(UIView *)view animated:(BOOL)animated {
    return [self showHUDWithGIFName:nil title:title detailTitle:detailTitle addedToView:view animated:animated];
}

+ (GIFProgressHUD *)showHUDWithGIFName:(NSString *)gifImage title:(NSString *)title detailTitle:(NSString *)detailTitle addedToView:(UIView *)view animated:(BOOL)animated {
    
    // Get gif image.
    GIFImageView *gifImageView = [GIFImageView gifImageViewWithGIFName:gifImage];
    
    // Get gif view.
    GIFProgressHUD *gifProgressHUD = [GIFProgressHUD gifViewWithGIFImageView:gifImageView title:title detailTitle:detailTitle];
    
    // Add gif to view with animation (if any).
    [gifProgressHUD addToView:view animated:animated];
    
    [gifProgressHUD layoutIfNeeded];
    
    return gifProgressHUD;
}

#pragma mark - View Creation Methods

+ (GIFProgressHUD *)gifViewWithGIFImageView:(GIFImageView *)gifImageView title:(NSString *)title detailTitle:(NSString *)detailTitle {
    
    // Make a GIF view.
    GIFProgressHUD *gifProgressHUD = [[GIFProgressHUD alloc] init];
    
    // Setting up the transparent view.
    gifProgressHUD.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    // Setup hud.
    [gifProgressHUD setupHUDWithImageView:gifImageView title:title detailTitle:detailTitle];
    
    return gifProgressHUD;
}

- (void)setupHUDWithImageView:(GIFImageView *)gifImageView title:(NSString *)title detailTitle:(NSString *)detailTitle {
    
    // Set gif view as property.
    _gifImageView = gifImageView;
    _titleText = title;
    _titleLabel.text = title;
    _detailTitleText = detailTitle;
    _detailTitleLabel.text = detailTitle;
    
    // Assign the calculated frame to gif image.
    [self setupContainerView];
}

- (void)setupContainerView {
    CGFloat totalPaddingAndMargin = (_minimumMargin * 2) + (_minimumPadding * 2);
    
    // Set the size of gif image.
    CGFloat gifImageWidth = 0;
    CGFloat gifImageHeight = 0;
    if(_gifImageView) {
        if (_gifImageSizeRelativeToScreenResolution) {
            gifImageWidth = (CGRectGetWidth(self.frame) - totalPaddingAndMargin) * _resolutionScaleFactor;
            gifImageHeight = CGRectGetHeight(_gifImageView.frame) / CGRectGetWidth(_gifImageView.frame) * gifImageWidth;
        }
        else {
            gifImageWidth = MIN(kDefaultGIFImageSize * _scaleFactor, CGRectGetWidth(self.frame) - totalPaddingAndMargin);
            gifImageHeight = CGRectGetHeight(_gifImageView.frame) / CGRectGetWidth(_gifImageView.frame) * gifImageWidth;
        }
    }
    
    // Adjust the frame of title label.
    _titleLabel.frame = CGRectZero;
    [_titleLabel sizeToFit];
    
    // Set the size of title label.
    CGFloat titleLabelWidth = MIN(CGRectGetWidth(_titleLabel.frame), CGRectGetWidth(self.frame) - totalPaddingAndMargin);
    CGFloat titleLabelHeight = CGRectGetHeight(_titleLabel.frame);
    
    // Adjust the frame of title label.
    _detailTitleLabel.frame = CGRectZero;
    [_detailTitleLabel sizeToFit];
    
    // Set the size of title label.
    CGFloat detailTitleLabelWidth = MIN(CGRectGetWidth(_detailTitleLabel.frame), CGRectGetWidth(self.frame) - totalPaddingAndMargin);
    CGFloat detailTitleLabelHeight = CGRectGetHeight(_detailTitleLabel.frame);
    
    CGFloat containerViewWidth = MAX(MAX(gifImageWidth, titleLabelWidth), detailTitleLabelWidth) + (_minimumPadding * 2);
    CGFloat containerViewHeight = gifImageHeight + titleLabelHeight + detailTitleLabelHeight + (_minimumPadding * 2);
    
    // Calculate the current paddings.
    CGFloat currentPaddingBetweenGIFImageAndTitle = ([_titleText isEqualToString:@""] || _titleText == nil || !_gifImageView) ? 0 : _paddingBetweenGIFImageAndTitle;
    
    CGFloat currentPaddingBetweenTitleAndDetailTitle = ([_detailTitleText isEqualToString:@""] || _detailTitleText == nil || [_titleText isEqualToString:@""] || _titleText == nil) ? 0 : _paddingBetweenTitleAndDetailTitle;
    
    containerViewHeight = containerViewHeight + currentPaddingBetweenGIFImageAndTitle;
    containerViewHeight = containerViewHeight + currentPaddingBetweenTitleAndDetailTitle;
    
    // Centralize the container view in GIF progress hud.
    CGFloat containerViewXPosition = (CGRectGetWidth(self.frame)/2.0) - (containerViewWidth/2.0);
    CGFloat containerViewYPosition = (CGRectGetHeight(self.frame)/2.0) - (containerViewHeight/2.0);
    
    // Position the GIF image in container view.
    CGFloat gifImageXPosition = (containerViewWidth/2.0) - (gifImageWidth/2.0);
    CGFloat gifImageYPosition = _minimumPadding;
    
    // Position of title label in container view.
    CGFloat titleLabelXPosition = (containerViewWidth/2.0) - (titleLabelWidth/2.0);
    CGFloat titleLabelYPosition = gifImageHeight + _minimumPadding + currentPaddingBetweenGIFImageAndTitle;
    
    // Position of detail title label in container view.
    CGFloat detailTitleLabelXPosition = (containerViewWidth/2.0) - (detailTitleLabelWidth/2.0);
    CGFloat detailTitleLabelYPosition = titleLabelYPosition + titleLabelHeight + currentPaddingBetweenTitleAndDetailTitle;
    
    // Create Frames
    CGRect containerViewFrame = CGRectMake(containerViewXPosition, containerViewYPosition, containerViewWidth, containerViewHeight);
    CGRect gifImageFrame = CGRectMake(gifImageXPosition, gifImageYPosition, gifImageWidth, gifImageHeight);
    CGRect titleLabelFrame = CGRectMake(titleLabelXPosition, titleLabelYPosition, titleLabelWidth, titleLabelHeight);
    CGRect detailTitleLabelFrame = CGRectMake(detailTitleLabelXPosition, detailTitleLabelYPosition, detailTitleLabelWidth, detailTitleLabelHeight);
    
    // Assign Frames.
    _gifImageView.frame = gifImageFrame;
    _titleLabel.frame = titleLabelFrame;
    _containerView.frame = containerViewFrame;
    _detailTitleLabel.frame = detailTitleLabelFrame;
    
    // Remove previous views.
    [self removeAllSubViewsFromView:_containerView];
    
    // Add subviews.
    [_containerView addSubview:_gifImageView];
    [_containerView addSubview:_titleLabel];
    [_containerView addSubview:_detailTitleLabel];
    [self addSubview:_containerView];
}

#pragma mark - Show And Hide Methods

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    GIFProgressHUD *gifProgressHUD = [self HUDForView:view];
    if (gifProgressHUD) {
        // Remove gif from view with animation (if any).
        [gifProgressHUD hideWithAnimation:animated];
        return true;
    }
    return false;
}


+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated {
    NSArray *allHUDs = [self allHUDsForView:view];
    for (GIFProgressHUD *hud in allHUDs) {
        [hud hideWithAnimation:animated];
    }
    return [allHUDs count];
}

- (void)hideWithAnimation:(BOOL)animation {
    CGFloat duration = animation ? _animationDuration : 0.0;
    
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)addToView:(UIView *)view animated:(BOOL)animated {
    CGFloat duration = animated ? _animationDuration : 0.0;
    
    self.alpha = 0.0;
    [view addSubview:self];
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1.0;
    } completion:nil];
}

- (void)removeAllSubViewsFromView:(UIView *)view {
    NSArray *viewsToRemove = [view subviews];
    for (UIView *subView in viewsToRemove) {
        [subView removeFromSuperview];
    }
}

#pragma mark - Find Methods

+ (GIFProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (GIFProgressHUD *)subview;
        }
    }
    return nil;
}

+ (NSArray *)allHUDsForView:(UIView *)view {
    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subviews = view.subviews;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:self]) {
            [huds addObject:aView];
        }
    }
    return [NSArray arrayWithArray:huds];
}

#pragma mark - Setup Methods

- (void)makeLabels {
    [self makeTitleLabel];
    [self makeDetailTitleLabel];
}

- (void)makeTitleLabel {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = _titleFont;
    _titleLabel.textColor = _titleColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
}

- (void)makeDetailTitleLabel {
    _detailTitleLabel = [[UILabel alloc] init];
    _detailTitleLabel.font = _detailTitleFont;
    _detailTitleLabel.textColor = _detailTitleColor;
    _detailTitleLabel.numberOfLines = 0;
    _detailTitleLabel.textAlignment = NSTextAlignmentCenter;
    _detailTitleLabel.backgroundColor = [UIColor clearColor];
}

- (void)makeContainerView {
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = _containerColor;
    _containerView.layer.cornerRadius = _containerCornerRadius;
}

#pragma mark - Setter Methods

- (void)setGifImageSizeRelativeToScreenResolution:(BOOL)gifImageSizeRelativeToScreenResolution {
    _gifImageSizeRelativeToScreenResolution = gifImageSizeRelativeToScreenResolution;
    [self setupContainerView];
}

- (void)setContainerColor:(UIColor *)containerColor {
    _containerColor = containerColor;
    _containerView.backgroundColor = _containerColor;
}

- (void)setContainerCornerRadius:(CGFloat)containerCornerRadius {
    _containerCornerRadius = containerCornerRadius;
    _containerView.layer.cornerRadius = containerCornerRadius;
}

- (void)setPaddingBetweenGIFImageAndTitle:(CGFloat)paddingBetweenGIFImageAndTitle {
    _paddingBetweenGIFImageAndTitle = paddingBetweenGIFImageAndTitle;
    [self setupContainerView];
}

- (void)setPaddingBetweenTitleAndDetailTitle:(CGFloat)paddingBetweenTitleAndDetailTitle {
    _paddingBetweenTitleAndDetailTitle = paddingBetweenTitleAndDetailTitle;
    [self setupContainerView];
}

- (void)setScaleFactor:(CGFloat)scaleFactor {
    _scaleFactor = scaleFactor;
    [self setupContainerView];
}

- (void)setResolutionScaleFactor:(CGFloat)resolutionScaleFactor {
    _resolutionScaleFactor = resolutionScaleFactor;
    [self setupContainerView];
}

- (void)setAnimationDuration:(CGFloat)animationDuration {
    _animationDuration = animationDuration;
}

- (void)setMinimumPadding:(CGFloat)minimumPadding {
    _minimumPadding = minimumPadding;
    [self setupContainerView];
}

- (void)setMinimumMargin:(CGFloat)minimumMargin {
    _minimumMargin = minimumMargin;
    [self setupContainerView];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    _titleLabel.font = titleFont;
    [self setupContainerView];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    _titleLabel.text = titleText;
    [self setupContainerView];
}

- (void)setDetailTitleFont:(UIFont *)detailTitleFont {
    _detailTitleFont = detailTitleFont;
    _detailTitleLabel.font = detailTitleFont;
    [self setupContainerView];
}

- (void)setDetailTitleColor:(UIColor *)detailTitleColor {
    _detailTitleColor = detailTitleColor;
    _detailTitleLabel.textColor = detailTitleColor;
}

- (void)setDetailTitleText:(NSString *)detailTitleText {
    _detailTitleText = detailTitleText;
    _detailTitleLabel.text = detailTitleText;
    [self setupContainerView];
}

@end
