//
//  ViewController.m
//  PhotoBrowser
//
//  Created by 林_同 on 2017/5/24.
//  Copyright © 2017年 林_同. All rights reserved.
//

#import "ViewController.h"
#import "PhotoBrowserViewController.h"

@interface ViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>{
    UICollectionView *_collection;
}

@property (nonatomic, strong) NSMutableArray *arrayM;

@end

@implementation ViewController

- (NSMutableArray *)arrayM{
    if (!_arrayM) {
        _arrayM = [NSMutableArray array];
        for (int i = 1; i < 7; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
            [_arrayM addObject:image];
        }
    }
    return _arrayM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
}

static NSString *cellId = @"cellId";
- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor whiteColor];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(130, 130);
    [self.view addSubview:_collection];
    _collection.dataSource = self;
    _collection.delegate = self;
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:self.arrayM[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoBrowserViewController *photo = [[PhotoBrowserViewController alloc] init];
    photo.images = self.arrayM;
    photo.isOriginal = YES;
    photo.selectedIndex = (unsigned int)indexPath.row;
    [self presentViewController:photo animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
