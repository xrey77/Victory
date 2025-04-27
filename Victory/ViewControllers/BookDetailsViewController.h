//
//  BookDetailsViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/19/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface BookDetailsViewController : UIViewController

@property(nonatomic, assign)NSInteger bookId;
@property(strong, nonatomic)UIImageView *dtlimgBook;
@property(strong, nonatomic)UILabel *lblBooknameTitle;
@property(strong, nonatomic)UILabel *dtlBookname;
@property(strong, nonatomic)UILabel *lblAuthorTitle;
@property(strong, nonatomic)UILabel *dtlAuthor;
@property(strong, nonatomic)UILabel *lblDescriptionTitle;
@property(strong, nonatomic)UILabel *dtlDescription;
@property(strong, nonatomic)UILabel *lblPriceTitle;
@property(strong, nonatomic)UILabel *dtlPrice;
@property(strong, nonatomic)UIImageView *btnCart;
@property(strong, nonatomic)UIImageView *btnCancel;
@property(strong, nonatomic)NSMutableArray *bookData;

@property(nonatomic, copy)NSString *strBookname;
@property(nonatomic, copy)NSString *strBookauthor;
@property(nonatomic, copy)NSString *strBookprice;
@property(nonatomic, copy)NSString *strBookdescripiton;
@property(nonatomic, copy)NSString *strBookImage;

@property(strong, nonatomic) UIView *loadingView;
@property(strong, nonatomic) UILabel *loadingPercent;
@property(strong, nonatomic) UILabel *loadingStatus;
@property(strong, nonatomic) UIProgressView *loading;
@property(strong, nonatomic) NSTimer *timer;

@end

NS_ASSUME_NONNULL_END
