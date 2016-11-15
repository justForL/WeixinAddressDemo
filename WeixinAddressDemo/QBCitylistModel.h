//
//  QBCityModel.h
//  cityPlist
//
//  Created by James on 2016/11/14.
//  Copyright © 2016年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QBResultModel,QBProvinceModel,QBQuModel;

@interface QBCityListModel : NSObject
@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, strong) NSArray<QBProvinceModel *> *son;
@end

@interface QBProvinceModel : NSObject
@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, strong) NSArray<QBQuModel *>  *son;
@end


@interface QBQuModel : NSObject
@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pid;
@end
