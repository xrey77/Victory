//
//  BookDetailsViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/19/25.
///Users/reynald/My-Programs/XCode12.4/OBJETIVE-C/Victory/Victory/ViewControllers/BookDetailsViewController.h

#import "BookDetailsViewController.h"


@interface BookDetailsViewController ()

@end

@implementation BookDetailsViewController
@synthesize bookId,dtlimgBook,lblBooknameTitle,dtlBookname,lblAuthorTitle,dtlAuthor,lblDescriptionTitle;
@synthesize dtlDescription,lblPriceTitle,dtlPrice,btnCart,btnCancel,bookData;
@synthesize strBookname, strBookprice, strBookauthor, strBookdescripiton, strBookImage;
@synthesize loading,loadingStatus,loadingPercent,loadingView;

- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.backgroundColor = UIColor.orangeColor;
        self->bookData = [[NSMutableArray alloc] init];

        [self fetchDetails];
    

//        [self progress];

    
        int64_t delay = 1.0; // In seconds
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^(void){

            self->dtlimgBook = [[UIImageView alloc]initWithFrame:CGRectMake(80,90,200, 200)];
            NSString *url = @"http://127.0.0.1:9000/assets/ccfbooks/";
            url = [url stringByAppendingString:self->strBookImage];
            NSURL *nsUrl = [NSURL URLWithString:url];
            NSData *data = [NSData dataWithContentsOfURL:nsUrl];
            self->dtlimgBook.image = [UIImage imageWithData:data];
            self->dtlimgBook.userInteractionEnabled = true;
            self->dtlimgBook.clipsToBounds = true;
            self->dtlimgBook.layer.cornerRadius = 10;
            [self.view addSubview:self->dtlimgBook];

            self->lblBooknameTitle = [[UILabel alloc] initWithFrame:CGRectMake(40,290,300,50)];
            self->lblBooknameTitle.text = @"BOOK NAME";
            self->lblBooknameTitle.textColor = UIColor.blueColor;
            self->lblBooknameTitle.textAlignment = NSTextAlignmentCenter;
            self->lblBooknameTitle.font = [UIFont fontWithName:@"Arial" size:20];
            [self.view addSubview:self->lblBooknameTitle];

            self->dtlBookname = [[UILabel alloc] initWithFrame:CGRectMake(40,315,300,50)];
            self->dtlBookname.text = self->strBookname;
            self->dtlBookname.textColor = UIColor.whiteColor;
            self->dtlBookname.textAlignment = NSTextAlignmentCenter;
            self->dtlBookname.font = [UIFont fontWithName:@"Arial" size:20];
            [self.view addSubview:self->dtlBookname];

            self->lblAuthorTitle = [[UILabel alloc] initWithFrame:CGRectMake(40,350,300,50)];
            self->lblAuthorTitle.text = @"AUTHOR";
            self->lblAuthorTitle.textColor = UIColor.blueColor;
            self->lblAuthorTitle.textAlignment = NSTextAlignmentCenter;
            self->lblAuthorTitle.font = [UIFont fontWithName:@"Arial" size:20];
            [self.view addSubview:self->lblAuthorTitle];

            self->dtlAuthor = [[UILabel alloc] initWithFrame:CGRectMake(40,375,300,50)];
            self->dtlAuthor.text = self->strBookauthor;
            self->dtlAuthor.textColor = UIColor.whiteColor;
            self->dtlAuthor.textAlignment = NSTextAlignmentCenter;
            self->dtlAuthor.font = [UIFont fontWithName:@"Arial" size:20];
            [self.view addSubview:self->dtlAuthor];

            self->lblDescriptionTitle = [[UILabel alloc] initWithFrame:CGRectMake(40,420,300,50)];
            self->lblDescriptionTitle.text = @"BOOK DESCRIPTION";
            self->lblDescriptionTitle.textColor = UIColor.blueColor;
            self->lblDescriptionTitle.textAlignment = NSTextAlignmentCenter;
            self->lblDescriptionTitle.font = [UIFont fontWithName:@"Arial" size:20];
            [self.view addSubview:self->lblDescriptionTitle];

            self->dtlDescription = [[UILabel alloc] initWithFrame:CGRectMake(40,460,300,50)];
            self->dtlDescription.text = self->strBookdescripiton;
            self->dtlDescription.textColor = UIColor.whiteColor;
            self->dtlDescription.textAlignment = NSTextAlignmentCenter;
            self->dtlDescription.font = [UIFont fontWithName:@"Arial" size:20];
            self->dtlDescription.lineBreakMode = NSLineBreakByWordWrapping;
            self->dtlDescription.numberOfLines = 5;
            [self.view addSubview:self->dtlDescription];

            self->lblPriceTitle = [[UILabel alloc] initWithFrame:CGRectMake(40,530,300,50)];
            self->lblPriceTitle.text = @"SELLING PRICE";
            self->lblPriceTitle.textColor = UIColor.blueColor;
            self->lblPriceTitle.textAlignment = NSTextAlignmentCenter;
            self->lblPriceTitle.font = [UIFont fontWithName:@"Arial" size:20];
            [self.view addSubview:self->lblPriceTitle];

            self->dtlPrice = [[UILabel alloc] initWithFrame:CGRectMake(40,560,300,50)];
            self->dtlPrice.text = [@"$" stringByAppendingString:self->strBookprice];
            self->dtlPrice.textColor = UIColor.whiteColor;
            self->dtlPrice.textAlignment = NSTextAlignmentCenter;
            self->dtlPrice.font = [UIFont fontWithName:@"Arial" size:20];
            [self.view addSubview:self->dtlPrice];

            self->btnCart = [[UIImageView alloc]initWithFrame:CGRectMake(100,610,150, 40)];
            self->btnCart.image = [UIImage imageNamed:@"cart"];
            self->btnCart.userInteractionEnabled = true;
            UITapGestureRecognizer *tapCartGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(cartImageTapped:)];
            tapCartGesture.numberOfTapsRequired = 1;
            [tapCartGesture setDelegate:nil];
            [self->btnCart addGestureRecognizer:tapCartGesture];
            [self.view addSubview:self->btnCart];

