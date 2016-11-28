//
//  Dic2ModelViewController.m
//  CSCUtil
//
//  Created by csc on 16/10/20.
//  Copyright © 2016年 csc. All rights reserved.
//

#import "Dic2ModelViewController.h"

@interface Dic2ModelViewController ()

@end

@implementation Dic2ModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSDictionary *dataDict = dict[@"product"];
    Product *p = [Product objectWithDictionary:dataDict];
    NSLog(@"%@", p.name);
    
    for (ProductList *product in p.productList)
    {
        NSLog(@"%@----%@----%.1f", product.name, product.productId, product.price);
        NSLog(@"%@----%@----%.1f----%.1f", product.image.imageUrl, product.image.imageId, product.image.width, product.image.height);
    }
    
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
