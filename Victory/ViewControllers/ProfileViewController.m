//
//  ProfileViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/13/25.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize txtFirstname, txtLastname, txtEmailadd, txtMobileno, txtNewPassword, btnSave,switchButton, txtConfirmPassword,closeChange,MainChangeView, changeView,changeTop,btnChange, forgotView, forgotBtn, lblalert,msgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self profileData];
    [self checkToggle];
    
    [self changePasswordView];
    [MainChangeView setHidden:true];

    
}

-(void)profileData {
    ///USER PICTURE
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(130,100,150, 150)];
    img.image = [UIImage systemImageNamed:@"person.crop.circle"];
    [self.view addSubview:img];

    ///FIRST NAME
    txtFirstname = [[UITextField alloc] initWithFrame:CGRectMake(50, 270, 300, 40)];
    txtFirstname.borderStyle = UITextBorderStyleRoundedRect;
    txtFirstname.returnKeyType = UIReturnKeyDone;
    txtFirstname.autocorrectionType = false;
    txtFirstname.autocapitalizationType = false;
    txtFirstname.enablesReturnKeyAutomatically = true;
    [self.view addSubview:txtFirstname];

    ///LAST NAME
    txtLastname = [[UITextField alloc] initWithFrame:CGRectMake(50, 320, 300, 40)];
    txtLastname.borderStyle = UITextBorderStyleRoundedRect;
    txtLastname.returnKeyType = UIReturnKeyDone;
    txtLastname.autocorrectionType = false;
    txtLastname.autocapitalizationType = false;
    [self.view addSubview:txtLastname];

    ///EMAIL ADDRESS
    txtEmailadd = [[UITextField alloc] initWithFrame:CGRectMake(50, 370, 300, 40)];
    txtEmailadd.borderStyle = UITextBorderStyleRoundedRect;
    txtEmailadd.returnKeyType = UIReturnKeyDone;
    txtEmailadd.enabled = false;
    txtEmailadd.autocorrectionType = false;
    txtEmailadd.autocapitalizationType = false;
    [self.view addSubview:txtEmailadd];

    ///MOBILE NO.
    txtMobileno = [[UITextField alloc] initWithFrame:CGRectMake(50, 420, 300, 40)];
    txtMobileno.borderStyle = UITextBorderStyleRoundedRect;
    txtMobileno.returnKeyType = UIReturnKeyDone;
    txtMobileno.autocorrectionType = false;
    txtMobileno.autocapitalizationType = false;
    [self.view addSubview:txtMobileno];
    
    
    ///SAVE BUTTON
    UIButton *btnSave= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSave addTarget:self action:@selector(didSavebuttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnSave setFrame:CGRectMake(100, 515, 200, 50)];
    [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    [btnSave setExclusiveTouch:YES];
    btnSave.tintColor = UIColor.whiteColor;
    btnSave.titleLabel.font = [UIFont fontWithName:@"Arial" size:24];
    btnSave.backgroundColor = UIColor.blueColor;
    btnSave.layer.cornerRadius = 25;
    [self.view addSubview:btnSave];
    
    [self loadProfileData];
    [self progressBar];
    int64_t delay = 2.0; // In seconds
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        self->txtFirstname.text = self->_firstName;
        self->txtLastname.text = self->_lastName;
        self->txtEmailadd.text = self->_email;
        self->txtMobileno.text = self->_mobile;
        NSData* data = [[NSData alloc] initWithBase64EncodedString:self->_userPicture options:0];
        img.image = [UIImage imageWithData:data];

        
    });

}

-(IBAction)didSavebuttonTapped:(id)sender {
    NSLog(@"%s","save");
}

///GET REQUEST
-(void)loadProfileData {
    
    NSString *token = @"Bearer ";
    token = [token stringByAppendingString:self->_token];
    
    NSString *url = @"http://127.0.0.1:9000/getuser/";
    url = [url stringByAppendingString:self->_userId];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:token forHTTPHeaderField:@"Authorization"];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
