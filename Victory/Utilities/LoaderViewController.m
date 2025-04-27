///Users/reynald/My-Programs/XCode12.4/OBJETIVE-C/Victory/Victory/Utilities/LoaderViewController.h
//  LoaderViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/22/25.
//

#import "LoaderViewController.h"

@interface LoaderViewController ()

@end

@implementation LoaderViewController
@synthesize loading,loadingStatus,loadingPercent,loadingView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self->loadingView = [[UIView alloc]initWithFrame:CGRectMake(40, 300, 300, 120)];
    self->loadingView.backgroundColor = UIColor.yellowColor;
    self->loadingView.layer.masksToBounds = true;
    self->loadingView.layer.borderWidth = 1;
    self->loadingView.clipsToBounds = true;
    self->loadingView.layer.cornerRadius = 25;
    self->loadingView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;

    [self.view addSubview:self->loadingView];

    
    self->loadingPercent = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 270, 50)];
    self->loadingPercent.text = @"0%";
    self->loadingPercent.textColor = UIColor.blackColor;
    self->loadingPercent.textAlignment = NSTextAlignmentCenter;
    [self->loadingView addSubview:self->loadingPercent];

    self->loading = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 55, 270, 50)];
    self->loading.backgroundColor = UIColor.greenColor;
    [self->loadingView addSubview:self->loading];

    self->loadingStatus = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, 270, 50)];
    self->loadingStatus.text = @"please wait . . .";
    self->loadingStatus.textColor = UIColor.blackColor;
    self->loadingStatus.textAlignment = NSTextAlignmentCenter;
    [self->loadingView addSubview:self->loadingStatus];
    self->_timer = [NSTimer scheduledTimerWithTimeInterval:0.05 repeats:true block:^(NSTimer * _Nonnull timer) {
        static int count = 0;
        count++;
        if(count <= 100) {
            self->loading.progress = count/100.0f;
            self->loadingPercent.text = [NSString stringWithFormat:@"%d %%", count];
        }
    }];

}


@end
