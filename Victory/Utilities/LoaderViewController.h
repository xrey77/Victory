//
//  LoaderViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/22/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoaderViewController : UIViewController
@property(strong, nonatomic) UIView *loadingView;
@property(strong, nonatomic) UILabel *loadingPercent;
@property(strong, nonatomic) UILabel *loadingStatus;
@property(strong, nonatomic) UIProgressView *loading;
@property(strong, nonatomic) NSTimer *timer;

@end

NS_ASSUME_NONNULL_END