//      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//      if(httpResponse.statusCode == 200)
//      {
//        NSError *parseError = nil;
//        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
//        NSLog(@"The response is - %@",responseDictionary);
//      }
//      else
//      {
//        NSLog(@"Error");
//      }
        
        NSDictionary *apiData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_firstName = apiData[@"firstname"];
            self->_lastName = apiData[@"lastname"];
            self->_email = apiData[@"email"];
            self->_mobile = apiData[@"mobile"];

        });

        
    }];
    [dataTask resume];
    
}


-(void)progressBar {
    // Create a view with a corner radius as the circle
    UIView* circle = [[UIView alloc] initWithFrame:CGRectMake(150, 280, 100, 100)];
    [circle.layer setCornerRadius:circle.frame.size.width / 2];
    [circle setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:circle];
    
    UILabel *lblWait = [[UILabel alloc] initWithFrame:CGRectMake(150,300,100,50)];
    lblWait.text = @"wait";
    lblWait.textColor = UIColor.whiteColor;
    lblWait.backgroundColor = UIColor.clearColor;
    lblWait.textAlignment = NSTextAlignmentCenter;
    lblWait.font = [UIFont fontWithName:@"Arial" size:24];
    [self.view addSubview:lblWait];
    
    [UIView animateWithDuration:5 animations:^{
        // Animate it to double the size
        const CGFloat scale = 2;
        [circle setTransform:CGAffineTransformMakeScale(scale, scale)];
        [circle setBackgroundColor:[UIColor clearColor]];

    }];
}

-(void)checkToggle {
    self->_lblSwitch = [[UILabel alloc] initWithFrame:CGRectMake(70,465,200,50)];
    self->_lblSwitch.text = @"Change Password?";
    self->_lblSwitch.textColor = UIColor.whiteColor;
    self->_lblSwitch.backgroundColor = UIColor.clearColor;
    self->_lblSwitch.textAlignment = NSTextAlignmentLeft;
    self->_lblSwitch.font = [UIFont fontWithName:@"Arial" size:20];
    [self.view addSubview:self->_lblSwitch];

    switchButton = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchButton addTarget: self action: @selector(didTapped:) forControlEvents: UIControlEventValueChanged];
    [switchButton setFrame:CGRectMake(270, 475, 150, 50)];
    switchButton.transform= CGAffineTransformMakeScale(1.5, 1.0);
    [self.view addSubview: switchButton];
}

- (IBAction) didTapped: (id) sender {
    UISwitch *onoff = (UISwitch *) sender;
    if (onoff.on) {
        [MainChangeView setHidden:false];
        return;
    } else {
        return;
    }
}


-(void)changePasswordView {
    [self.view bringSubviewToFront:MainChangeView];

    MainChangeView = [[UIView alloc] initWithFrame:CGRectMake(0,0,414, 736)];
    MainChangeView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:MainChangeView];
    
    [MainChangeView bringSubviewToFront:changeView];

    
    changeView = [[UIView alloc] initWithFrame:CGRectMake(30,475,350,260)];
    changeView.backgroundColor = UIColor.systemPurpleColor;
    changeView.layer.borderColor = UIColor.systemRedColor.CGColor;
    changeView.layer.masksToBounds = true;
    changeView.layer.borderWidth = 1;
    changeView.clipsToBounds = true;
    changeView.layer.cornerRadius = 25;
    changeView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [MainChangeView addSubview:changeView];

