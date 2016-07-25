# GIFProgressHUD
GIFProgressHUD is a progress HUD with GIF for iOS. With a single line of code you can show or hide a GIF for progress. GIFProgressHUD also provide great customization for those who want something different from default.

# ScreenShots
<img src="https://www.dropbox.com/s/xyccqsq677s141m/progress1.png?dl=0&&raw=1" alt="Drawing" width="200" />
<img src="https://www.dropbox.com/s/sjxrj4iasnjz5s2/progress2.png?dl=0&&raw=1" alt="Drawing" width="200" />
<img src="https://www.dropbox.com/s/ttagjabtx7ohsf7/progress3.png?dl=0&&raw=1" alt="Drawing" width="200" />
<img src="https://www.dropbox.com/s/2aaaltc12nv7pif/progress4.png?dl=0&&raw=1" alt="Drawing" width="200" />
<img src="https://www.dropbox.com/s/c4ugugrnebi3niu/progress5.png?dl=0&&raw=1" alt="Drawing" width="200" />
<img src="https://www.dropbox.com/s/q9ym75o0ws536h1/progress6.png?dl=0&&raw=1" alt="Drawing" width="200" />
<img src="https://www.dropbox.com/s/5jh5nzv1oquf1dk/progress7.png?dl=0&&raw=1" alt="Drawing" width="200" />

# Installation

### CocoaPods (Recommended way)

1. Add the line to your Podfile `pod 'GIFProgressHUD'`
2. Run the command `pod install`
3. Use `#import <GIFProgressHUD.h>` wherever you need to use the library

### Manual Installation
1. Download the source code
2. Copy the classes `GIFImageView`, `GIFProgressHUD`, and `UIImage+GIFImage` classes to your project
3. Use `#import "GIFProgressHUD.h"` wherever you need to use the library

# Usage

### Show HUD

#### Show HUD only
```objective-c
[GIFProgressHUD showHUDWithGIFName:@"gears" addedToView:self.view animated:YES];
```

#### Show HUD with title
```objective-c
[GIFProgressHUD showHUDWithGIFName:@"gears" title:@"Loading..." addedToView:self.view animated:YES];
```

#### Show HUD with title and message
```objective-c
[GIFProgressHUD showHUDWithGIFName:@"gears" title:@"Loading..." detailTitle:@"Please wait.\n Thanks for your patience." addedToView:self.view animated:YES];
```

#### Show HUD with title and message
```objective-c
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
```

#### Just a title
```objective-c
[GIFProgressHUD showHUDWithTitle:@"Hey!" addedToView:self.view animated:YES];
```

#### Title and message
```objective-c
[GIFProgressHUD showHUDWithTitle:@"Hey!" detailTitle:@"How are you?" addedToView:self.view animated:YES];
```
### Hide HUD

#### Hide top HUD for a specific view
```objective-c
[GIFProgressHUD hideHUDForView:self.view animated:YES];
```

#### Hide all HUD for a specific view
```objective-c
[GIFProgressHUD hideAllHUDsForView:self.view animated:YES];
```

#### Hide specific HUD
```objective-c
[hud hideWithAnimation:YES];
```

# Code Inspirations

* MBProgressHUD (https://github.com/jdg/MBProgressHUD)
* uiimage-from-animated-gif (https://github.com/mayoff/uiimage-from-animated-gif)
