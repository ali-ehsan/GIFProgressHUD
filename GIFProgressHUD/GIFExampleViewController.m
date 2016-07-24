//
//  GIFExampleViewController.h
//  GIFProgressHUD
//
//  Created by Ali Ehsan on 6/18/16.
//  Copyright © 2016 TkXel. All rights reserved.
//

#import "GIFExampleViewController.h"
#import "GIFProgressHUD.h"

@interface GIFExampleViewController ()

- (IBAction)hudWithGIFSelected:(UIButton *)sender;

- (IBAction)hudWithGIFAndTitleSelected:(UIButton *)sender;

- (IBAction)hudWithGIFAndTitleAndDetailTitleSelected:(UIButton *)sender;

- (IBAction)hudWithGIFWithProgressExampleSelected:(UIButton *)sender;

- (IBAction)customHUDSelected:(UIButton *)sender;

- (IBAction)justLabelSelected:(UIButton *)sender;

- (IBAction)labelAndDetailLabelSelected:(UIButton *)sender;

@end

@implementation GIFExampleViewController

#pragma mark - View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Wait Methods

- (void)wait {
    sleep(3);
}

#pragma mark - Action Methods

- (IBAction)hudWithGIFSelected:(UIButton *)sender {
    
    GIFProgressHUD *hud = [GIFProgressHUD showHUDWithGIFName:@"gears" addedToView:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self wait];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideWithAnimation:YES];
        });
    });
}

- (IBAction)hudWithGIFAndTitleSelected:(UIButton *)sender {
    GIFProgressHUD *hud = [GIFProgressHUD showHUDWithGIFName:@"gears" title:@"Loading..." addedToView:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self wait];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideWithAnimation:YES];
        });
    });
}

- (IBAction)hudWithGIFAndTitleAndDetailTitleSelected:(UIButton *)sender {
    GIFProgressHUD *hud = [GIFProgressHUD showHUDWithGIFName:@"gears" title:@"Loading..." detailTitle:@"Please wait.\n Thanks for your patience." addedToView:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self wait];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideWithAnimation:YES];
        });
    });
}

- (IBAction)hudWithGIFWithProgressExampleSelected:(UIButton *)sender {
    GIFProgressHUD *hud = [GIFProgressHUD showHUDWithGIFName:@"gears" title:@"Loading..." detailTitle:@"Please wait\n (0/100)." addedToView:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        for (NSInteger i = 1; i <= 100; i++) {
            [NSThread sleepForTimeInterval:0.05];
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.detailTitleText = [NSString stringWithFormat:@"Please wait\n (%ld/100)", (long)i];
            });
        }
        [NSThread sleepForTimeInterval:0.2];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideWithAnimation:YES];
        });
    });
}

- (IBAction)customHUDSelected:(UIButton *)sender {
    GIFProgressHUD *hud = [GIFProgressHUD showHUDWithGIFName:@"gears" title:@"Loading..." detailTitle:@"Please wait.\n Thanks for your patience." addedToView:self.view animated:YES];
    hud.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    hud.containerColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5];
    hud.containerCornerRadius = 10;
    hud.scaleFactor = 2.0;
    hud.minimumPadding = 16;
    hud.titleColor = [UIColor redColor];
    hud.detailTitleColor = [UIColor greenColor];
    hud.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    hud.detailTitleFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self wait];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideWithAnimation:YES];
        });
    });
    
}

- (IBAction)justLabelSelected:(UIButton *)sender {
    GIFProgressHUD *hud = [GIFProgressHUD showHUDWithTitle:@"Hey!" addedToView:self.view animated:NO];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self wait];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideWithAnimation:YES];
        });
    });
}

- (IBAction)labelAndDetailLabelSelected:(UIButton *)sender {
    GIFProgressHUD *hud = [GIFProgressHUD showHUDWithTitle:@"Hey!" detailTitle:@"How are you?" addedToView:self.view animated:NO];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self wait];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideWithAnimation:YES];
        });
    });
}
@end
