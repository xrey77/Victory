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
#import "LoginViewController.h"

@interface MainViewController ()
@end

@implementation MainViewController

@synthesize barItem, showMenu, sideView, sidebar, menuData, headerView,userPic,userEmail,userName,isLoggedin,strUserid,strUsername,strUseremail,strUserpicture;

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
    showMenu = false;
    sideView.hidden = true;
    [self bottomNavigation];

///  SIDE MENU
    sidebar =  [[UITableView alloc] init];
    sidebar.translatesAutoresizingMaskIntoConstraints = NO;
    sideView = [[UIView alloc] init];
    [self.view addSubview:sideView];
    sideView.backgroundColor = UIColor.orangeColor;
    sideView.frame = CGRectMake(0, 0, 250, self.view.frame.size.height );
    [self.view addSubview:sideView];

    sidebar = [[UITableView alloc] initWithFrame:CGRectMake(0,220,250,540)];
    sidebar.backgroundColor = UIColor.systemTealColor;
    [sideView addSubview:sidebar];

    ///DELATEGATE TABLE VIEW, REQUIREMENT FOR numberOfRowsInSection AND cellForRowAtIndexPath
    [sidebar setDelegate:self];
    [sidebar setDataSource:self];
    [self->sidebar reloadData];

    menuData = [NSMutableArray arrayWithObjects:@"c1", @"c2", @"c3", @"c4", @"c5", @"c6",
                @"c7", @"c8", @"c9", @"c10", @"c11", nil];

    [self->sideView setFrame:(CGRectMake(-300,30,299,865))];
    
    self.sidebar.backgroundColor=[UIColor systemTealColor];  ///REMOVE BOTTOM WHITE SPACE
    ///TOUCH MAIN VIEW TO CLOSE SIDE MENU
//    [self addGestureRecogniser:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self->sidebar reloadData];
}

