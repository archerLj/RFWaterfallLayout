//
//  RFWaterfallLayout.h
//  RFWaterfallLayout
//
//  Created by archerLj on 2019/12/22.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RFWaterfallLayout;
@protocol RFWaterfallLayoutDelegate <NSObject>

@required
// height for item
-(CGFloat)waterfallLayout:(RFWaterfallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexpath withItemWidth:(CGFloat)itemWidth;

@optional
// column count (default is 3)
-(NSUInteger)columnCountForWaterfallLayout:(RFWaterfallLayout *)layout;
// column margin (default is 15.0)
-(CGFloat)columnMarginForWaterfallLayout:(RFWaterfallLayout *)layout;
// row margin (default is 15.0)
-(CGFloat)rowMarginFowWaterfallLayout:(RFWaterfallLayout *)layout;
// edgeinserts for every item (default is 15.0)
-(UIEdgeInsets)edgeinsertsForWaterfallLayout:(RFWaterfallLayout *)layout;

@end

@interface RFWaterfallLayout : UICollectionViewLayout
@property (nonatomic, weak) id<RFWaterfallLayoutDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
