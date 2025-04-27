//
//  ViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/8/25.
//

//#import <Network/Network.h>
#import "MainViewController.h"
#import "AboutusViewController.h"
#import "LocationViewController.h"
#import "VisionViewController.h"
#import "MissionViewController.h"
#import "WhoweareViewController.h"
#import "FindachurchViewController.h"
#import "NeedaprayerViewController.h"
#import "ResourcesViewController.h"
#import "GiveViewController.h"
#import "SignupViewController.h"
#import "ProfileViewController.h"
#import "BooksViewController.h"
#import "SettingsViewController.h"
#import "PastorsViewController.h"
#import "VgroupViewController.h"
#import "TightsViewController.h"
#import "BooksTableViewController.h"
#import "VideoTableViewController.h"

@interface MainViewController ()
@end

@implementation MainViewController

@synthesize txtUsername, txtPassword, btnSignin, msgView, topView, close, userIcon, lblalert, alertMessage, btnIcon, mainView, barItem, forgotView, isErrMsg, forgotBtn, showMenu, sideView, sidebar, menuData, headerView, userPic, userName, userEmail, isLoggedin;

@synthesize bottomBar, booksItem, settingsItem, pastorsItem, bottomBarArray, settingsButton,settingsImage,vgroupImage,tightImage,videoImage, left, right;

- (void)viewDidLoad {
    [super viewDidLoad];

    left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(helper:)];
    right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(helper:)];

    left.direction = UISwipeGestureRecognizerDirectionLeft;
    right.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:left];
    [self.view addGestureRecognizer:right];

    
    [self setImageBackground:@"victory"];  ///BACKGROUND SCREEN IMAGE
    barItem = false;
    isErrMsg = false;
    showMenu = false;
    sideView.hidden = true;
    [self bottomNavigation];

    [self sideMenu];

    
    ///DELATEGATE TABLE VIEW, REQUIREMENT FOR numberOfRowsInSection AND cellForRowAtIndexPath
    [sidebar setDelegate:self];
    [sidebar setDataSource:self];

    menuData = [NSMutableArray arrayWithObjects:@"c1", @"c2", @"c3", @"c4", @"c5", @"c6",
                @"c7", @"c8", @"c9", @"c10", @"c11", nil];

    [self->sideView setFrame:(CGRectMake(-300,30,299,865))];
    
    self.sidebar.backgroundColor=[UIColor systemTealColor];  ///REMOVE BOTTOM WHITE SPACE
    ///TOUCH MAIN VIEW TO CLOSE SIDE MENU
//    [self addGestureRecogniser:nil];
}

