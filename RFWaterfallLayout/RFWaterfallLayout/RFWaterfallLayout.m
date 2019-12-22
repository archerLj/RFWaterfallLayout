//
//  RFWaterfallLayout.m
//  RFWaterfallLayout
//
//  Created by archerLj on 2019/12/22.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "RFWaterfallLayout.h"

static const NSUInteger RFDefaultColumnCount = 3;
static const CGFloat RFDefaultColumnMargin = 15.0;
static const CGFloat RFDefaultRowMargin = 15.0;
static const UIEdgeInsets RFDefaultEdgeInserts = {15.0, 15.0, 15.0, 15.0};

@interface RFWaterfallLayout()
@property (nonatomic, strong) NSMutableArray *attrsArr;
@property (nonatomic, strong) NSMutableArray *columnsHeightArr;
//@property (nonatomic, assign) CGFloat contentHeight;
@end

@implementation RFWaterfallLayout
/******************************************************************/
#pragma mark - Life Methods
/******************************************************************/
/**
 Layout updates occur the first time the collection view presents its content and whenever the layout is invalidated explicitly or implicitly because of a change to the view. During each layout update, the collection view calls this method first to give your layout object a chance to prepare for the upcoming layout operation.
 The default implementation of this method does nothing. Subclasses can override it and use it to set up data structures or perform any initial computations needed to perform the layout later.
 */
-(void)prepareLayout {
    [super prepareLayout];
    
    // initialize
//    self.contentHeight = 0;
    [self.columnsHeightArr removeAllObjects];
    [self.attrsArr removeAllObjects];
    
    // default height for every column
    for (NSUInteger i = 0; i < [self columnCount]; i++) {
        [self.columnsHeightArr addObject:@([self edgeinserts].top)];
    }
    
    // create layout attribute for every cell
    NSUInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attr];
    }
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArr;
}

-(CGSize)collectionViewContentSize {
    
    CGFloat maxColumnHeight = [self.columnsHeightArr[0] doubleValue];
    for (NSUInteger i = 0; i < [self columnCount]; i++) {
        CGFloat columnHeight = [self.columnsHeightArr[i] doubleValue];
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    
    return CGSizeMake(0, maxColumnHeight + [self edgeinserts].bottom);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    CGFloat columnMargin = [self columnMargin];
    CGFloat rowMargin = [self rowMargin];
    UIEdgeInsets edgeInserts = [self edgeinserts];
    NSUInteger columnCount = [self columnCount];
    
    
    // item width/height
    CGFloat itemW = (collectionViewW - edgeInserts.left - edgeInserts.right - (columnCount - 1) * columnMargin) / columnCount;
    CGFloat itemH = [self.delegate waterfallLayout:self heightForItemAtIndexPath:indexPath withItemWidth:itemW];
    
    // find the minHeight column
    NSInteger minColumn = 0;
    CGFloat minColumnH = [self.columnsHeightArr[0] doubleValue];
    for (NSUInteger i = 0; i < columnCount; i++) {
        CGFloat columnH = [self.columnsHeightArr[i] doubleValue];
        if (minColumnH > columnH) {
            minColumnH = columnH;
            minColumn = i;
        }
    }
    
    // item x and y
    CGFloat itemX = edgeInserts.left + minColumn * (itemW + columnMargin);
    CGFloat itemY = minColumnH != edgeInserts.top ? minColumnH + rowMargin : minColumnH;
    
    attrs.frame = CGRectMake(itemX, itemY, itemW, itemH);
    
    // update the height of minHeight column
    self.columnsHeightArr[minColumn] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}


/******************************************************************/
#pragma mark - Datas Getter
/******************************************************************/
-(NSUInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountForWaterfallLayout:)]) {
        return [self.delegate columnCountForWaterfallLayout:self];
    } else {
        return RFDefaultColumnCount;
    }
}

-(CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginFowWaterfallLayout:)]) {
        return [self.delegate rowMarginFowWaterfallLayout:self];
    } else {
        return RFDefaultRowMargin;
    }
}

-(CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginForWaterfallLayout:)]) {
        return [self.delegate columnMarginForWaterfallLayout:self];
    } else {
        return RFDefaultColumnMargin;
    }
}

-(UIEdgeInsets)edgeinserts {
    if ([self.delegate respondsToSelector:@selector(edgeinsertsForWaterfallLayout:)]) {
        return [self.delegate edgeinsertsForWaterfallLayout:self];
    } else {
        return RFDefaultEdgeInserts;
    }
}


/******************************************************************/
#pragma mark - Properties Getter
/******************************************************************/
-(NSMutableArray *)attrsArr {
    if (_attrsArr == nil) {
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}

-(NSMutableArray *)columnsHeightArr {
    if (_columnsHeightArr == nil) {
        _columnsHeightArr = [NSMutableArray array];
    }
    return _columnsHeightArr;
}
@end
