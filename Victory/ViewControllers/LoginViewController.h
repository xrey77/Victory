//
//  LoginViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 5/1/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property(strong, nonatomic)UIView *mainView;
@property(strong, nonatomic)UIView *msgView;
@property(strong, nonatomic)UIView *topView;
@property(strong, nonatomic)UIImageView *close;
@property(strong, nonatomic)UIImageView *userIcon;
@property(strong, nonatomic)UITextField *txtUsername;
@property(strong, nonatomic)UITextField *txtPassword;
@property(strong, nonatomic)UIButton *btnSignin;
@property(strong, nonatomic)UIImageView *btnIcon;
@property(strong, nonatomic)UILabel *lblalert;
@property(strong, nonatomic)NSString *alertMessage;
@property(strong, nonatomic)UIView *forgotView;
@property(strong, nonatomic)UIButton *forgotBtn;
@property(nonatomic, assign) BOOL isErrMsg;
@property(nonatomic, copy)NSString *statusMsg;
@property(nonatomic, copy)NSString *statusCode;
@property(nonatomic, copy)NSString *userFullname;
@property(nonatomic, copy)NSString *userEmailadd;
@property(nonatomic, copy)NSString *userPicture;
@property(nonatomic, copy)NSString *token;
@property(nonatomic, copy)NSString *userId;
@property(nonatomic, assign)BOOL isLoggedin;

@end

NS_ASSUME_NONNULL_END