-(void)helper:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self->showMenu) {
            [self openMenu];
        } else {
            [self closeMenu];
        }

    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self->showMenu) {
            [self openMenu];
        } else {
            [self closeMenu];
        }

    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self->menuData.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [sidebar scrollToRowAtIndexPath:indexPath
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:YES];
    [sidebar setContentOffset:CGPointMake(0, ([menuData count]-10)*100) animated:YES];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor=[UIColor systemTealColor];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.textColor = UIColor.blackColor;
    cell.backgroundColor = UIColor.systemTealColor;
    UIImageView *iconImage = [[UIImageView alloc] init];
    switch (indexPath.row) {
      case 0: ///ABOUT US
        iconImage.image = [UIImage systemImageNamed:@"questionmark.circle"];
        [cell.contentView addSubview:iconImage];
        cell.imageView.image = iconImage.image;
        cell.imageView.tintColor = UIColor.redColor;
        cell.textLabel.text = @"About Us";
        break;
      case 1:  ///LOCATION
        iconImage.image = [UIImage systemImageNamed:@"mappin.circle"];
        [cell.contentView addSubview:iconImage];
        cell.imageView.image = iconImage.image;
        cell.imageView.tintColor = UIColor.purpleColor;
        cell.textLabel.text = @"Location";
        break;
      case 2:  ///VISION
        iconImage.image = [UIImage systemImageNamed:@"paperplane"];
        [cell.contentView addSubview:iconImage];
        cell.imageView.image = iconImage.image;
        cell.imageView.tintColor = UIColor.cyanColor;
        cell.textLabel.text = @"Vision";
        break;
      case 3:  ///MISSSION
        iconImage.image = [UIImage systemImageNamed:@"person.2"];
        [cell.contentView addSubview:iconImage];
        cell.imageView.image = iconImage.image;
        cell.imageView.tintColor = UIColor.systemBlueColor;
        cell.textLabel.text = @"Mission";
        break;
      case 4: ///WHO WE ARE
        iconImage.image = [UIImage systemImageNamed:@"folder.badge.person.crop"];
        [cell.contentView addSubview:iconImage];
        cell.imageView.image = iconImage.image;
        cell.imageView.tintColor = UIColor.brownColor;
        cell.textLabel.text = @"Who we are";
        break;
      case 5:  ///FIND A CHURCH
        iconImage.image = [UIImage systemImageNamed:@"plus.magnifyingglass"];
        [cell.contentView addSubview:iconImage];
        cell.imageView.image = iconImage.image;
        cell.imageView.tintColor = UIColor.whiteColor;
        cell.textLabel.text = @"Find a Church";
        break;
      case 6: ///NEED A PRAYER
        iconImage.image = [UIImage systemImageNamed:@"chevron.up"];
        [cell.contentView addSubview:iconImage];
        cell.imageView.image = iconImage.image;
        cell.imageView.tintColor = UIColor.greenColor;
        cell.textLabel.text = @"Need a Prayer";
        break;
      case 7: ///RESOURCES
        iconImage.image = [UIImage systemImageNamed:@"square.and.arrow.down.on.square"];
        [cell.contentView addSubview:iconImage];
        cell.imageView.image = iconImage.image;
        cell.imageView.tintColor = UIColor.magentaColor;
        cell.textLabel.text = @"Resources";
        break;
      case 8:  ///GIVE
        iconImage.image = [UIImage systemImageNamed:@"tray.and.arrow.down"];
        [cell.contentView addSubview:iconImage];
        cell.imageView.image = iconImage.image;
        cell.imageView.tintColor = UIColor.orangeColor;
        cell.textLabel.text = @"Give";
        break;
      case 9:  ///SIGN-UP  AND PROFILE
        if(self->isLoggedin == false) {
            iconImage.image = [UIImage systemImageNamed:@"lock.rotation.open"];
            [cell.contentView addSubview:iconImage];
            cell.imageView.image = iconImage.image;
            cell.imageView.tintColor = UIColor.orangeColor;
            cell.textLabel.text = @"Sign-Up";
        } else {
            iconImage.image = [UIImage systemImageNamed:@"rectangle.stack.badge.person.crop"];
            [cell.contentView addSubview:iconImage];
            cell.imageView.image = iconImage.image;
            cell.imageView.tintColor = UIColor.orangeColor;
            cell.textLabel.text = @"Profile";
        }
        break;
      case 10: ///SIGN-IN  AND SIGN-OUT
            if(self->isLoggedin == false) {
            iconImage.image = [UIImage systemImageNamed:@"lock.rotation.open"];
            [cell.contentView addSubview:iconImage];
            cell.imageView.image = iconImage.image;
            cell.imageView.tintColor = UIColor.yellowColor;
            cell.textLabel.text = @"Sign-In";
        } else {
            iconImage.image = [UIImage systemImageNamed:@"lock.circle"];
            [cell.contentView addSubview:iconImage];
            cell.imageView.image = iconImage.image;
            cell.imageView.tintColor = UIColor.yellowColor;
            cell.textLabel.text = @"Sign-Out";
        }
        break;
      default:
            break;
    }
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated: true];
    switch (indexPath.row) {
        case 0:
            [self navigateToAboutusController];
            break;
        case 1:
            [self navigateToLocationController];
            break;
        case 2:
            [self navigateToVisionController];
            break;
        case 3:
            [self navigateToMisionController];
            break;
        case 4:
            [self navigateToWhoweareController];
            break;
        case 5:
            [self navigateToFindachurchController];
            break;
        case 6:
            [self navigateToNeedaprayerController];
            break;
        case 7:
            [self navigateToResourcesController];
            break;
        case 8:
            [self navigateToGiveController];
            break;
        case 9:
            if(self->isLoggedin == false) {
                [self navigateToSignupController];
            } else {
                [self navigateToProfileController];
            }
            break;
        case 10:
            if(self->isLoggedin == false) {
                if (self->showMenu) {
                    [self openMenu];
                } else {
                    [self closeMenu];
                }

                [self logInView];
            } else {
                [self signOut];
            }
            break;
        default:
            break;
    }
}

