//
//  ICViewController.h
//  iCampus
//
//  Created by Kwei Ma on 13-11-6.
//  Copyright (c) 2013年 BISTU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICGateViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *messageButton;

- (IBAction)checkMessage:(id)sender;
- (IBAction)displaySettings:(id)sender;

@end
