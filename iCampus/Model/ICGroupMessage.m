//
//  ICGroupMessage.m
//  iCampus
//
//  Created by xlx on 15/5/26.
//  Copyright (c) 2015年 BISTU. All rights reserved.
//

#import "ICGroupMessage.h"
#import "AFNetworking.h"
@implementation ICGroupMessage
-(void)receivedPersonnalMessage{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer             = [AFHTTPResponseSerializer serializer];
    NSString *urlPath                      = [NSString stringWithFormat:@"http://m.bistu.edu.cn/jiaowu/groupuser.php?group=%@&grouptype=%@",_groupid,_type];
    urlPath                                = [urlPath stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSLog(@"%@",urlPath);
    NSDictionary *params                   = @{@"page" : @"2"};
    [manager GET:urlPath parameters:params success:

     ^(AFHTTPRequestOperation *operation, id responseObject) {

    NSData *data                           = operation.responseData;

    NSDictionary *dict                     = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    _message                               = (NSArray *)dict;
         [_delegate loadCompelectMessage];
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"下载错误 is %@",error);
             /**
              网络错误提醒
              
              :returns: <#return value description#>
              */
    UIAlertView *alertview                 = [[UIAlertView alloc] initWithTitle:@"Warnning" message:@"发生网络问题，请稍后再试。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             [alertview show];
    }];
}
@end
