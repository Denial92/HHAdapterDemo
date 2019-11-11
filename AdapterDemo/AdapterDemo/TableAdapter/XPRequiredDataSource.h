//   
//   XPArrayDataSource.h
//   XPLO
//   
//   Created  by Brook on 2019/4/19
//   Modified by Brook
//   Copyright © 2019 XPLO. All rights reserved.
//   此类用于单一类型 cell 和 model 的数据模型，充当 ViewController 中实现相关 DataSource 协议中 required 方法的对象
//   因此，超出此场景范围时，可以酌情对此类进行扩展，比如继承，如果场景过于复杂时，则不建议采用该方案
//   使用方式，先 initWithCellReuseIdentifier 构造一个有泛型注解的对象，再配置 cellConfigBlock
//   此外还有一些数据的增删方法，在 XPMutating category 中


/*
 XPRequiredDataSource <XPPlaceLocationCell *, XPPostDetail *> *dataSource = [[XPRequiredDataSource alloc] initWithCellReuseIdentifier:@""];
 [dataSource setCellConfigBlock:^(XPPlaceLocationCell * _Nonnull cell, XPPostDetail * _Nonnull model, NSIndexPath * _Nonnull indexPath) {
        [cell fullCell:model];
 }];
 
 
 这也是适配器的一种使用方式，brook小哥哥写的
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPRequiredDataSource <__covariant CellType, __covariant ModelType>: NSObject <UITableViewDataSource, UICollectionViewDataSource>

/// 初始化方法，自行对 tableView/collectionView 的相关 reuseIdentifier 进行注册
/// 目前只支持 class 注册，不支持 nib 的注册
- (instancetype)initWithCellReuseIdentifier:(NSString *)reuseIdentifier;

/// 利用此 block 进行 cell 的必要配置，注意避免循环引用
/// 用 setter 暴露接口而不是 property 的原因，在于单纯的属性赋值，Xcode 的自动完成对泛型没有实现自动替换
- (void)setCellConfigBlock:(void(^)(CellType cell, ModelType model, NSIndexPath *indexPath))cellConfigBlock;

/// 是否一个 cell 占一个 section，默认为 NO
@property (nonatomic, assign, getter=isSectionStyle) BOOL sectionStyle;

/// 如果有必要，可以直接从外部传入一个可变数组，从而实现数组的引用共享
/// 默认内部会自动管理
- (void)setDataArray:(NSMutableArray <ModelType> *)dataArray;

@end

@interface XPRequiredDataSource <CellType, ModelType> (XPMutating)

/// 下标取值
- (ModelType)objectForKeyedSubscript:(NSIndexPath *)indexPath;

- (void)addObjectsFromArray:(NSArray<ModelType> *)otherArray;
- (void)addObject:(ModelType)anObject;
- (void)insertObject:(ModelType)object atIndexPath:(NSIndexPath *)indexPath;

- (void)removeAllObjects;
- (void)removeObject:(ModelType)anObject;
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
