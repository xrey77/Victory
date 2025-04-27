//
//  BooksTableViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/20/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BooksTableViewController : UITableViewController
@property(strong, nonatomic)UIView *headerView;

@property(nonatomic, strong) UILabel *lblTitle;
@property(strong, nonatomic) NSMutableArray * bookIdArray;
@property(strong, nonatomic) NSMutableArray * bookNameArray;
@property(strong, nonatomic) NSMutableArray * bookImageArray;
@property(strong, nonatomic) NSMutableArray * bookPriceArray;
@property(strong, nonatomic) NSMutableArray * bookAuthorArray;



@end

NS_ASSUME_NONNULL_END
