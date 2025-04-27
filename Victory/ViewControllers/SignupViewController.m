//
//  SignupViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/8/25.
//
#import "SignupViewController.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface SignupViewController ()

@end

@implementation SignupViewController
@synthesize txtFname, txtLname,txtEmail,txtMobile,txtUsername,txtPassword,txtConfPassword,formView,msgView,topView,activityIndicator;

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
        NSMutableString *checkString = [textField.text mutableCopy];
        [checkString replaceCharactersInRange:range withString:string];
        textField.text = checkString;
        NSRange selectedRange = NSMakeRange(range.location + string.length, 0);
        UITextPosition* from = [textField positionFromPosition:textField.beginningOfDocument offset:selectedRange.location];
        UITextPosition* to = [textField positionFromPosition:from offset:selectedRange.length];
        textField.selectedTextRange = [textField textRangeFromPosition:from toPosition:to];
        [textField sendActionsForControlEvents:UIControlEventEditingChanged];
        return NO;
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    ///USER PICTURE
    formView.backgroundColor = UIColor.systemGreenColor;
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(150,20,100, 100)];
    imv.image = [UIImage imageNamed:@"rey"];
    [formView addSubview:imv];

    ///FIRST NAME
    txtFname = [[UITextField alloc] initWithFrame:CGRectMake(50, 150, 300, 40)];
    txtFname.borderStyle = UITextBorderStyleRoundedRect;
    txtFname.returnKeyType = UIReturnKeyDone;
    txtFname.placeholder = @"enter your First Name";
    txtFname.autocorrectionType = false;
    txtFname.autocapitalizationType = false;
    txtFname.enablesReturnKeyAutomatically = true;
    [formView addSubview:txtFname];

    ///LAST NAME
    txtLname = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, 300, 40)];
    txtLname.borderStyle = UITextBorderStyleRoundedRect;
    txtLname.returnKeyType = UIReturnKeyDone;
    txtLname.placeholder = @"enter your Last Name";
    txtLname.autocorrectionType = false;
    txtLname.autocapitalizationType = false;
    [formView addSubview:txtLname];

    ///EMAIL ADDRESS
    txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(50, 250, 300, 40)];
    txtEmail.borderStyle = UITextBorderStyleRoundedRect;
    txtEmail.returnKeyType = UIReturnKeyDone;
    txtEmail.placeholder = @"enter your Email Address";
    txtEmail.autocorrectionType = false;
    txtEmail.autocapitalizationType = false;

    [formView addSubview:txtEmail];

    ///MOBILE NO.
    txtMobile = [[UITextField alloc] initWithFrame:CGRectMake(50, 300, 300, 40)];
    txtMobile.borderStyle = UITextBorderStyleRoundedRect;
    txtMobile.returnKeyType = UIReturnKeyDone;
    txtMobile.placeholder = @"enter your Mobile No.";
    txtMobile.autocorrectionType = false;
    txtMobile.autocapitalizationType = false;
    [formView addSubview:txtMobile];

    ///USERNAME
    txtUsername = [[UITextField alloc] initWithFrame:CGRectMake(50, 350, 300, 40)];
    txtUsername.borderStyle = UITextBorderStyleRoundedRect;
    txtUsername.returnKeyType = UIReturnKeyDone;
    txtUsername.placeholder = @"enter your Username";
    txtUsername.autocorrectionType = false;
    txtUsername.autocapitalizationType = false;

    [formView addSubview:txtUsername];

    ///PASSWORD
    txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(50, 400, 300, 40)];
    txtPassword.borderStyle = UITextBorderStyleRoundedRect;
    txtPassword.returnKeyType = UIReturnKeyDone;
    txtPassword.secureTextEntry = false;
    txtPassword.placeholder = @"enter your Password";
    txtPassword.autocorrectionType = false;
    txtPassword.autocapitalizationType = false;

    [formView addSubview:txtPassword];

    ///CONFIRM PASSWORD
    txtConfPassword = [[UITextField alloc] initWithFrame:CGRectMake(50, 450, 300, 40)];
    txtConfPassword.borderStyle = UITextBorderStyleRoundedRect;
    txtConfPassword.returnKeyType = UIReturnKeyDone;
    txtConfPassword.secureTextEntry = false;
    txtConfPassword.placeholder = @"confirm your Password";
    txtConfPassword.autocorrectionType = false;
