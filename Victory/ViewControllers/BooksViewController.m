//
//  BooksViewController.m
//  Victory
//
//  Created by Reynald Marquez-Gragasin on 4/13/25.
//

#import "BooksViewController.h"
//#import "MYTapGestureRecognizer.h"
#import "BookDetailsViewController.h"

@interface BooksViewController()

@end

@implementation BooksViewController
@synthesize tableView,bookNameArray,tableViewCell,bookImageArray, booksArray, booksArrayData;

- (void)viewDidLoad {
    [super viewDidLoad];
    booksArrayData = [[NSMutableArray alloc]init];
    booksArray = [[NSMutableArray alloc]init];
    bookImageArray =  [[NSMutableArray alloc]init];
    
    [self fetchBooksData];
    [self setupTableView];

}

-(void)setupTableView {
//    tableView = [[UITableView alloc] initWithFrame:CGRectZero];
//    [self.view addSubview: tableView];
//    tableView.translatesAutoresizingMaskIntoConstraints = false;
//    [tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
//    [tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
//    [tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
//    [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;

    tableView.delegate = self;
    tableView.dataSource = self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self->bookNameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CustomCell * self = [tableView dequeueResuableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor=[UIColor systemTealColor];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.textColor = UIColor.blackColor;
    cell.backgroundColor = UIColor.systemTealColor;
    cell.textLabel.text = [bookNameArray objectAtIndex:indexPath.row];

    return cell;
}

-(void)fetchBooksData {
    [[NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:@"http://127.0.0.1:9000/getccfbooks"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

            NSError * err;
            
            NSArray * apiData = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:&err];

            for (NSDictionary *dic in apiData) {
                [self->booksArrayData addObjectsFromArray:@[dic[@"bookname"],dic[@"bookimage"]]];
            }
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->booksArray addObject:self->booksArrayData];
                [self.tableView reloadData];
                
            });

            
    }] resume];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

