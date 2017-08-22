//
//  ViewController.m
//  GIFDemo
//
//  Created by Paddy on 17/8/22.
//  Copyright © 2017年 Paddy. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+GIF.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UIImageView *myImgView;
@property (weak, nonatomic) IBOutlet UIImageView *myImgView02;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadGifWithWebView];
    
    [self loadGifBundleWithImageView];

    [self loadGifWithImageView];
}

#pragma mark - 使用UIWebView
- (void)loadGifWithWebView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gif01" ofType:@"gif"];
    
    /*
     NSData *data = [NSData dataWithContentsOfFile:path];
     使用loadData:MIMEType:textEncodingName: 则有警告
     [self.myWebView loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
     */
    
    NSURL *url = [NSURL URLWithString:path];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - 使用Bundle打包,用ImageView加载
- (NSArray *)animationImages
{
    NSFileManager *fielM = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gif02" ofType:@"bundle"];
    NSArray *arrays = [fielM contentsOfDirectoryAtPath:path error:nil];
    
    NSMutableArray *imagesArr = [NSMutableArray array];
    for (NSString *name in arrays) {
        UIImage *image = [UIImage imageNamed:[(@"gif02.bundle") stringByAppendingPathComponent:name]];
        if (image) {
            [imagesArr addObject:image];
        }
    }
    return imagesArr;
}

- (void)loadGifBundleWithImageView
{
    self.myImgView.animationImages = [self animationImages]; //获取Gif图片列表
    self.myImgView.animationDuration = 5;     //执行一次完整动画所需的时长
    self.myImgView.animationRepeatCount = 0;  //动画重复次数
    [self.myImgView startAnimating];
}


#pragma mark - SDWebImage内部解析gif数据
- (void)loadGifWithImageView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gif03" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    self.myImgView02.image = image;
}

@end