//    txtConfPassword.isSecureTextEntry = false;
    txtConfPassword.autocapitalizationType = false;

    [formView addSubview:txtConfPassword];

    ///SAVE BUTTON
    UIButton *btnSave= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSave addTarget:self action:@selector(didSavebuttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnSave setFrame:CGRectMake(100, 500, 200, 50)];
    [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    [btnSave setExclusiveTouch:YES];
    btnSave.tintColor = UIColor.whiteColor;
    btnSave.titleLabel.font = [UIFont fontWithName:@"Arial" size:24];
    btnSave.backgroundColor = UIColor.blueColor;
    btnSave.layer.cornerRadius = 25;
    [formView addSubview:btnSave];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [txtFname becomeFirstResponder];
}

- (IBAction)didSavebuttonTapped:(id)sender {
    [self submitRegistration];
  }

- (IBAction)didMessageClosed:(id)sender {
    NSLog(@"%s","Closed Message.");
}

- (void) submitRegistration {
    if (self->txtFname.text.length == 0) {
        [self alertBox:@"Sorry!, First Name field is empty! please enter valid First Name."];
        return;
    } else if (self->txtLname.text.length == 0) {
        [self alertBox:@"Sorry!, Last Name field is empty! please enter valid Last Name."];
        return;;
    } else if (self->txtEmail.text.length == 0) {
        [self alertBox:@"Sorry!, Email Address field is empty! please enter valid Email Address."];
        return;
    } else if (self->txtMobile.text.length == 0) {
        [self alertBox:@"Sorry!, Mobile No. field is empty! please enter valid Mobile No."];
        return;
    } else if (self->txtUsername.text.length == 0) {
        [self alertBox:@"Sorry!, User Name field is empty! please enter valid User Name."];
        return;
    } else if (self->txtPassword.text.length == 0) {
        [self alertBox:@"Sorry!, Password field is empty! please enter valid Password."];
        return;
    } else if (self->txtConfPassword.text.length == 0) {
        [self alertBox:@"Sorry!, Password Confirmation field is empty! please confirm your Password."];
        return;
    }

    if (self->txtPassword.text != self->txtConfPassword.text) {
        [self alertBox:@"Sorry!, Password does not matched, please enter same password."];
        return;
    }
    [self progressBar];
    [self postRegistration];
    int64_t delay = 2.0; // In seconds
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self alertBox:self->_statusMsg];
    });
}

- (void)postRegistration {
    NSString *target = @"http://127.0.0.1:9000/user/register";

    NSString *url = [NSString stringWithFormat:@"%@", target];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSDictionary *jsonBodyDict = @{@"firstname":txtFname.text, @"lastname": txtLname.text, @"email": txtEmail.text, @"mobile": txtMobile.text, @"username": txtUsername.text, @"password": txtPassword.text};

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
            self->_statusMsg = apiStatus[@"message"];
        });
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

