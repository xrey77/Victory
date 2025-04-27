//
//  PastorsViewController.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/14/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PastorsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property(strong, nonatomic) NSMutableArray *arrayImg;
@property(strong, nonatomic) NSMutableArray *arrayName;
@property(strong, nonatomic) NSMutableArray *arrayBranch;


@end

NS_ASSUME_NONNULL_END
