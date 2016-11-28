//
//  TestViewController.m
//  CSCUtil
//
//  Created by csc on 16/10/9.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "TestViewController.h"
//#import "UIImage+CSCategory.h"
#import <MessageUI/MessageUI.h>
@interface TestViewController ()<MFMailComposeViewControllerDelegate>
{
    NSData * sdata;
}
//下载任务
@property (nonatomic, strong)NSURLSessionDownloadTask *downTask;

//网络会话
@property (nonatomic, strong)NSURLSession * downLoadSession;

@property (nonatomic, strong) UIImage * cimage;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   // [self testImg];
    
    //发送邮件
    [self createButton];
    
    //保存pdf
    [self createPdfBtn];
}

-(void)createPdfBtn
{
    UIButton * pdfBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pdfBtn setTitle:@"PDFBTN" forState:UIControlStateNormal];
    [pdfBtn addTarget:self action:@selector(pdfBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    pdfBtn.frame = CGRectMake(100, 100, 150, 50);
    [self.view addSubview:pdfBtn];
}

-(void)pdfBtnClick:(UIButton *)btn
{
    //to convert pdf to NSData
    NSString *pdfPath = [[NSBundle mainBundle] pathForResource:@"atiao" ofType:@"pdf"];
    NSData *myData = [NSData dataWithContentsOfFile:pdfPath];
    
    
    
    //to convert NSData to pdf
    NSData *data               = myData;
    CFDataRef myPDFData        = (__bridge CFDataRef)data;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(myPDFData);
    CGPDFDocumentRef pdf       = CGPDFDocumentCreateWithProvider(provider);
    
    
    
    NSString *string=[NSString stringWithFormat:@"%@.pdf",@"ppd"];
    NSLog(@"lala------->>>>%@",[self getDBPathPDf:string]);
   [myData writeToFile:[self getDBPathPDf:string] atomically:YES];
    
}

-(NSString *) getDBPathPDf:(NSString *)PdfName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:PdfName];
}


-(void)testImg
{
    UIImageView * sImgv = [[UIImageView alloc]init];
    sImgv.frame = CGRectMake(60, 100, 200, 100);
    [self.view addSubview:sImgv];
    [sImgv setImage:[UIImage imagesNamedFromName:@"banner"]];
    
    sImgv.l_x = 5;
    
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://www.ulpay.com/static_resources/static/img/activity/ios/jcb/for-me-for-ta@3x.png"]]];
//    [sImgv setImage:image];
//    
    [self loadIamgeWithURL:@"https://www.ulpay.com/static_resources/static/img/activity/ios/jcb/for-me-for-ta@3x.png"];
    
    
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingView.hidesWhenStopped = YES;
    [self.view addSubview:loadingView];
    
}

-(void)createButton
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"发送邮件" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 300, 158, 50);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(showEmail) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)loadIamgeWithURL:(NSString *)urlString
{
    
    //创建下载图片的url
    NSURL *url = [NSURL URLWithString:urlString];
    
    //创建网络请求配置类
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //创建网络会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue new]];
    
    //创建请求并设置缓存策略以及超时时长
    NSURLRequest *imgRequest = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:30.f];
    //*也可通过configuration.requestCachePolicy 设置缓存策略
    
    //创建一个下载任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:imgRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //下载完成后获取数据 此时已经自动缓存到本地，下次会直接从本地缓存获取，不再进行网络请求
        NSData * data = [NSData dataWithContentsOfURL:location];
        
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //设置图片
            self.cimage = [UIImage imageWithData:data];
        });
        
        
    }];
    
    
    //启动下载任务
    [task resume];

}

-(void)showEmail
{
    NSString * file = @"atiao.pdf";
    NSString *emailTitle = @"Great Photo and Doc";
    NSString *messageBody = @"Hey, check this out!";
    NSArray *toRecipents = [NSArray arrayWithObject:@"786452556@qq.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if (!mc) {
        // 在设备还没有添加邮件账户的时候mailViewController为空，下面的present view controller会导致程序崩溃，这里要作出判断
        NSLog(@"设备还没有添加邮件账户");
        return;
    }
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Determine the file name and extension
    NSArray *filepart = [file componentsSeparatedByString:@"."];
    NSString *filename = [filepart objectAtIndex:0];
    NSString *extension = [filepart objectAtIndex:1];
    
    // Get the resource path and read the file using NSData
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    
    NSData *pdfData = [NSData dataWithContentsOfFile:[self getDBPathPDf:@"ppd.pdf"]];
    
    // Determine the MIME type
    NSString *mimeType;
    if ([extension isEqualToString:@"jpg"]) {
        mimeType = @"image/jpeg";
    } else if ([extension isEqualToString:@"png"]) {
        mimeType = @"image/png";
    } else if ([extension isEqualToString:@"doc"]) {
        mimeType = @"application/msword";
    } else if ([extension isEqualToString:@"ppt"]) {
        mimeType = @"application/vnd.ms-powerpoint";
    } else if ([extension isEqualToString:@"html"]) {
        mimeType = @"text/html";
    } else if ([extension isEqualToString:@"pdf"]) {
        mimeType = @"application/pdf";
    }
    
    // Add attachment
    [mc addAttachmentData:pdfData mimeType:mimeType fileName:@"ppd.pdf"];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
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
