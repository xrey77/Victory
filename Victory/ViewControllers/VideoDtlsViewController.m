//
//  VideoDtlsViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/26/25.
//

#import "VideoDtlsViewController.h"

@interface VideoDtlsViewController ()

@end

@implementation VideoDtlsViewController
@synthesize youtube, videoId,strLink;
@synthesize youTube,btnPlay,theConfiguration,btnClose;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIDevice currentDevice] setValue: [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeLeft] forKey:@"orientation"];
    [self fetchVideoID:self->videoId];
}

-(void)viewVideoDetails:(NSString*)dtl {
    
    self->youTube.allowsBackForwardNavigationGestures = true;
     
    theConfiguration = [[WKWebViewConfiguration alloc] init];
    theConfiguration.allowsInlineMediaPlayback = true;
    theConfiguration.mediaTypesRequiringUserActionForPlayback = false;
    theConfiguration.allowsPictureInPictureMediaPlayback = true;
    theConfiguration.allowsAirPlayForMediaPlayback = true;
    self->youTube = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    self->youTube.layer.backgroundColor = UIColor.blackColor.CGColor;
    self->youTube.backgroundColor = UIColor.blackColor;
    [self->youTube setPageZoom:1.1];
    [self.view addSubview:youTube];
    [self->youTube setMediaType:dtl];

    NSURL *nsurl=[NSURL URLWithString:dtl];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self->youTube loadRequest:nsrequest];
}

-(void)webViewDidClose:(WKWebView *)webView {
    [self viewDidLayoutSubviews];
    [self->youTube setHidden:YES];
    self->youTube.hidden = YES;
    [self->youTube removeFromSuperview];
    self->youTube = nil;
}

- (void)setNeedsUpdateOfScreenEdgesDeferringSystemGestures {
    self->youtube.allowsBackForwardNavigationGestures = NO;
    self->youtube.multipleTouchEnabled = false;
}

-(void)fetchVideoID:(NSInteger)idno {
    
    NSString *url = @"http://127.0.0.1:9000/getvictoryservicesbyId/";
    NSString *inID = [NSString stringWithFormat: @"%ld", idno];
    NSString *urlx = [url stringByAppendingString:inID];
    
    [[NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:urlx] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self viewVideoDetails:dic[@"servicelink"]];
        });

        
    }] resume];
        
}


@end
