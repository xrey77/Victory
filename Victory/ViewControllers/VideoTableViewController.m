//
//  VideoTableViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/25/25.
//

#import "VideoTableViewController.h"
#import "VideoDtlsViewController.h"


@interface VideoTableViewController ()

@end

@implementation VideoTableViewController
@synthesize videoArrayVideo,videoArrayLabel, videoTableview,headerView, lblTitle, videoArrayLink;

- (void)viewDidLoad {
    [super viewDidLoad];

    self->videoTableview.backgroundColor = UIColor.blackColor;
    self->videoTableview.showsVerticalScrollIndicator = false;
    self->videoArrayVideo = [[NSMutableArray alloc]init];
    self->videoArrayLabel = [[NSMutableArray alloc]init];
    self->videoArrayLink = [[NSMutableArray alloc]init];
    [self fetchVideoData];
}

-(void)viewDidAppear:(BOOL)animated {
        [[UIDevice currentDevice] setValue: [NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self->videoArrayVideo count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.blackColor;
    
    NSString *url = @"http://127.0.0.1:9000/assets/victory/videoicon/";
    url = [url stringByAppendingString:videoArrayVideo[indexPath.row]];
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:nsUrl];
    cell.imageView.image = [UIImage imageWithData:data];
    
    CGSize itemSize = CGSizeMake(330, 180);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();

    UILabel *lbl = (UILabel *)[cell viewWithTag:1];
    lbl.textColor = UIColor.whiteColor;
    lbl.text = videoArrayLabel[indexPath.row];
    lbl.font = [UIFont fontWithName:@"Arial" size:14];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self->headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 50)];
    self->headerView.backgroundColor = UIColor.blackColor;
    self->lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,0,self.tableView.bounds.size.width,50)];
       NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
       [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
       NSString *xtitle = @"Online Services as of ";
       self->lblTitle.text = [xtitle stringByAppendingString:[dateFormatter stringFromDate:[NSDate date]]];
       self->lblTitle.textColor = UIColor.whiteColor;
       self->lblTitle.textAlignment = NSTextAlignmentJustified;
       self->lblTitle.font = [UIFont fontWithName:@"Arial" size:18];
    [self.headerView addSubview:self->lblTitle];
    return self->headerView;
}

///WHEN ROW TAPPED
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated: false];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger videoID = indexPath.row + 1;
    [self viewVideoDetails:videoID];
}

-(void)viewVideoDetails:(NSInteger)idno {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VideoDtlsViewController *videoDtlVC = (VideoDtlsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"videoDtlVC"];
    videoDtlVC.videoId = idno;
    [self.navigationController pushViewController:videoDtlVC animated:YES];
}



-(void)fetchVideoData {
    [[NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:@"http://127.0.0.1:9000/getvictoryservices"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

            NSError * err;
            
            NSArray * apiData = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:&err];

            for (NSDictionary *dic in apiData) {
                [self->videoArrayVideo addObject:dic[@"serviceimage"]];
                [self->videoArrayLabel addObject:dic[@"servicename"]];
                [self->videoArrayLink addObject:dic[@"servicelink"]];
            }
       
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
            });
            
    }] resume];
        
}



@end
