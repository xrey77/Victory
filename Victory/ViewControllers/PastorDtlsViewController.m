//
//  PastorDtlsViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/23/25.
//

#import "PastorDtlsViewController.h"

@interface PastorDtlsViewController ()

@end

@implementation PastorDtlsViewController
@synthesize pastorName, pastorBranch, pastorImage, pastorID,strPastorname,strPastorbranch,strPastorimage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchPastor];
    int64_t delay = 1.0; // In seconds
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self setupDetails];
    });
    
}

-(void)setupDetails {
    NSString *url = @"http://127.0.0.1:9000/assets/victory/";
    url = [url stringByAppendingString:self->strPastorimage];
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:nsUrl];
    self->pastorImage = [[UIImageView alloc] initWithFrame:CGRectMake(90, 80, 180, 180)];

    self->pastorImage.layer.masksToBounds = true;
    self->pastorImage.layer.borderWidth = 1;
    self->pastorImage.clipsToBounds = true;
    self->pastorImage.layer.cornerRadius = 25;
    
    self->pastorImage.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;

    self->pastorImage.image = [UIImage imageWithData:data];
    [self.view addSubview:self->pastorImage];
    
    self->pastorName = [[UILabel alloc] initWithFrame:CGRectMake(30, 250, 300, 50)];
    self->pastorName.text = self->strPastorname;
    self->pastorName.textColor = UIColor.blackColor;
    self->pastorName.textAlignment = NSTextAlignmentCenter;
    self->pastorName.font =  [UIFont fontWithName:@"Arial" size:18];
    [self.view addSubview:self->pastorName];
    
    
    self->pastorBranch = [[UILabel alloc] initWithFrame:CGRectMake(40, 300, 300, 400)];
    self->pastorBranch.text = self->strPastorbranch;
    self->pastorBranch.textColor = UIColor.blackColor;
    self->pastorBranch.font =  [UIFont fontWithName:@"Arial" size:20];
    self->pastorBranch.textAlignment = NSTextAlignmentJustified; ///NSTextAlignmentLeft;
    self->pastorName.lineBreakMode =  NSLineBreakByWordWrapping;
    self->pastorBranch.numberOfLines = 20;
    [self->pastorBranch sizeToFit];
    [self.view addSubview:self->pastorBranch];

}

-(void)fetchPastor {
    NSString *url = @"http://127.0.0.1:9000/getvictorypastorbyid/";
    NSString *inID = [NSString stringWithFormat: @"%ld", self->pastorID];  ///CONVERT INTEGER BOOK ID TO STRING BOOK ID
    NSString *urlx = [url stringByAppendingString:inID];

    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlx]];

    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {

        NSDictionary *apiData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self->strPastorname = apiData[@"pastorname"];
            self->strPastorbranch =  apiData[@"pastorbranch"];
            self->strPastorimage = apiData[@"pastorimage"];
        });
        
  

    }];
    [dataTask resume];
}
@end