-(void)helper:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self->showMenu) {
            [self checkIsLoggedIn];
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
        if (self->isLoggedin == NO) {
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
        if (self->isLoggedin == NO) {
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ///HEADER
    headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, 200, 50 );
    headerView.backgroundColor = UIColor.clearColor;
    [sideView addSubview:headerView];
    
    ////USER ICON
    userPic = [[UIImageView alloc]initWithFrame:CGRectMake(90,80,70, 70)];
    if (self->isLoggedin == YES) {
        NSData* data = [[NSData alloc] initWithBase64EncodedString:self->strUserpicture options:0];
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
    if (self->isLoggedin == YES) {
        [self->userName removeFromSuperview];
        self->userName = [[UILabel alloc] initWithFrame:CGRectMake(50,150,250,40)];
        self->userName.text = self->strUsername;
        self->userName.textColor = UIColor.whiteColor;
        self->userName.backgroundColor = UIColor.clearColor;
        self->userName.textAlignment = NSTextAlignmentLeft;
        self->userName.font = [UIFont fontWithName:@"Arial" size:22];
        [sideView addSubview: self->userName];
    } else {
        [self->userName removeFromSuperview];
        self->userName = [[UILabel alloc] initWithFrame:CGRectMake(50,150,250,40)];
        self->userName.text = @"EVERY NATION";
        self->userName.textColor = UIColor.whiteColor;
        self->userName.backgroundColor = UIColor.clearColor;
        self->userName.textAlignment = NSTextAlignmentLeft;
        self->userName.font = [UIFont fontWithName:@"Arial" size:22];
        [sideView addSubview: self->userName];
    }

    /// USER EMAIL ADDRESS

    if (self->isLoggedin == YES) {
        [self->userEmail removeFromSuperview];
        self->userEmail = [[UILabel alloc] initWithFrame:CGRectMake(10,180,230,40)];
        self->userEmail.text = self->strUseremail;
        self->userEmail.textColor = UIColor.whiteColor;
        self->userEmail.backgroundColor = UIColor.clearColor;
        self->userEmail.textAlignment = NSTextAlignmentCenter;
        self->userEmail.font = [UIFont fontWithName:@"Arial" size:14];
        [sideView addSubview: self->userEmail];
    } else {
        [self->userEmail removeFromSuperview];
        self->userEmail = [[UILabel alloc] initWithFrame:CGRectMake(10,180,230,40)];
        self->userEmail.text = @"Honor GOD and make disciples";
        self->userEmail.textColor = UIColor.whiteColor;
        self->userEmail.backgroundColor = UIColor.clearColor;
        self->userEmail.textAlignment = NSTextAlignmentCenter;
        self->userEmail.font = [UIFont fontWithName:@"Arial" size:14];
        [sideView addSubview: self->userEmail];
    }
    return headerView;
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
            if(self->isLoggedin == NO) {
                [self navigateToSignupController];
            } else {
                [self navigateToProfileController];
            }
            break;
        case 10:
            if(self->isLoggedin == NO) {
                if (self->showMenu) {
                    [self openMenu];
                } else {
                    [self closeMenu];
                }

                ///USER LOGIN
                [self navigatetoLoginController];
                
                
            } else {
                [self signOut];
//                    [self.sidebar reloadData];
            }
            break;
        default:
            break;
    }
}

- (IBAction)didDrawerTapped:(id)sender {
    if (barItem == false) {
        if (showMenu) {
            [self openMenu];
        } else {
            [self checkIsLoggedIn];
            [self.sidebar reloadData];
            [self closeMenu];
        }
    }
}

-(void)signOut {
    if (self->showMenu) {
        [self openMenu];
    } else {
        [self closeMenu];
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isUserLoggedIn"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USERID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USERNAME"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USEREMAIL"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USERPIC"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TOKEN"];
    self->isLoggedin = NO;
    
    [self.userName removeFromSuperview];
    [self.userEmail removeFromSuperview];
    
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
       NSDictionary * dict = [userDefaults dictionaryRepresentation];
       for (id key in dict) {
           [userDefaults removeObjectForKey:key];
       }
       [userDefaults synchronize];
}

- (void)navigatetoLoginController {

    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC.view setBackgroundColor:[UIColor clearColor]];
    [loginVC.view setTintColor:[UIColor clearColor]];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [nav setModalPresentationStyle:UIModalPresentationCustom];
//    [nav setModalTransitionStyle: UIModalTransitionStyleFlipHorizontal];

    [self presentViewController:nav animated:YES completion:nil];


    
}

- (void)navigateToAboutusController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AboutusViewController *aboutusVC = (AboutusViewController *)[storyboard instantiateViewControllerWithIdentifier:@"aboutusVC"];
    [self.navigationController pushViewController:aboutusVC animated:YES];
}

- (void)navigateToLocationController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LocationViewController *locationVC = (LocationViewController *)[storyboard instantiateViewControllerWithIdentifier:@"locationVC"];
//    locationVC.xcode = self->_token;
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
    profileVC.userId = self->strUserid;
    profileVC.token = self->_strToken;
    profileVC.userPicture = self->strUserpicture;
    [self.navigationController pushViewController:profileVC animated:YES];
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
//    NSLog(@"%s","Settings..");
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
//    NSLog(@"%s","Pastors...");
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

-(void)checkIsLoggedIn {
    bool isLoggedin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isUserLoggedIn"];
    if (isLoggedin) {

        self->isLoggedin = YES;
        self->strUserid = [[NSUserDefaults standardUserDefaults] valueForKey:@"USERID"];
        self->strUsername = [[NSUserDefaults standardUserDefaults] valueForKey:@"USERNAME"];
        self->strUseremail = [[NSUserDefaults standardUserDefaults] valueForKey:@"USEREMAIL"];
        self->_strToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"];
        self->strUserpicture = [[NSUserDefaults standardUserDefaults] valueForKey:@"USERPIC"];
    } else {
        self->isLoggedin = NO;
    }
}


@end