-(void)signOut {
    if (self->showMenu) {
        [self openMenu];
    } else {
        [self closeMenu];
    }
    self->isLoggedin = false;
    [self->sidebar reloadData];

}


- (void)navigateToAboutusController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AboutusViewController *aboutusVC = (AboutusViewController *)[storyboard instantiateViewControllerWithIdentifier:@"aboutusVC"];
    [self.navigationController pushViewController:aboutusVC animated:YES];
}

- (void)navigateToLocationController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LocationViewController *locationVC = (LocationViewController *)[storyboard instantiateViewControllerWithIdentifier:@"locationVC"];
    locationVC.xcode = self->_token;
    [self.navigationController pushViewController:locationVC animated:YES];
}

- (void)navigateToVisionController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VisionViewController *visionVC = (VisionViewController *)[storyboard instantiateViewControllerWithIdentifier:@"visionVC"];
    [self.navigationController pushViewController:visionVC animated:YES];
}

- (void)navigateToMisionController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MissionViewController *missionVC = (MissionViewController *)[storyboard instantiateViewControllerWithIdentifier:@"missionVC"];
    [self.navigationController pushViewController:missionVC animated:YES];
}

- (void)navigateToWhoweareController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WhoweareViewController *whoweareVC = (WhoweareViewController *)[storyboard instantiateViewControllerWithIdentifier:@"whoweareVC"];
    [self.navigationController pushViewController:whoweareVC animated:YES];
}

- (void)navigateToFindachurchController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FindachurchViewController *findachurchVC = (FindachurchViewController *)[storyboard instantiateViewControllerWithIdentifier:@"findachurchVC"];
    [self.navigationController pushViewController:findachurchVC animated:YES];
}

- (void)navigateToNeedaprayerController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NeedaprayerViewController *needaprayerVC = (NeedaprayerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"needaprayerVC"];
    [self.navigationController pushViewController:needaprayerVC animated:YES];
}

- (void)navigateToResourcesController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ResourcesViewController *resourcesVC = (ResourcesViewController *)[storyboard instantiateViewControllerWithIdentifier:@"resourcesVC"];
    [self.navigationController pushViewController:resourcesVC animated:YES];
}

- (void)navigateToGiveController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GiveViewController *giveVC = (GiveViewController *)[storyboard instantiateViewControllerWithIdentifier:@"giveVC"];
    [self.navigationController pushViewController:giveVC animated:YES];
}

- (void)navigateToSignupController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignupViewController *signupVC = (SignupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"signupVC"];
    [self.navigationController pushViewController:signupVC animated:YES];
}

- (void)navigateToProfileController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProfileViewController *profileVC = (ProfileViewController *)[storyboard instantiateViewControllerWithIdentifier:@"profileVC"];
    profileVC.userId = self->_userId;
    profileVC.token = self->_token;
    profileVC.userPicture = self->_userPicture;
    [self.navigationController pushViewController:profileVC animated:YES];
}