//            self->btnCancel = [[UIImageView alloc]initWithFrame:CGRectMake(190,610,120, 40)];
//            self->btnCancel.image = [UIImage imageNamed:@"cancel"];
//            self->btnCancel.userInteractionEnabled = true;
//            UITapGestureRecognizer *tapCancelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(cancelImageTapped:)];
//            tapCancelGesture.numberOfTapsRequired = 1;
//            [tapCancelGesture setDelegate:nil];
//            [self->btnCancel addGestureRecognizer:tapCancelGesture];
//            [self.view addSubview:self->btnCancel];
            
        });

}

-(void)cartImageTapped:(id)sender {
    NSLog(@"%s","ADD TO CART");
}

-(void)fetchDetails {

    NSString *url = @"http://127.0.0.1:9000/getccfbooks/";
    NSString *inID = [NSString stringWithFormat: @"%ld", bookId];  ///CONVERT INTEGER BOOK ID TO STRING BOOK ID
    NSString *urlx = [url stringByAppendingString:inID];

    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlx]];

    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {

        NSDictionary *apiData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->loading setProgress:0.1 animated:YES];
            self->strBookname = apiData[@"Bookname"];
            self->strBookauthor =  apiData[@"Bookauthor"];
            self->strBookprice = apiData[@"Bookprice"];
            self->strBookdescripiton = apiData[@"Bookdescription"];
            self->strBookImage = apiData[@"Bookimage"];
        });
        
  

    }];
    [dataTask resume];
}

-(void)progress {
    [self->loadingView setNeedsDisplay];

    
    [self.view bringSubviewToFront:self->loadingView];
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
    
    dispatch_async(dispatch_get_main_queue(), ^{

        [self->loading setProgress:0.1 animated:YES];



        self->_timer = [NSTimer scheduledTimerWithTimeInterval:0.02 repeats:true block:^(NSTimer * _Nonnull timer) {
            static int count = 0;
            count++;
            if(count <= 100) {
                self->loading.progress = count/100.0f;
                self->loadingPercent.text = [NSString stringWithFormat:@"%d %%", count];
            }
            else {
                [self.loadingView removeFromSuperview];
            }

        }];

        
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self->loading.progress = 0.0;
}
@end
