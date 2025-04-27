//
//  Loader.h
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/22/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Loader : UIView
@property (strong, nonatomic) IBOutlet UILabel *loadertPercent;
@property (strong, nonatomic) IBOutlet UILabel *loaderStatus;
@property (strong, nonatomic) IBOutlet UIProgressView *loader;

@end

NS_ASSUME_NONNULL_END
