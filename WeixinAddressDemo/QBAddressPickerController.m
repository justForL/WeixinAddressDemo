//
//  QBAddressPickerController.m
//  WeixinAddressDemo
//
//  Created by James on 2016/11/15.
//  Copyright © 2016年 James. All rights reserved.
//

#import "QBAddressPickerController.h"
#import "QBCitylistModel.h"
#import "MJExtension.h"
#define kQBAddressPickerCell @"QBAddressPicker"
@interface QBAddressPickerController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *locationArray;
@property (nonatomic, copy) NSString *tempStr;  //存放当前选择的地址编码

@end

@implementation QBAddressPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
}

- (void)setUpTableView {
    [self.view addSubview:self.tableView];
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type == QBAddressProvinces) {
        return [self.locationArray count];
    }else if (self.type ==QBAddressCities){
        return [[self.locationArray[self.seletedIndex] son] count];
    }else{
        QBProvinceModel *model = [[self.locationArray[self.seletedIndex] son] objectAtIndex:self.seletedQuIndex];
        return model.son.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kQBAddressPickerCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kQBAddressPickerCell];
    }
    if (self.type == QBAddressProvinces) {
        QBCityListModel *cityModel = self.locationArray[indexPath.row];
        cell.textLabel.text = cityModel.name;
        cell.textLabel.tag = [cityModel.ids integerValue];
    }else if (self.type ==QBAddressCities){
        QBCityListModel *cityModel = self.locationArray[self.seletedIndex];
        QBProvinceModel *provinceModel = cityModel.son[indexPath.row];
        cell.textLabel.text = provinceModel.name;
        cell.textLabel.tag = [provinceModel.ids integerValue];
    }else{
        QBCityListModel *cityModel = self.locationArray[self.seletedIndex];
        QBProvinceModel *provinceModel = cityModel.son[self.seletedQuIndex];
        cell.textLabel.text = [provinceModel.son[indexPath.row] name];
        cell.textLabel.tag = [[provinceModel.son[indexPath.row] ids] integerValue];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QBAddressPickerController *vc = [[QBAddressPickerController alloc]init];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.tempStr = [NSString stringWithFormat:@"%zd",cell.textLabel.tag];
    __weak typeof(self) WeakSelf = self;
    if (self.type == QBAddressProvinces) {
        vc.type = QBAddressCities;
        vc.seletedIndex = indexPath.row;
        vc.finishBlock = ^(NSString *addressStr){
            WeakSelf.tempStr = [WeakSelf.tempStr stringByAppendingString:[NSString stringWithFormat:@",%@",addressStr]];
            if (WeakSelf.finishBlock) {
                WeakSelf.finishBlock(WeakSelf.tempStr);
                //在此处pop操作
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.type ==QBAddressCities){
        QBCityListModel *cityModel = self.locationArray[self.seletedIndex];
        QBProvinceModel *provinceModel = cityModel.son[indexPath.row];
        vc.finishBlock = ^(NSString *addressStr){
            self.tempStr = [self.tempStr stringByAppendingString:[NSString stringWithFormat:@",%@",addressStr]];
            if (WeakSelf.finishBlock) {
                WeakSelf.finishBlock(self.tempStr);
            }
        };
        //判断是否有第三层跳转 没有则做返回操作
        if (provinceModel.son.count > 0) {
            vc.type = QBAddressQu;
            vc.seletedIndex = self.seletedIndex;
            vc.seletedQuIndex = indexPath.row;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self finishedAndBackData];
        }
    }else{
        [self finishedAndBackData];
    }
}
#pragma mark - 最后一级的返回处理
- (void)finishedAndBackData{
    __weak typeof(self) WeakSelf = self;
    if (self.finishBlock) {
        self.finishBlock(WeakSelf.tempStr);
    }
}
#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSArray *)locationArray {
    if (_locationArray == nil) {
        NSString *string = [[NSBundle mainBundle] pathForResource:@"region.json" ofType:nil];
        NSData *data = [[NSData alloc]initWithContentsOfFile:string];
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _locationArray = [QBCityListModel mj_objectArrayWithKeyValuesArray:jsonArray];
    }
    return _locationArray;
}

@end
