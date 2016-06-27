//
//  GIFProgressHUD.h
//  GIFProgressHUD
//
//  Created by Ali Ehsan on 6/18/16.
//  Copyright © 2016 TkXel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GIFProgressHUD : UIView

/**
 * Setting this property to YES will adjust the size of GIF according to the screen resolution based on the resolutionScaleFactor property.
 
 * Setting this property to NO will keep a fix size of GIF image despite the resolution.
 
 * This propery is NO by default.
 */
@property (nonatomic) BOOL gifImageSizeRelativeToScreenResolution;

/**
 * Container color of gif view.
 */
@property (nonatomic) UIColor *containerColor;

/**
 * Corner radius of gif view.
 */
@property (nonatomic) CGFloat containerCornerRadius;

/**
 * Padding between gif image and title.
 */
@property (nonatomic) CGFloat paddingBetweenGIFImageAndTitle;

/**
 * Padding between title and detail title.
 */
@property (nonatomic) CGFloat paddingBetweenTitleAndDetailTitle;

/**
 * Scale factor for GIF image.
 
 * @note This property will only take effect of the 'gifImageSizeRelativeToScreenResolution' property is set to NO.
 */
@property (nonatomic) CGFloat scaleFactor;

/**
 * Scale factor for GIF image based on the size of the screen. This value ranges from 0 to 1.
 
 * @note This property will only take effect of the 'gifImageSizeRelativeToScreenResolution' property is set to YES.
 */
@property (nonatomic) CGFloat resolutionScaleFactor;

/**
 * Hide and show animation for progress HUD.
 */
@property (nonatomic) CGFloat animationDuration;

/**
 * The container view minimum padding.
 */
@property (nonatomic) CGFloat minimumPadding;

/**
 * The container view minimum left/right margin.
 */
@property (nonatomic) CGFloat minimumMargin;

/**
 * The font for the title label.
 */
@property (strong, nonatomic) UIFont *titleFont;

/**
 * The color for the title label.
 */
@property (strong, nonatomic) UIColor *titleColor;

/**
 * The text for the title label.
 */
@property (strong, nonatomic) NSString *titleText;

/**
 * The font for the detail title label.
 */
@property (strong, nonatomic) UIFont *detailTitleFont;

/**
 * The color for the detail title label.
 */
@property (strong, nonatomic) UIColor *detailTitleColor;

/**
 * The text for the detail title label.
 */
@property (strong, nonatomic) NSString *detailTitleText;

/**
 * Show GIF image only.
 */
+ (GIFProgressHUD *)showHUDWithGIFName:(NSString *)gifImage addedToView:(UIView *)view animated:(BOOL)animated;

/**
 * Show GIF image with title.
 */
+ (GIFProgressHUD *)showHUDWithGIFName:(NSString *)gifImage title:(NSString *)title addedToView:(UIView *)view animated:(BOOL)animated;

/**
 * Show GIF image with title and detail title.
 */
+ (GIFProgressHUD *)showHUDWithGIFName:(NSString *)gifImage title:(NSString *)title detailTitle:(NSString *)detailTitle addedToView:(UIView *)view animated:(BOOL)animated;

/**
 * Show title only.
 */
+ (GIFProgressHUD *)showHUDWithTitle:(NSString *)title addedToView:(UIView *)view animated:(BOOL)animated;

/**
 * Show title and detail title.
 */
+ (GIFProgressHUD *)showHUDWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle addedToView:(UIView *)view animated:(BOOL)animated;

/**
 * Hide the HUD.
 */
- (void)hideWithAnimation:(BOOL)animation;

/**
 * Hide top level HUD for a certain view.
 */
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;

/**
 * Hide all HUDs for a certain view.
 */
+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;

@end
