//
//  ICControllerConfig.h
//  iCampus
//
//  Created by Darren Liu on 13-12-19.
//  Copyright (c) 2013年 BISTU. All rights reserved.
//

#import "../ICConfig.h"

//=====================================================================

#   pragma mark - Debug options

#   define IC_CONTROLLER_MODULE_DEBUG
#   ifdef IC_CONTROLLER_MODULE_DEBUG
#       define IC_YELLOWPAGE_DIAL_MODULE_DEBUG
#   endif

//=====================================================================

#   pragma mark - Segue identifiers

static const NSString *ICNewsListToChannelIdentifier          = @"IC_NEWS_LIST_TO_CHANNEL"          ;
static const NSString *ICNewsListToDetailIdentifier           = @"IC_NEWS_LIST_TO_DETAIL"           ;
static const NSString *ICSchoolListToDetailIdentifier         = @"IC_SCHOOL_LIST_TO_DETAIL"         ;
static const NSString *ICYellowPageDepartmentToListIdentifier = @"IC_YELLOWPAGE_DEPARTMENT_TO_LIST" ;
static const NSString *ICYellowPageListToNewContactIdentifier = @"IC_YELLOWPAGE_LIST_TO_NEW_CONTACT";
static const NSString *ICAccountToLoginIdentifier             = @"IC_ACCOUNT_TO_LOGIN"              ;
static const NSString *ICAccountToEditIdentifier              = @"IC_ACCOUNT_TO_EDIT"               ;
static const NSString *ICUsedGoodListToFilterIdentifier       = @"IC_USED_GOOD_LIST_TO_FILTER"      ;
static const NSString *ICUsedGoodListToMyListIdentifier       = @"IC_USED_GOOD_LIST_TO_MYLIST"      ;
static const NSString *ICUsedGoodListToPublishIdentifier      = @"IC_USED_GOOD_LIST_TO_PUBLISH"     ;
static const NSString *ICUsedGoodPublishToLoginIdentifier     = @"IC_USED_GOOD_PUBLISH_TO_LOGIN"    ;
static const NSString *ICUsedGoodMyListToLoginIdentifier      = @"IC_USED_GOOD_MY_LIST_TO_LOGIN"    ;
static const NSString *ICUsedGoodDetailToContactIdentifier    = @"IC_USED_GOOD_DETAIL_TO_CONTACT"   ;


//=====================================================================

#   pragma mark - Locale settings

static const NSString *ICSchoolName            = @"北京信息科技大学";
static const NSString *ICSchoolTelephonePrefix = @"+86(0)10"     ;

//=====================================================================