//    //SUB TOP ROUNDED CORNER
    changeTop = [[UILabel alloc] initWithFrame:CGRectMake(0,0,350,50)];
    changeTop.backgroundColor = UIColor.grayColor;
    changeTop.layer.borderColor = UIColor.systemRedColor.CGColor;
    changeTop.layer.masksToBounds = true;
    changeTop.layer.borderWidth = 1;
    changeTop.clipsToBounds = true;
    changeTop.layer.cornerRadius = 25;
    changeTop.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [changeView addSubview:changeTop];

    UILabel *lblChange = [[UILabel alloc] initWithFrame:CGRectMake(40,490,330,40)];
    lblChange.text = @"Change Password";
    lblChange.textColor = UIColor.whiteColor;
    lblChange.textAlignment = NSTextAlignmentCenter;
    lblChange.backgroundColor = UIColor.grayColor;
    lblChange.font = [UIFont fontWithName:@"Arial" size:22];
    [MainChangeView addSubview: lblChange];

    closeChange = [[UIImageView alloc]initWithFrame:CGRectMake(344,498,30, 30)];
    closeChange.image = [UIImage systemImageNamed:@"multiply.square"];
    closeChange.userInteractionEnabled = true;
    UITapGestureRecognizer *tapChangeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(closeChangePwd:)];
    tapChangeGesture.numberOfTapsRequired = 1;
    [tapChangeGesture setDelegate:nil];
    [closeChange addGestureRecognizer:tapChangeGesture];
    closeChange.backgroundColor = UIColor.clearColor;
    closeChange.tintColor = UIColor.whiteColor;
    [MainChangeView addSubview:closeChange];

    txtNewPassword = [[UITextField alloc] initWithFrame:CGRectMake(80, 560, 250, 40)];
    txtNewPassword.borderStyle = UITextBorderStyleRoundedRect;
    txtNewPassword.returnKeyType = UIReturnKeyDone;
    txtNewPassword.secureTextEntry = false;
    txtNewPassword.placeholder = @"enter your new Password";
    txtNewPassword.autocorrectionType = false;
    txtNewPassword.autocapitalizationType = false;
    [MainChangeView addSubview:txtNewPassword];

    txtConfirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(80, 610, 250, 40)];
    txtConfirmPassword.borderStyle = UITextBorderStyleRoundedRect;
    txtConfirmPassword.returnKeyType = UIReturnKeyDone;
    txtConfirmPassword.secureTextEntry = false;
    txtConfirmPassword.placeholder = @"Confirm your new Password";
    txtConfirmPassword.autocorrectionType = false;
    txtConfirmPassword.autocapitalizationType = false;
    [MainChangeView addSubview:txtConfirmPassword];

    btnChange = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnChange addTarget:self action:@selector(didChangebuttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnChange setFrame:CGRectMake(130, 660, 150, 40)];
    [btnChange setTitle:@"change" forState:UIControlStateNormal];
    [btnChange setExclusiveTouch:YES];
    btnChange.tintColor = UIColor.whiteColor;
    btnChange.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
    btnChange.backgroundColor = UIColor.systemPinkColor;
    btnChange.layer.cornerRadius = 25;
//    btnChange.layer.st
    [MainChangeView addSubview:btnChange];
}

-(void)didChangebuttonTapped:(id)sender {
    [self postChangePassword];
    int64_t delay = 2.0; // In seconds
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self sendAlertMessage:self->_message];
    });

  
}

-(void)closeChangePwd:(id)sender {
    [MainChangeView setHidden:true];
}


-(void)postChangePassword {
    if (txtNewPassword.text.length == 0) {
        txtNewPassword.borderStyle = UITextBorderStyleRoundedRect;
//        txtNewPassword.layer.borderColor = [UIColor colorWithRed:151.0/255.0f green:193.0/255.0f blue:252.0/255.0f alpha:1.0f].CGColor;
        txtNewPassword.layer.borderColor = [UIColor redColor].CGColor;
        txtNewPassword.layer.borderWidth = 3.0f;
        [self sendAlertMessage:@"Please enter New Password."];
        return;
    }
    txtNewPassword.layer.borderColor = [UIColor clearColor].CGColor;
    if (txtConfirmPassword.text.length == 0) {
        txtConfirmPassword.layer.borderColor = [UIColor redColor].CGColor;
        txtConfirmPassword.layer.borderWidth = 3.0f;
        [self sendAlertMessage:@"Please confirm New Password."];
        return;
    }
    txtConfirmPassword.layer.borderColor = [UIColor clearColor].CGColor;
    if (txtNewPassword.text != txtConfirmPassword.text) {
        txtNewPassword.layer.borderColor = [UIColor redColor].CGColor;
        txtNewPassword.layer.borderWidth = 3.0f;
        txtConfirmPassword.layer.borderColor = [UIColor redColor].CGColor;
        txtConfirmPassword.layer.borderWidth = 3.0f;
        [self sendAlertMessage:@"Password did not matched."];
        return;
    }
    txtNewPassword.layer.borderColor = [UIColor clearColor].CGColor;
    txtConfirmPassword.layer.borderColor = [UIColor clearColor].CGColor;
    
    ///PUT REQUEST
    NSString *token = @"Bearer ";
    token = [token stringByAppendingString:self->_token];
    
    NSString *url = @"http://127.0.0.1:9000/updatepwd/";
    url = [url stringByAppendingString:self->_userId];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSDictionary *jsonBodyDict = @{@"password":txtNewPassword.text };

    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:0 error:&error];

    [request setHTTPBody:postData];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:token forHTTPHeaderField:@"Authorization"];

    [request setURL:[NSURL URLWithString:url]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
        
        NSDictionary *apiStatus = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_message = apiStatus[@"message"];
        });
    }] resume];
    
    
    NSLog(@"%s","post...");
}

