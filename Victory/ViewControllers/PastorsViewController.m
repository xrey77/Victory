//
//  PastorsViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/14/25.
//

#import "PastorsViewController.h"
#import "PastorDtlsViewController.h"

@interface PastorsViewController ()

@end

@implementation PastorsViewController
@synthesize arrayImg,arrayName,arrayBranch,collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    collectionView.showsVerticalScrollIndicator = false;
    arrayName = [[NSMutableArray alloc] init];
    arrayBranch = [[NSMutableArray alloc] init];
    arrayImg = [[NSMutableArray alloc] init];
    
    [self fetchPastors];
    
}

-(void)fetchPastors {

    NSString *url = @"http://127.0.0.1:9000/getvictorypastors";
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        
        NSDictionary *apiData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        for(NSDictionary *dic in apiData) {
            [self->arrayName addObject:dic[@"pastorname"]];
            [self->arrayBranch addObject:dic[@"pastorbranch"]];
            [self->arrayImg addObject:dic[@"pastorimage"]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });

    }];
    [dataTask resume];
}


- (NSInteger)collectionView:( UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [arrayImg count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *image1 = (UIImageView *)[cell viewWithTag:1];
    UILabel *label1 = (UILabel *)[cell viewWithTag:2];
    
    
    NSString *url = @"http://127.0.0.1:9000/assets/victory/";
    url = [url stringByAppendingString:arrayImg[indexPath.row]];
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:nsUrl];
    image1.frame = CGRectMake(0, 0, 130,130);
    
    image1.image = [UIImage imageWithData:data];
    label1.frame = CGRectMake(0, 120, 130, 50);
    label1.textColor = UIColor.whiteColor;
    label1.font = [UIFont fontWithName:@"Arial" size:14];
    label1.text = self->arrayName[indexPath.row];
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeigth = screenRect.size.height;

        float cellHeigth = screenHeigth / 3.5;
        float cellWidth = screenWidth / 3.5; //Replace the divisor with the column count requirement. Make sure to have it in float.
        CGSize size = CGSizeMake(cellWidth, cellHeigth);
    return size;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
        NSInteger idno = indexPath.row + 1;
        [self navigateToPastorDtlsController:idno];
    
}


///START : SHOW HEADER
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
  return CGSizeMake(0., 50.);
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath {

        UICollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];

    return headerView;
}
///END : SHOW HEADER



- (void)navigateToPastorDtlsController:(NSInteger)idno {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PastorDtlsViewController *pastorDtlVC = (PastorDtlsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"pastorDtlVC"];
    pastorDtlVC.pastorID = idno;
    [self.navigationController pushViewController:pastorDtlVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
