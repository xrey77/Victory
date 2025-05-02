//
//  LoginViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 5/1/25.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize msgView, mainView, topView, close,userIcon,txtUsername,txtPassword,btnSignin,btnIcon,lblalert,alertMessage;
@synthesize forgotBtn,forgotView,isErrMsg,statusCode,statusMsg,userId,userPicture,userEmailadd,userFullname;
@synthesize token,isLoggedin;

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"Sign-in to you account.";

    isErrMsg = false;
    //ALERT MESSAGE BOX
    msgView = [[UIView alloc] init];
    [self.view addSubview:msgView];
    msgView.backgroundColor = UIColor.clearColor;
     
    // Centering view by calculating the frame
    CGFloat mainViewCenterX = self.view.frame.size.width / 2;
    CGFloat mainViewCenterY = self.view.frame.size.height / 2;
    CGFloat width = 350;
    CGFloat height = 350;

    CGFloat x = mainViewCenterX -  width / 2;
    CGFloat y = (mainViewCenterY) - height / 2;
    msgView.frame = CGRectMake(x, y, width, height);

    //MAIN TO ROUNDER CORNER
    msgView.backgroundColor = UIColor.systemBlueColor;
    msgView.layer.borderColor = UIColor.systemGreenColor.CGColor;
    msgView.layer.masksToBounds = true;
    msgView.layer.borderWidth = 1;
    msgView.clipsToBounds = true;
    msgView.layer.cornerRadius = 25;
    msgView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    
    //layerMaxXMaxYCorner
    [self.view addSubview:msgView];

    //SUB TOP ROUNDED CORNER
    topView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,350,50)];
    topView.backgroundColor = UIColor.systemGrayColor;
    topView.layer.borderColor = UIColor.systemRedColor.CGColor;
    topView.layer.masksToBounds = true;
    topView.layer.borderWidth = 1;
    topView.clipsToBounds = true;
    topView.layer.cornerRadius = 25;
    topView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [msgView addSubview:topView];

    //TOP ALERT CAPTION
    UILabel *lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(20,0,350,50)];
    lblMessage.text = @"Sign-In";
    lblMessage.textColor = UIColor.whiteColor;
    lblMessage.backgroundColor = UIColor.clearColor;
    lblMessage.textAlignment = NSTextAlignmentLeft;
    lblMessage.font = [UIFont fontWithName:@"Arial" size:22];
    [msgView addSubview: lblMessage];

    //CLOSE X-BUTTON
    close = [[UIImageView alloc]initWithFrame:CGRectMake(300,10,30, 30)];
    close.image = [UIImage systemImageNamed:@"multiply.square"];
    close.userInteractionEnabled = true;
    UITapGestureRecognizer *tapCloseGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(closeSignin:)];
    tapCloseGesture.numberOfTapsRequired = 1;
    [tapCloseGesture setDelegate:nil];
    [close addGestureRecognizer:tapCloseGesture];
    close.backgroundColor = UIColor.clearColor;
    close.tintColor = UIColor.whiteColor;
    [msgView addSubview:close];
    
    //USER ICON
    userIcon = [[UIImageView alloc]initWithFrame:CGRectMake(140,60,70, 70)];
    userIcon.image = [UIImage systemImageNamed:@"lock.rotation.open"];
    userIcon.userInteractionEnabled = true;
    userIcon.backgroundColor = UIColor.clearColor;
    userIcon.tintColor = UIColor.whiteColor;
    userIcon.tintColor = UIColor.yellowColor;
    userIcon.clipsToBounds = true;
    userIcon.layer.cornerRadius = 35;
    [msgView addSubview:userIcon];

    ///USERNAME
    txtUsername = [[UITextField alloc] initWithFrame:CGRectMake(50, 140, 250, 40)];
    txtUsername.borderStyle = UITextBorderStyleRoundedRect;
    txtUsername.returnKeyType = UIReturnKeyDone;
    txtUsername.placeholder = @"enter your Username";
    txtUsername.autocorrectionType = false;
    txtUsername.autocapitalizationType = false;
    [msgView addSubview:txtUsername];
    
    ///PASSWORD
    txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(50, 190, 250, 40)];
    txtPassword.borderStyle = UITextBorderStyleRoundedRect;
    txtPassword.returnKeyType = UIReturnKeyDone;
    txtPassword.secureTextEntry = false;
    txtPassword.placeholder = @"enter your Password";
    txtPassword.autocorrectionType = false;
    txtPassword.autocapitalizationType = false;
    txtPassword.secureTextEntry = true;
    [msgView addSubview:txtPassword];
    
    ///SIGNIN BUTTON
    btnSignin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSignin addTarget:self action:@selector(didSigninbuttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnSignin setFrame:CGRectMake(105, 240, 150, 40)];
    [btnSignin setTitle:@"sign-in" forState:UIControlStateNormal];
    [btnSignin setExclusiveTouch:YES];
    btnSignin.tintColor = UIColor.whiteColor;
    btnSignin.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
    btnSignin.backgroundColor = UIColor.orangeColor;
    btnSignin.layer.cornerRadius = 25;
    [msgView addSubview:btnSignin];
    
    //ICON INSIDE BUTTON
    btnIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20,10,30, 30)];
    btnIcon.image = [UIImage systemImageNamed:@"hand.draw"];
    btnIcon.userInteractionEnabled = true;
    userIcon.backgroundColor = UIColor.clearColor;
    btnIcon.tintColor = UIColor.whiteColor;
    [btnSignin addSubview:btnIcon];

    forgotBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [forgotBtn addTarget:self action:@selector(didForgotbuttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [forgotBtn setFrame:CGRectMake(10, 300, 160, 40)];
    [forgotBtn setTitle:@"Forgot password?" forState:UIControlStateNormal];
    [forgotBtn setExclusiveTouch:true];
    forgotBtn.tintColor = UIColor.whiteColor;
    forgotBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [msgView addSubview:forgotBtn];
    
    //SLIDE FROM TOP
    [self->msgView setFrame:(CGRectMake(x, -350,350,350))];
    [UIView animateWithDuration: 1.0 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
             animations:^{

                self->msgView.frame = CGRectMake(self->msgView.frame.origin.x,
                                                 +(self->msgView.bounds.size.height-160),
                                                 self->msgView.frame.size.width,
                                                 self->msgView.frame.size.height);

             }
             completion:^(BOOL finished){
                [self->txtUsername becomeFirstResponder];
             }];

    
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:true];

}

