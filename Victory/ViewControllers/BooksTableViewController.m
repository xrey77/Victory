//
//  BooksTableViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/20/25.
//

#import "BooksTableViewController.h"
#import "BookDetailsViewController.h"

@interface BooksTableViewController ()
@end

@implementation BooksTableViewController
@synthesize bookNameArray,bookImageArray,bookPriceArray,bookIdArray,lblTitle,headerView,bookAuthorArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self->bookIdArray = [[NSMutableArray alloc] init];
    self->bookNameArray = [[NSMutableArray alloc] init];
    self->bookImageArray = [[NSMutableArray alloc] init];
    self->bookPriceArray = [[NSMutableArray alloc] init];
    self->bookAuthorArray = [[NSMutableArray alloc] init];
    
    [self fetchBooksData];

    self.tableView.separatorColor = UIColor.clearColor;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self->bookNameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentier forIndexPath:indexPath];
    cell.layer.backgroundColor = UIColor.whiteColor.CGColor;
    cell.layer.borderColor = UIColor.whiteColor.CGColor;
    cell.layer.borderWidth = 1;

    NSString *url = @"http://127.0.0.1:9000/assets/ccfbooks/";
    url = [url stringByAppendingString:bookImageArray[indexPath.row]];
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:nsUrl];
    cell.imageView.frame = CGRectMake(0, 0, 50,50);
    cell.imageView.image = [UIImage imageWithData:data];

    NSString *strBname = self->bookNameArray[indexPath.row];
    NSString *sep1 = @"\nAuthor : ";
    NSString *sep2 = [strBname stringByAppendingString:sep1];
    NSString *strAuth = [sep2 stringByAppendingString:bookAuthorArray[indexPath.row]];
    NSString *sep3 = @"\nPrice : $";
    NSString *sep4 = [strAuth stringByAppendingString:sep3];
    NSString *ok = [sep4 stringByAppendingString:self->bookPriceArray[indexPath.row]];
    cell.textLabel.text = ok;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 3;
    return cell;
}

///HEIGHT OF  ROW
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

///WHEN ROW TAPPED
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated: false];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger idno = indexPath.row + 1;  ///INCREMENT BY 1, BECAUSE API Book ID starts at 1
    [self viewBookDetails:idno];
}

-(void)viewBookDetails:(NSInteger)dtl {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BookDetailsViewController *bookDTLSviewVC = (BookDetailsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"bookDTLSviewVC"];
    bookDTLSviewVC.bookId = dtl;
    [self.navigationController pushViewController:bookDTLSviewVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self->headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 50.0f)];
    self->headerView.backgroundColor = UIColor.grayColor;
    self->lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,0,self.tableView.bounds.size.width,50)];
       NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
       [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
       NSString *xtitle = @"List of Books as of ";
       self->lblTitle.text = [xtitle stringByAppendingString:[dateFormatter stringFromDate:[NSDate date]]];
       self->lblTitle.textColor = UIColor.whiteColor;
       self->lblTitle.textAlignment = NSTextAlignmentLeft;
       self->lblTitle.font = [UIFont fontWithName:@"Arial" size:18];
    [self.headerView addSubview:self->lblTitle];
    return self->headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)fetchBooksData {
    [[NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:@"http://127.0.0.1:9000/getccfbooks"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

            NSError * err;
            
            NSArray * apiData = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:&err];

            for (NSDictionary *dic in apiData) {
                [self->bookIdArray addObject:dic[@"id"]];
                [self->bookNameArray addObject:dic[@"bookname"]];
                [self->bookImageArray addObject:dic[@"bookimage"]];
                [self->bookPriceArray addObject:dic[@"bookprice"]];
                [self->bookAuthorArray addObject:dic[@"bookauthor"]];
            }
       
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
            });
            
    }] resume];
        
}



@end
