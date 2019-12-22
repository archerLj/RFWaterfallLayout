//
//  ViewController.m
//  RFWaterfallLayout
//
//  Created by archerLj on 2019/12/22.
//  Copyright © 2019 com.tech.zhonghua. All rights reserved.
//

#import "ViewController.h"
#import "RFWaterfallLayout.h"
#import "DemoCell.h"

@interface ViewController ()<RFWaterfallLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainCollectionView];
    
    for (NSInteger i = 0; i < 100; i++) {
        [self.models addObject:@([self randomFloatBetween:50 andLargerFloat:150])];
    }
    [self.mainCollectionView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mainCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[
        [self.mainCollectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.mainCollectionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.mainCollectionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.mainCollectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
    ]];
}

-(float)randomFloatBetween:(float)num1 andLargerFloat:(float)num2
{
    int startVal = num1*10000;
    int endVal = num2*10000;

    int randomValue = startVal +(arc4random()%(endVal - startVal));
    float a = randomValue;

    return(a /10000.0);
}

/******************************************************************/
#pragma mark - delegate & dataSource
/******************************************************************/
-(CGFloat)waterfallLayout:(RFWaterfallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexpath withItemWidth:(CGFloat)itemWidth {
    return [self.models[indexpath.row] doubleValue];
}

-(NSUInteger)columnCountForWaterfallLayout:(RFWaterfallLayout *)layout {
    return 2;
}

-(CGFloat)columnMarginForWaterfallLayout:(RFWaterfallLayout *)layout {
    return 20.0;
}

-(CGFloat)rowMarginFowWaterfallLayout:(RFWaterfallLayout *)layout {
    return 20.0;
}

-(UIEdgeInsets)edgeinsertsForWaterfallLayout:(RFWaterfallLayout *)layout {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DemoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}


/******************************************************************/
#pragma mark - getter
/******************************************************************/
-(UICollectionView *)mainCollectionView {
    if (_mainCollectionView == nil) {
        RFWaterfallLayout *layout = [[RFWaterfallLayout alloc] init];
        layout.delegate = self;
        
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.alwaysBounceVertical = YES;
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        [_mainCollectionView registerClass:[DemoCell class] forCellWithReuseIdentifier:@"CellID"];
    }
    return _mainCollectionView;
}

-(NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray array];
    }
    return _models;
}
@end