- (id)sendAlertMessage:(NSString *)msg {
    [self->msgView bringSubviewToFront:forgotView];
    forgotView = [[UILabel alloc] initWithFrame:CGRectMake(0,300,350,70)];
    forgotView.backgroundColor = UIColor.systemBlueColor;
    [msgView addSubview:forgotView];
    lblalert = [[UILabel alloc] initWithFrame:CGRectMake(10,280,330,50)];
    lblalert.text = msg;
    lblalert.textColor = UIColor.whiteColor;
    lblalert.numberOfLines = 2;
    lblalert.backgroundColor = UIColor.clearColor;
    lblalert.textAlignment = NSTextAlignmentCenter;
    lblalert.font = [UIFont fontWithName:@"Arial" size:16];
    [msgView addSubview: lblalert];
    [self->forgotView setFrame:(CGRectMake(0, 400, 350, 70))];
    [self->lblalert setFrame:CGRectMake(10,380,330,50)];

    [self slideUP];
    [self slideDown];
    
    return self;
}


-(void)slideDown {
    //SLIDE DOWN ALERT MESSAGE
    [UIView animateWithDuration: 3.0 delay: 3.0 options: UIViewAnimationOptionCurveEaseIn
             animations:^{
        
                self->forgotView.frame = CGRectMake(self->forgotView.frame.origin.x,
                                                 +(self->forgotView.bounds.size.height+350),
                                                 self->forgotView.frame.size.width,
                                                 self->forgotView.frame.size.height);

        self->lblalert.frame = CGRectMake(self->lblalert.frame.origin.x,
                                         +(self->lblalert.bounds.size.height+350),
                                         self->lblalert.frame.size.width,
                                         self->lblalert.frame.size.height);
        
             }
             completion:^(BOOL finished){
//                NSLog(@"%fi",self->forgotView.bounds.size.height);
             }];
}

-(void)slideUP {
    /// SLIDE UP ALERT MESSAGE
    [UIView animateWithDuration: 0.4 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
             animations:^{
        
                self->forgotView.frame = CGRectMake(self->forgotView.frame.origin.x,
                                                 -(self->forgotView.bounds.size.height-350),
                                                 self->forgotView.frame.size.width,
                                                 self->forgotView.frame.size.height);

        self->lblalert.frame = CGRectMake(self->lblalert.frame.origin.x,
                                         -(self->lblalert.bounds.size.height-350),
                                         self->lblalert.frame.size.width,
                                         self->lblalert.frame.size.height);
        
             }
             completion:^(BOOL finished){
//                NSLog(@"%fi",self->forgotView.bounds.size.height);
             }];

}

@end

/**
 
 [UIView animateWithDuration:duration
                   animations:^ {
                     // Do some hiding animation
                     // using CGAffineTransformMake. Ex:
                     [button setTransform:CGAffineTransformMake(1, 0, 0, 1, -120, 0)];
                   }
                   completion:^(BOOL finished) {
                     //isOpen = NO;
                   }];
 
 */