///SIGN-IN BUTTON====================
- (void)didSigninbuttonTapped: (id)sender {
    isErrMsg = true;
    if(txtUsername.text.length == 0) {
        [self sendAlertMessage:@"Please enter your correct User Name."];
        return;
    } else if(txtPassword.text.length == 0) {
        [self sendAlertMessage:@"Please enter your correct Password."];
        return;
    }
    
    self->txtUsername.enabled = false;   ///DISABLE USERNAME TEXTFIELD
    self->txtPassword.enabled = false;   ///DISABLE PASSWORD TEXTFIELD
    [self postLogin];                    ///EXECUTE POST REQUEST
    
    ///DISPATCH LOGIN WHILE GIVING TIME FOR THE API RESPONSE
    int64_t delay = 2.0; // In seconds
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self sendAlertMessage:self->statusMsg];
        if ([self->statusCode  isEqual: @"200"]) {
            NSUserDefaults *newUser = [NSUserDefaults standardUserDefaults];
            [newUser setBool:true forKey:@"isUserLoggedIn"];
            [newUser setValue:self->userId forKey:@"USERID"];
            [newUser setValue:self->userFullname forKey:@"USERNAME"];
            [newUser setValue:self->userEmailadd forKey:@"USEREMAIL"];
            [newUser setValue:self->userPicture forKey:@"USERPIC"]; // self->userPicture
            [newUser setValue:self->token forKey:@"TOKEN"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self closeSignin:nil];
        }
        self->txtUsername.enabled = true; ///ENABLE USERNAME TEXTFIELD
        self->txtPassword.enabled = true; ///ENABLE PASSWORD TEXTFIELD

    });
}

///CLOSE USER LOGIN VIEW
- (void)closeSignin: (id)sender {
    [UIView animateWithDuration: 1.0 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
             animations:^{
        
                self->msgView.frame = CGRectMake(self->msgView.frame.origin.x,
                                                 -(self->msgView.bounds.size.height+450),
                                                 self->msgView.frame.size.width,
                                                 self->msgView.frame.size.height);

             }
             completion:^(BOOL finished){

                if ([self->statusCode  isEqual: @"200"]) {
                    self->isLoggedin = true;
                }
             }];
                    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)postLogin {
    NSString *target = @"http://127.0.0.1:9000/user/login";

    NSString *url = [NSString stringWithFormat:@"%@", target];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSDictionary *jsonBodyDict = @{@"username":txtUsername.text, @"password": txtPassword.text };

    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:0 error:&error];

    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setURL:[NSURL URLWithString:url]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {

        NSDictionary *apiStatus = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self->statusCode = apiStatus[@"statuscode"];
            self->statusMsg = apiStatus[@"message"];
            self->userFullname = apiStatus[@"fullname"];
            self->userEmailadd = apiStatus[@"email"];
            self->userPicture = apiStatus[@"userpicture"];
            self->userId = apiStatus[@"id"];
            self->token = apiStatus[@"token"];
        });
    }] resume];
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

- (void)didForgotbuttonTapped:(id)sender {
    NSLog(@"%s","Forgot button tapped.");
}




@end