- (void)logInView {
        
    barItem = true;  ///DISABLE BAR ITEM MENU
    ///LOGIN VIEW SHIELD
    mainView = [[UIView alloc] init];
    [self.view addSubview:mainView];
    mainView.backgroundColor = UIColor.clearColor;
    mainView.frame = CGRectMake(0, -200, self.view.frame.size.width, self.view.frame.size.height+200);

    //ALERT MESSAGE BOX
    msgView = [[UIView alloc] init];
    [self.view addSubview:msgView];
    msgView.backgroundColor = UIColor.greenColor;
     
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
    lblMessage.text = @"Sign-In to your account";
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
    [txtUsername becomeFirstResponder];
    [msgView addSubview:txtUsername];
    
    ///PASSWORD
    txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(50, 190, 250, 40)];
    txtPassword.borderStyle = UITextBorderStyleRoundedRect;
    txtPassword.returnKeyType = UIReturnKeyDone;
    txtPassword.secureTextEntry = false;
    txtPassword.placeholder = @"enter your Password";
    txtPassword.autocorrectionType = false;
    txtPassword.autocapitalizationType = false;
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

             }];
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
        [self sendAlertMessage:self->_statusMsg];
        if ([self->_statusCode  isEqual: @"200"]) {
            self->userName.text = self->_userFullname;
            self->userEmail.text = self->_userEmailadd;

            NSData* data = [[NSData alloc] initWithBase64EncodedString:self->_userPicture options:0];
            self->userPic.image = [UIImage imageWithData:data];

            
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

                if ([self->_statusCode  isEqual: @"200"]) {
                    self->isLoggedin = true;
                    [self->sidebar reloadData];

                }
                self->barItem = false;  ///ENABLE BAR ITEM MENU
                [self->mainView removeFromSuperview];  ///REMOVE SUBVIEW
             }];
}

- (void)didForgotbuttonTapped:(id)sender {
    NSLog(@"%s","Forgot button tapped.");
}

-(void)setImageBackground:(NSString*)imageName{
    UINavigationController* navigationController = [self navigationController];
    float height = navigationController.toolbar.frame.size.height;
    CGSize size = self.view.frame.size;
    size.height = size.height;
    UIGraphicsBeginImageContext(size);
    CGRect bounds = self.view.bounds;
    bounds.origin.y = bounds.origin.y + height;
    bounds.size.height = bounds.size.height-height;
    [[UIImage imageNamed:imageName] drawInRect:bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}


- (void)sideMenu {
    
    sidebar =  [[UITableView alloc] init];
    sidebar.translatesAutoresizingMaskIntoConstraints = NO;
    sideView = [[UIView alloc] init];
    [self.view addSubview:sideView];
    sideView.backgroundColor = UIColor.orangeColor;
    sideView.frame = CGRectMake(0, 0, 250, self.view.frame.size.height );
    [self.view addSubview:sideView];

    ///HEADER
    headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, 250, 240 );
    headerView.backgroundColor = UIColor.systemGrayColor;
    [sideView addSubview:headerView];
    
    ////USER ICON
    userPic = [[UIImageView alloc]initWithFrame:CGRectMake(90,80,70, 70)];
    if (self->_userPicture != nil) {
        NSData* data = [[NSData alloc] initWithBase64EncodedString:self->_userPicture options:0];
        userPic.image = [UIImage imageWithData:data];
    } else {
        userPic.image = [UIImage imageNamed:@"logo"];
    }
    userPic.userInteractionEnabled = true;
    userPic.backgroundColor = UIColor.clearColor;
    userPic.tintColor = UIColor.whiteColor;
    userPic.tintColor = UIColor.yellowColor;
    userPic.clipsToBounds = true;
    userPic.layer.cornerRadius = 35;
    [sideView addSubview:userPic];

    /// USER NAME
     userName = [[UILabel alloc] initWithFrame:CGRectMake(50,150,250,40)];
    if (self->_userPicture != nil) {
        userName.text = self->_userFullname;
    } else {
        userName.text = @"EVERY NATION";
    }
    userName.textColor = UIColor.whiteColor;
    userName.backgroundColor = UIColor.clearColor;
    userName.textAlignment = NSTextAlignmentLeft;
    userName.font = [UIFont fontWithName:@"Arial" size:22];
    [sideView addSubview: userName];

    /// USER EMAIL ADDRESS
    userEmail = [[UILabel alloc] initWithFrame:CGRectMake(10,180,230,40)];
    if (self->_userPicture != nil) {
        userEmail.text = self->_userEmailadd;
    } else {
        userEmail.text = @"Honor GOD and make disciples";
    }
    userEmail.textColor = UIColor.whiteColor;
    userEmail.backgroundColor = UIColor.clearColor;
    userEmail.textAlignment = NSTextAlignmentCenter;
    userEmail.font = [UIFont fontWithName:@"Arial" size:14];
    [sideView addSubview: userEmail];

    sidebar = [[UITableView alloc] initWithFrame:CGRectMake(0,240,250,540)];
    sidebar.backgroundColor = UIColor.systemTealColor;
    [sideView addSubview:sidebar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)didDrawerTapped:(id)sender {
    if (barItem == false) {
        if (showMenu) {
            [self openMenu];
        } else {
            [self closeMenu];
        }
    }
}

- (void) openMenu {

    ///SLIDE SIDEMENU TO LEFT
        [UIView animateWithDuration: 0.4 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
                 animations:^{
                    self->sideView.frame = CGRectMake(-(self->sideView.bounds.size.width),
                                                     0,
                                                     250,
                                                      self.view.frame.size.height);

                 }
                 completion:^(BOOL finished){
                    self->showMenu = false;
        }];
}

    
- (void) closeMenu {
    ///SLIDE SIDEMENU TO RIGHT
    [self->sideView setFrame:(CGRectMake(-250, 0, 250, self.view.frame.size.height))];
        [UIView animateWithDuration: 0.4 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn
                 animations:^{
                    self->sideView.frame = CGRectMake(+(self->sideView.bounds.size.height-670),
                                                     0,
                                                     250,
                                                      self.view.frame.size.height);

                 }
                 completion:^(BOOL finished){
                    self->showMenu = true;
        }];

}

-(void)addGestureRecogniser:(UIView *)touchView{
 UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didViewTapped)];
 [self.view addGestureRecognizer:singleTap];
}

 - (void)didViewTapped {
     self->showMenu = true;
     if (self->showMenu) {
         [self didDrawerTapped:self];
     }
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
            self->_statusCode = apiStatus[@"statuscode"];
            self->_statusMsg = apiStatus[@"message"];
            self->_userFullname = apiStatus[@"fullname"];
            self->_userEmailadd = apiStatus[@"email"];
            self->_userPicture = apiStatus[@"userpicture"];
            self->_userId = apiStatus[@"id"];
            self->_token = apiStatus[@"token"];
        });
    }] resume];
}

