//
//  VideoDtlsViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/26/25.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoDtlsViewController : UIViewController <WKUIDelegate>


@property (strong, nonatomic) IBOutlet WKWebView *youtube;
@property (nonatomic, assign) NSInteger videoId;
@property(strong, nonatomic) WKWebView *youTube;
@property(strong, nonatomic) WKWebViewConfiguration *theConfiguration;
@property(strong, nonatomic) UIButton *btnPlay;
@property(strong, nonatomic) UIImageView *btnClose;
@property(strong, nonatomic) NSString *strLink;

@end

NS_ASSUME_NONNULL_END
