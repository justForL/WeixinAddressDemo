//
//  ViewController.m
//  WeixinAddressDemo
//
//  Created by James on 2016/11/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import "ViewController.h"
#import "QBAddressPickerController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)buttonCllick:(id)sender {
    QBAddressPickerController *vc = [[QBAddressPickerController alloc]init];
    vc.type = QBAddressProvinces;
    vc.finishBlock = ^(NSString *addressString){
        NSLog(@"final---%@",addressString);
    };
    [self.navigationController pushViewController:vc animated:YES];
}


@end
