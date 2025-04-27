//
//  BooksViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/13/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//struct Books {
//    NSString *bookname;
//};


@interface BooksViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *tableViewCell;

@property (strong, nonatomic) IBOutlet UIImageView *bookImage;
@property(strong, nonatomic) NSMutableArray * booksArray;
@property(strong, nonatomic) NSMutableArray * booksArrayData;
@property(strong, nonatomic) NSMutableArray * bookNameArray;
@property(strong, nonatomic) NSMutableArray * bookImageArray;



@end

NS_ASSUME_NONNULL_END