-(void)checkServer {
}

//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//
//    // Stop monitoring when the view is no longer needed
//    [pathMonitor cancel];
//}

-(void)bottomNavigation {
    
    bottomBar = [[UIToolbar alloc] init];
    bottomBar.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
    bottomBar.barTintColor = UIColor.blackColor;
    
                         
    ///SETTINGS
    settingsItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"gear"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(selectSettings:)];

    ///BOOK STORE
    booksItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"books"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(selectBook:)];
    
    ///PASTORS
    pastorsItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"pastors"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(selectPastors:)];
    
    ///VGROUP
    vgroupImage = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"vgroup"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(selectVgroup:)];

    ///TIGHTS
    tightImage = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"tight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(selecttight:)];

    ///VIDEO
    videoImage = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"video"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(selectVideo:)];

    
    
    [bottomBar setItems: @[settingsItem,booksItem,pastorsItem,vgroupImage,tightImage,videoImage] animated:YES];
    [self.view addSubview:bottomBar];
}

- (void)selectSettings:(id)sender {
    NSLog(@"%s","Settings..");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingsViewController *settingsVC = (SettingsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"settingsVC"];
    [self.navigationController pushViewController:settingsVC animated:YES];
}

- (IBAction)selectBook:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BooksTableViewController *booktableVC = (BooksTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"booktableVC"];
    [self.navigationController pushViewController:booktableVC animated:YES];
}

- (IBAction)selectPastors:(id)sender{
    NSLog(@"%s","Pastors...");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PastorsViewController *pastorsVC = (PastorsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"pastorsVC"];
    [self.navigationController pushViewController:pastorsVC animated:YES];
}

- (IBAction)selecttight:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TightsViewController *tightsVC = (TightsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"tightsVC"];
    [self.navigationController pushViewController:tightsVC animated:YES];
}

- (IBAction)selectVgroup:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VgroupViewController *vgroupVC = (VgroupViewController *)[storyboard instantiateViewControllerWithIdentifier:@"vgroupVC"];
    [self.navigationController pushViewController:vgroupVC animated:YES];
}

-(IBAction)selectVideo:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VideoTableViewController *videoTVC = (VideoTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"videoTVC"];
    [self.navigationController pushViewController:videoTVC animated:YES];
}


@end



