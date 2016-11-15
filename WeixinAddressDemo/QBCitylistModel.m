//
//  QBCityModel.m
//  cityPlist
//
//  Created by James on 2016/11/14.
//  Copyright © 2016年 James. All rights reserved.
//

#import "QBCitylistModel.h"
#import "MJExtension.h"

@implementation QBCityListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ids":@"id",
            };
}
+ (NSDictionary *)objectClassInArray{
    return @{@"son" :
                     [QBProvinceModel class]
             };
}

@end

@implementation QBProvinceModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ids":@"id",
             };
}
+ (NSDictionary *)objectClassInArray{
    return @{
             @"son" :
                     [QBQuModel class]
             };
}
@end

@implementation QBQuModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ids":@"id",
             };
}
@end
