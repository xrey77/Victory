//
//  ProfileViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/13/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
    @property(nonatomic, copy)NSString *token;
    @property(nonatomic, copy)NSString *userId;

    @property(strong, nonatomic)IBOutlet UITextField *txtFirstname;
    @property(strong, nonatomic)IBOutlet UITextField *txtLastname;
    @property(strong, nonatomic)IBOutlet UITextField *txtEmailadd;
    @property(strong, nonatomic)IBOutlet UITextField *txtMobileno;
    @property(strong, nonatomic)IBOutlet UITextField *txtNewPassword;
    @property(strong, nonatomic)IBOutlet UIButton *btnSave;
    @property(strong, nonatomic)IBOutlet UILabel *lblSwitch;

    @property(nonatomic, copy)NSString *firstName;
    @property(nonatomic, copy)NSString *lastName;
    @property(nonatomic, copy)NSString *email;
    @property(nonatomic, copy)NSString *mobile;
    @property(strong, nonatomic) IBOutlet UISwitch *switchButton;

    @property(strong, nonatomic)UIView *MainChangeView;
    @property(strong, nonatomic)UIView *changeView;
    @property(strong, nonatomic)UIView *changeTop;
    @property(strong, nonatomic)UIButton *btnChange;
    @property(strong, nonatomic)UITextField *txtConfirmPassword;
    @property(strong, nonatomic)UIImageView *closeChange;
    @property(strong, nonatomic)NSString *userPicture;
    @property(nonatomic,copy)NSString *message;
    @property(strong, nonatomic)UIView *forgotView;
    @property(strong, nonatomic)UIButton *forgotBtn;
    @property(strong, nonatomic)UILabel *lblalert;
    @property(strong, nonatomic)UIView *msgView;

@end

NS_ASSUME_NONNULL_END
