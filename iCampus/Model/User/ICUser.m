//
//  ICUser.m
//  iCampus
//
//  Created by Darren Liu on 14-4-27.
//  Copyright (c) 2014年 BISTU. All rights reserved.
//

#import "ICUser.h"

@implementation ICUser

- (id)initWithToken:(NSString *)token
        expiresTime:(NSUInteger)expiresTime {
    self = [super init];
    if (self) {
        self.token = token;
        self.expiresTime = expiresTime;
    }
    return self;
}

- (BOOL)login {
    NSString *URLString = @"https://222.249.250.89:8443/m/userinfo.htm";
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request addValue:[NSString stringWithFormat:@"Bearer %@", self.token]
   forHTTPHeaderField:@"Authorization"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    if (!data) {
        return NO;
    }
    NSString *jsonString = [[[NSString alloc] initWithData:data
                                                  encoding:NSUTF8StringEncoding] stringByRemovingPercentEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                                    options:kNilOptions
                                                      error:nil];
    if (json.count < 1) {
        return NO;
    }
    NSDictionary *information = json[0];
    self.ID = information[@"userid"];
    self.name = information[@"username"];
    self.type = information[@"idtype"];
    ICCurrentUser = self;
    return YES;
}

@end
