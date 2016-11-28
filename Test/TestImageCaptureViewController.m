//
//  TestImageCaptureViewController.m
//  CSCUtil
//
//  Created by csc on 16/10/18.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "TestImageCaptureViewController.h"
#import "UIImage+capture.h"
@interface TestImageCaptureViewController ()
@property (strong, nonatomic) UIScrollView * bgScrollView;
@end

@implementation TestImageCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

-(void)createUI
{
    self.bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.bgScrollView];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 300, 200)];
    lab.numberOfLines = 0;
    lab.text = @"负担开发奖开反倒龙发金矿啦就疯狂龙三卡拉负担空发奖开发酵开动发酵开动撒娇翻开东三卡了负担空啦反倒龙发酵开动发酵开动伐开单控A级疯狂甲A开发单开撒反倒龙 分但凯撒就分开但萨芬将凯撒饭狂三甲A开发刀龙发开动";
    [self.bgScrollView addSubview:lab];
    
    
    UIImageView * img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 350, 300, 300)];
    [img1 setImage:[UIImage imageNamed:@"bar"]];
    [self.bgScrollView addSubview:img1];
    
    
    UIImageView * img2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 700, 300, 300)];
    [img2 setImage:[UIImage imageNamed:@"chu"]];
    [self.bgScrollView addSubview:img2];
    
    self.bgScrollView.contentSize = CGSizeMake(0, 1100);
    
    
    
    UIButton * jieping = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [jieping setTitle:@"截屏" forState:UIControlStateNormal];
    jieping.frame = CGRectMake(0, 0, 30, 30);
    //可以截取整个scrollview的内容
    //[jieping addTarget:self action:@selector(jiepingAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //截取的是当前所见的内容
    //[jieping addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:jieping];
}



-(void)jiepingAction:(UIButton *)btn {

    CGPoint savedContentOffset = self.bgScrollView.contentOffset;
    CGRect savedFrame = self.bgScrollView.frame;
    
    UIScrollView * _scrollView = self.bgScrollView;
    _scrollView.contentOffset = CGPointZero;
    _scrollView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , _scrollView.contentSize.height);
    UIGraphicsBeginImageContextWithOptions(_scrollView.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [_scrollView.layer renderInContext:ctx];
    //[self.view.layer drawInContext:ctx];
    
    //3.从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    _scrollView.contentOffset = savedContentOffset;
    _scrollView.frame = savedFrame;
    //4.关闭上下文
    UIGraphicsEndImageContext();
    NSData *data = UIImagePNGRepresentation(newImage);
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"路径---%@",docDir);
    [data writeToFile:[NSString stringWithFormat:@"%@/newImg.png",docDir] atomically:YES];
    
}

- (UIImage *)captureScrollView:(UIScrollView *)scrollView
{
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, NO, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}



-(void)btnAction:(UIButton *)btn  {
    
    //把控制器的View生成一张图片
    
    //1.开启一个位图上下文(跟当前控制器View一样大小的尺寸)
    
    
    /**
     *开启一个位图上下文:1:第一个参数为上下文的size 2：第二个参数为不透明，传no，代表透明 3：第三个分辨率，传0系统会默认根据根据分辨率去设置
     */
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    
    
    
    /**
     * 1：此时需要获取当前的上下文，类型为CGContextRef  2：view上之所以能显示各种UI控件，是因为是系统将这些UI控件渲染到了view的layer的图层上，才能显示出来
     2：把view绘制到上下文上，必须将view的layer渲染到上下文，像是图片或是一些形状直接画到上下文就可以了
     *
     */
    
    //把把控制器的View绘制到上下文当中.
    //2.想要把UIView上面的东西给绘制到上下文当中,必须得要使用渲染的方式.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.view.layer renderInContext:ctx];
    //[self.view.layer drawInContext:ctx];
    
    //3.从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //4.关闭上下文
    UIGraphicsEndImageContext();
    
    //把生成的图片写入到桌面(文件方式进行传输:二进制流NSData)
    //把图片转成二进制流NSData
    //NSData *data = http://www.cnblogs.com/cqb-learner/p/UIImageJPEGRepresentation(newImage, 1);
    
    /**
     * 1：将图片写入文件里：需要将图片首先转化为二进制流的形式NSData，才可以writeToFile写入文件，此方法支持写入文件的类型为，NSStrig，NSDictrary，NSArray，BOOL,NSDate，NSData，NSNumber，数据或是字典中装入的对象也必须是上述类型，否则会报错。
     * 2：将图片转化为二进制流，用UIImagePNGRepresentation，UIImageJPEGRepresentation，其中png为最高清的图片，JPEG有压缩比例，比例越大越不清晰，返回值都是NSData
     */
    NSData *data = UIImagePNGRepresentation(newImage);
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSLog(@"路径---%@",docDir);
    [data writeToFile:[NSString stringWithFormat:@"%@/kkImg.png",docDir] atomically:YES];
    
    
    
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
