//
//  VideoTableViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/25/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoTableViewController : UITableViewController 
@property (strong, nonatomic) IBOutlet UITableView *videoTableview;
@property (strong, nonatomic) NSMutableArray *videoArrayVideo;
@property (strong, nonatomic) NSMutableArray *videoArrayLabel;
@property (strong, nonatomic) NSMutableArray *videoArrayLink;

@property(strong, nonatomic) UIView *headerView;
@property(nonatomic, strong) UILabel *lblTitle;

@end

NS_ASSUME_NONNULL_END
