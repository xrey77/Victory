//
//  PastorDtlsViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/23/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PastorDtlsViewController : UIViewController

@property(nonatomic, assign)NSInteger pastorID;
@property(strong, nonatomic)UIImageView *pastorImage;
@property(strong, nonatomic)UILabel *pastorName;
@property(strong, nonatomic)UILabel *pastorBranch;

@property(strong, nonatomic)NSString *strPastorname;
@property(strong, nonatomic)NSString *strPastorbranch;
@property(strong, nonatomic)NSString *strPastorimage;

@end

NS_ASSUME_NONNULL_END
