//
//  SignupViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/8/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignupViewController : UIViewController

@property(strong, nonatomic)UITextField* txtFname;
@property(strong, nonatomic)UITextField* txtLname;
@property(strong, nonatomic)UITextField* txtEmail;
@property(strong, nonatomic)UITextField* txtMobile;
@property(strong, nonatomic)UITextField* txtUsername;
@property(strong, nonatomic)UITextField* txtPassword;
@property(strong, nonatomic)UITextField* txtConfPassword;
@property(strong, nonatomic)UIView *formView;
@property(strong, nonatomic)UIView *msgView;
@property(strong, nonatomic)UIView *topView;
@property(nonatomic, copy)NSString *statusMsg;
//@property(strong, nonatomic)UIActivityIndicatorView *indicator;
@property(nonatomic, strong)IBOutlet UIActivityIndicatorView * activityIndicator;


@end

NS_ASSUME_NONNULL_END
