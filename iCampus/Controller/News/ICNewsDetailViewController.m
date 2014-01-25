//
//  ICNewsDetailViewController.m
//  iCampus
//
//  Created by Kwei Ma on 13-11-11.
//  Copyright (c) 2013年 BISTU. All rights reserved.
//

#import "ICNewsDetailViewController.h"
#import "ICNews.h"
#import "ICNewsDetailView.h"

@interface ICNewsDetailViewController ()

@end

@implementation ICNewsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:[[ICNewsDetailView alloc] initWithNews:self.news
                                                           frame:self.view.frame]];
}

@end
