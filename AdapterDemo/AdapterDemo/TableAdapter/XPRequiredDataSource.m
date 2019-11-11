//   
//   XPArrayDataSource.m
//   XPLO
//   
//   Created  by Brook on 2019/4/19
//   Modified by Brook
//   Copyright © 2019 XPLO. All rights reserved.
//   
   

#import "XPRequiredDataSource.h"

@interface XPRequiredDataSource <CellType, ModelType> ()

@property (nonatomic, strong) NSMutableArray <ModelType> *dataArray;

@property (nonatomic, copy) NSString *(^identifierFetchBlock)(NSIndexPath *indexPath);

/// 在此 block 中对 cell 进行配置
@property (nonatomic, copy) void(^cellConfigBlock)(CellType cell, ModelType model, NSIndexPath *indexPath);
           
@end
           
@implementation XPRequiredDataSource
- (instancetype)initWithCellReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super init]) {
        NSString *copied = [reuseIdentifier copy];
        _identifierFetchBlock = [^NSString *(NSIndexPath *indexPath) {
            return copied;
        } copy];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.isSectionStyle ? self.dataArray.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isSectionStyle ? 1 : self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:self.identifierFetchBlock(indexPath) forIndexPath:indexPath];
    
    self.cellConfigBlock(cell, self[indexPath], indexPath);
    
    return cell;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.isSectionStyle ? self.dataArray.count : 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.isSectionStyle ? 1 : self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.identifierFetchBlock(indexPath) forIndexPath:indexPath];
    
    self.cellConfigBlock(cell, self[indexPath], indexPath);
    
    return cell;
}

#pragma mark - setter and getter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end

@implementation XPRequiredDataSource (XPMutating)

- (id)objectForKeyedSubscript:(NSIndexPath *)indexPath {
    return self.dataArray[[self _getIndexFromIndexPath:indexPath]];
}

- (void)addObject:(id)anObject {
    [self.dataArray addObject:anObject];
}

- (void)addObjectsFromArray:(NSArray<id> *)otherArray {
    [self.dataArray addObjectsFromArray:otherArray];
}

- (void)insertObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    [self.dataArray insertObject:object atIndex:[self _getIndexFromIndexPath:indexPath]];
}

- (void)removeObject:(id)anObject {
    [self.dataArray removeObject:anObject];
}

- (void)removeAllObjects {
    [self.dataArray removeAllObjects];
}

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataArray removeObjectAtIndex:[self _getIndexFromIndexPath:indexPath]];
}

#pragma mark - private
- (NSInteger)_getIndexFromIndexPath:(NSIndexPath *)indexPath {
    return self.isSectionStyle ? indexPath.section : indexPath.row;
}

@end