- (id)alertBox:(NSString *)msg {

    //ALERT MESSAGE BOX
    msgView = [[UIView alloc] init];
    [self.view addSubview:msgView];
    msgView.backgroundColor = UIColor.greenColor;
     
    // Centering view by calculating the frame
    CGFloat mainViewCenterX = self.view.frame.size.width / 2;
    CGFloat mainViewCenterY = self.view.frame.size.height / 2;
    CGFloat width = 300;
    CGFloat height = 200;

    CGFloat x = mainViewCenterX -  width / 2;
    CGFloat y = (mainViewCenterY + 237) - height / 2;
    msgView.frame = CGRectMake(x, y, width, height);

    //MAIN TO ROUNDER CORNER
    msgView.backgroundColor = UIColor.greenColor;
    msgView.layer.borderColor = UIColor.systemGreenColor.CGColor;
    msgView.layer.masksToBounds = true;
    msgView.layer.borderWidth = 1;
    msgView.clipsToBounds = true;
    msgView.layer.cornerRadius = 25;
    msgView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [self.view addSubview:msgView];

    //SUB TOP ROUNDED CORNER
    topView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,300,50)];
    topView.backgroundColor = UIColor.systemRedColor;
    topView.layer.borderColor = UIColor.systemRedColor.CGColor;
    topView.layer.masksToBounds = true;
    topView.layer.borderWidth = 1;
    topView.clipsToBounds = true;
    topView.layer.cornerRadius = 25;
    topView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [msgView addSubview:topView];

    //TOP ALERT CAPTION
    UILabel *lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(0,0,300,50)];
    lblMessage.text = @"Alert Message";
    lblMessage.textColor = UIColor.whiteColor;
    lblMessage.backgroundColor = UIColor.clearColor;
    lblMessage.textAlignment = NSTextAlignmentCenter;
    lblMessage.font = [UIFont fontWithName:@"Arial" size:24];
    [msgView addSubview: lblMessage];

    //CLOSE X-BUTTON
    UIImageView *close = [[UIImageView alloc]initWithFrame:CGRectMake(265,10,30, 30)];
    close.image = [UIImage systemImageNamed:@"multiply.square"];
    close.userInteractionEnabled = true;
    UITapGestureRecognizer *tapCloseGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(closeImageTapped:)];
    tapCloseGesture.numberOfTapsRequired = 1;
    [tapCloseGesture setDelegate:nil];
    [close addGestureRecognizer:tapCloseGesture];
    close.backgroundColor = UIColor.clearColor;
    close.tintColor = UIColor.whiteColor;
    [msgView addSubview:close];

    //ALERT MESSAGE
    UILabel *lblalert = [[UILabel alloc] initWithFrame:CGRectMake(10,80,280,50)];
    lblalert.text = msg;
    lblalert.textColor = UIColor.redColor;
    lblalert.numberOfLines = 2;
    lblalert.backgroundColor = UIColor.clearColor;
    lblalert.textAlignment = NSTextAlignmentCenter;
    lblalert.font = [UIFont fontWithName:@"Arial" size:14];
    [msgView addSubview: lblalert];
    
    [self->msgView setFrame:(CGRectMake(50,800,300,200))];
    [UIView animateWithDuration: 1.0 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
             animations:^{
        
                self->msgView.frame = CGRectMake(self->msgView.frame.origin.x,
                                                 -(self->msgView.bounds.size.height-740),
                                                 self->msgView.frame.size.width,
                                                 self->msgView.frame.size.height);

             }
             completion:^(BOOL finished){
//                [self->msgView setFrame:(CGRectMake(50,850,300,128))];
             }];

    
    
    
    
    return self;
    
}

- (void)closeImageTapped: (id)sender {
    [UIView animateWithDuration: 1.0 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
             animations:^{
        
                self->msgView.frame = CGRectMake(self->msgView.frame.origin.x,
                                                 +(self->msgView.bounds.size.height+450),
                                                 self->msgView.frame.size.width,
                                                 self->msgView.frame.size.height);

             }
             completion:^(BOOL finished){
                [self->msgView setFrame:(CGRectMake(50,850,300,128))];
             }];

    
}

-(void)progressBar {
//        CAShapeLayer* outsideShapeLayer = [[CAShapeLayer alloc] init];
//        outsideShapeLayer.fillColor = [[UIColor clearColor] CGColor];
//        outsideShapeLayer.frame = CGRectMake(100, 250, 200, 200);
//        outsideShapeLayer.path = [[UIBezierPath bezierPathWithOvalInRect:outsideShapeLayer.bounds] CGPath];
//        outsideShapeLayer.lineWidth = 80;
//        outsideShapeLayer.strokeColor = [[UIColor orangeColor] CGColor];
//        [self.view.layer addSublayer:outsideShapeLayer];
//
//        CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
//        shapeLayer.fillColor = [[UIColor clearColor] CGColor];
//        shapeLayer.frame = CGRectMake(102.5, 252.5, 195, 195);
//        shapeLayer.path = [[UIBezierPath bezierPathWithOvalInRect:shapeLayer.bounds] CGPath];
//        shapeLayer.lineWidth = 80;
//        shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
//        shapeLayer.strokeStart = 0;
//        shapeLayer.strokeEnd = 0.95f;
//        [self.view.layer addSublayer:shapeLayer];
    
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
//        lblWait.text = @"";

    }];
}


@end
