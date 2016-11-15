//
//  QBAddressPickerController.h
//  WeixinAddressDemo
//
//  Created by James on 2016/11/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
//省市县类型枚举
typedef enum {
    QBAddressProvinces = 0,
    QBAddressCities,
    QBAddressQu
}QBAddressType;

//选择回调
typedef void (^FinishedBlock)(NSString *addressString);
@interface QBAddressPickerController : UIViewController
@property (nonatomic, assign) QBAddressType type;
@property (nonatomic, assign) NSInteger seletedIndex;
@property (nonatomic, assign) NSInteger seletedQuIndex;
@property (nonatomic, copy) FinishedBlock finishBlock;
@end
