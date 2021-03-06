//
//  ICUsedGoodListViewController.m
//  iCampus
//
//  Created by EricLee on 14-4-8.
//  Copyright (c) 2014年 BISTU. All rights reserved.
//
#import "ICUser.h"
#import "ICUsedGoodListViewController.h"
#import "ICUsedGood.h"
#import "ICUsedGoodType.h"
#import "ICUsedGoodListCell.h"
#import "../../View/UsedGood/ICUsedGoodDetailView.h"
#import "../../Model/ICModelConfig.h"
#import "ICUsedGoodDetailViewController.h"
#import "../ICControllerConfig.h"
#import "ICUsedGoodFilterViewController.h"
#import "ICUsedGoodMyListTableViewController.h"
#import "APNavigationController.h"
#import "ICUsedGoodPublishTableViewController.h"
#import "MobClick.h"

@interface ICUsedGoodListViewController ()<ICUsedGoodPublishTableViewControllerDelegate,ICUsedGoodFilterViewControllerDelegate>
@property (nonatomic,copy) NSString *type;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) UIButton *mask;
@end

@implementation ICUsedGoodListViewController

- (IBAction)disMiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [MobClick endLogPageView:@"二手模块"];
}

- (void)popMyself:(UIBarButtonItem *)item
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)publishViewController:(ICUsedGoodPublishTableViewController *)viewController didPublish:(BOOL)success {
    if (success) {
        self.datas=[NSMutableArray array];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.datas = [NSMutableArray arrayWithArray:[ICUsedGood goodListWithType:nil]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
    }
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSString *title1;
    NSString *title2;
    NSString *filter1;
    NSString *mine1;
    NSString *publish1;
    if ([currentLanguage isEqualToString:@"zh-Hans"]) {
        title1 =@"二手物品";
        filter1=@"类别";
        mine1=@"我的发布";
        publish1=@"发布物品";
        title2=@" ";
    }
    else{
        title1 =@"Used Goods";
        filter1=@"Filter";
        mine1=@"Mine";
        publish1=@"Publish";
        title2=@"Goods";
    }

    [self publishViewController:nil didPublish:YES];
    APNavigationController *navigationController = (APNavigationController *)self.navigationController;
    navigationController.activeBarButtonTitle = title1;
    navigationController.activeNavigationBarTitle = title1;
    
    self.mask = [[UIButton alloc] initWithFrame:self.tableView.frame];
    self.mask.backgroundColor = [UIColor blackColor];
    [self.mask addTarget:self action:@selector(toggleDropDown:) forControlEvents:UIControlEventTouchDown];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title2 style:UIBarButtonItemStyleBordered target:self action:@selector(popMyself:)];
    
    
    self.navigationController.navigationBar.translucent = NO;
    self.clearsSelectionOnViewWillAppear = YES;
    self.tableView.rowHeight = 72.0f;
    
    self.title=title1;
    self.type=self.title;
    UIBarButtonItem *person,*filter,*publish,*show;
    filter=[[UIBarButtonItem alloc]initWithTitle:filter1 style:UIBarButtonItemStyleBordered target:self action:@selector(pushFilterViewController:)];
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:0];
    UIBarButtonItem *button4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:0];
    
    
    person=[[UIBarButtonItem alloc]initWithTitle:mine1 style:UIBarButtonItemStyleBordered target:self action:@selector(pushMyListViewController:)];
    
    publish=[[UIBarButtonItem alloc]initWithTitle:publish1 style:UIBarButtonItemStyleBordered target:self action:@selector(pushPublishViewController:)];
    
    show=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ICNavigationBarCategoryIcon"] style:UIBarButtonItemStyleBordered target:self action:@selector(toggleDropDown:)];
    self.navigationItem.rightBarButtonItem =show;
    navigationController.dropDownToolbar.items = @[person,button2,filter,button4,publish];
    navigationController.dropDownToolbar.barTintColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0];
    navigationController.dropDownToolbar.tintColor = [UIColor colorWithRed:100/255.0 green:120/255.0 blue:150/255.0 alpha:1];
    
    [MobClick beginLogPageView:@"二手模块"];
}

- (void) usedGoodFilterView:(ICUsedGoodFilterViewController *)view
               SelectedType:(ICUsedGoodType *)type{
    self.datas=[NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([type.name isEqualToString:@"全部"]) {
            self.datas= [[NSMutableArray alloc]initWithArray:[ICUsedGood goodListWithType:nil]];
        }else{
        self.datas= [[NSMutableArray alloc]initWithArray:[ICUsedGood goodListWithType:type]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
   
}

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"Used_Good_Detail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    [self hideDropDown:self];
    if ([segue.identifier isEqualToString:(NSString *)@"Used_Good_Detail"]) {
        ICUsedGoodDetailViewController *detailViewController = (ICUsedGoodDetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        detailViewController.usedGood= self.datas[indexPath.row];
        detailViewController.navigationItem.rightBarButtonItem=nil;
    } else if ([segue.identifier isEqualToString:(NSString *)ICUsedGoodListToFilterIdentifier])
    {
        ICUsedGoodFilterViewController *filterViewController = (ICUsedGoodFilterViewController *)((UINavigationController *)segue.destinationViewController).topViewController;
        filterViewController.delegate=self;
       
    }else if ([segue.identifier isEqualToString:(NSString *)ICUsedGoodListToMyListIdentifier]){
        
    }else if ([segue.identifier isEqualToString:(NSString *)ICUsedGoodListToPublishIdentifier]){
        ICUsedGoodPublishTableViewController *publishViewController = (ICUsedGoodPublishTableViewController *)segue.destinationViewController;
        publishViewController.delegate = self;
    }
}
- (IBAction)pushMyListViewController:(id)sender{
    [self performSegueWithIdentifier:(NSString *)ICUsedGoodListToMyListIdentifier sender:self];
    }
- (IBAction)pushPublishViewController:(id)sender{
    [self performSegueWithIdentifier:(NSString *)ICUsedGoodListToPublishIdentifier sender:self];
}
- (IBAction)pushFilterViewController:(id)sender{
    [self performSegueWithIdentifier:(NSString *)ICUsedGoodListToFilterIdentifier sender:self];
    
}

- (IBAction)toggleDropDown:(id)sender {
    APNavigationController *navigationController = (APNavigationController *)self.navigationController;
    if (!navigationController.isDropDownVisible) {
        self.mask.alpha = 0;
        [self.view.superview insertSubview:self.mask
                              belowSubview:navigationController.dropDownToolbar];
        [UIView animateWithDuration:0.25 animations:^{
            self.mask.alpha = 0.4;
        }];
    } else {
        self.mask.alpha = 0.4;
        [UIView animateWithDuration:0.25 animations:^{
            self.mask.alpha = 0;
        } completion:^(BOOL finished) {
            [self.mask removeFromSuperview];
        }];
    }
    [navigationController toggleDropDown:self];
}
- (IBAction)hideDropDown:(id)sender {
    APNavigationController *navigationController = (APNavigationController *)self.navigationController;
    if (navigationController.isDropDownVisible) {
        [self toggleDropDown:self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ICUsedGood *good= self.datas[indexPath.row];
    static NSString *prefix = @"IC_USED_GOOD";
    NSString *identifier = [NSString stringWithFormat:@"%@_%ld_%ld", prefix, (long)indexPath.row, (long)indexPath.section];
    ICUsedGoodListCell *cell =
        [[ICUsedGoodListCell alloc]initWithUsedGood:good reuseIdentifier:identifier];

    // Configure the cell...
    
    return cell;
}

@end
