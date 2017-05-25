//
//  PhotoBrowserViewController.m
//  PhotoBrowser
//
//  Created by 林_同 on 2017/5/24.
//  Copyright © 2017年 林_同. All rights reserved.
//

#import "PhotoBrowserViewController.h"

@interface PhotoBrowserViewController ()<UIScrollViewDelegate>{
    UIScrollView *_scroll;
    UIPageControl *_pageControl;
    CGSize _size;
}

@end

@implementation PhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScrollView];
}

- (void)createScrollView{
    _scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scroll.backgroundColor = [UIColor whiteColor];
    _scroll.userInteractionEnabled = YES;
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    _size = self.view.bounds.size;
    _scroll.contentSize = CGSizeMake(_size.width * self.images.count, _size.height);
    _scroll.pagingEnabled = YES;
    _scroll.maximumZoomScale = 10.0;
    _scroll.minimumZoomScale = 0.1;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_scroll addGestureRecognizer:tap];
    
    for (int i = 0; i < self.images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [_scroll addSubview:imageView];
        imageView.image = self.images[i];
        if (_isOriginal) {
            imageView.frame = [self scaleWithImage:self.images[i] index:i];
        }else{
            imageView.frame = CGRectMake(_size.width * i, 0, _size.width, _size.height);
        }
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(200, _size.height - 50, _size.width - 400, 50)];
    
    _pageControl.numberOfPages = self.images.count;
    _pageControl.currentPage = self.selectedIndex;
    [self.view addSubview:_pageControl];
    _scroll.contentOffset = CGPointMake(_size.width * self.selectedIndex, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%@",scrollView.subviews);
    if(((int)scrollView.contentOffset.x%(int)_size.width) > (_size.width/2)){
        _pageControl.currentPage = (int)scrollView.contentOffset.x / (int)_size.width + 1;
    }else{
        _pageControl.currentPage = scrollView.contentOffset.x / _size.width;
    }
}
//等比例缩放图片
- (CGRect)scaleWithImage:(UIImage *)image index:(int)index{
    
    CGRect rect;
    CGFloat imageScale = image.size.width / image.size.height;
    if (image.size.width > image.size.height) {     //图片比较宽
        rect = CGRectMake(_size.width * index, (_size.height - _size.width / imageScale) / 2.0, _size.width, _size.width / imageScale);
    }else{      //图片比较长
        rect = CGRectMake((_size.width - _size.width * imageScale) / 2.0 + _size.width * index,
                          0, _size.width * imageScale, _size.height);
    }
    return rect;
}

- (void)tapAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
