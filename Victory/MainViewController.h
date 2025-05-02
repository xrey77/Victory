//
//  ViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/8/25.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) UISwipeGestureRecognizer *right;
@property(strong, nonatomic) UISwipeGestureRecognizer *left;

//@property(strong, nonatomic)UITextField *txtUsername;
//@property(strong, nonatomic)UITextField *txtPassword;
//@property(strong, nonatomic)UIButton *btnSignin;
//@property(strong, nonatomic)UIView *msgView;
//@property(strong, nonatomic)UIView *topView;
//@property(strong, nonatomic)UIImageView *close;
//@property(strong, nonatomic)UIImageView *btnIcon;
//@property(strong, nonatomic)UILabel *lblalert;
//@property(strong, nonatomic)NSString *alertMessage;
//@property(strong, nonatomic)UIView *mainView;
@property(nonatomic, assign) BOOL barItem;
@property(nonatomic, assign) BOOL showMenu;
@property (nonatomic, strong) NSMutableArray *menuData;

@property(strong, nonatomic)UIView *sideView;
@property(strong, nonatomic)UIView *headerView;
@property(strong, nonatomic)UIImageView *userPic;
@property(strong, nonatomic)UILabel *userName;
@property(strong, nonatomic)UILabel *userEmail;
@property(strong, nonatomic)IBOutlet UITableView *sidebar;

@property (strong, nonatomic) IBOutlet UIToolbar *bottomBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *booksItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *settingsItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *pastorsItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *vgroupImage;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *tightImage;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *videoImage;

@property (strong, nonatomic) IBOutlet NSArray *bottomBarArray;

@property (strong, nonatomic) IBOutlet UIButton *settingsButton;
@property (strong, nonatomic) IBOutlet UIImage *settingsImage;
@property(assign, nonatomic)BOOL isLoggedin;
@property(strong, nonatomic)NSString *strUserid;
@property(strong, nonatomic)NSString *strUsername;
@property(strong, nonatomic)NSString *strUseremail;
@property(nonatomic, assign)NSString *strUserpicture;
@property(strong, nonatomic)NSString *strToken;




@end

