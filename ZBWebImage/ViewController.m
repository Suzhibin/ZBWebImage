//
//  ViewController.m
//  ZBWebImage
//
//  Created by NQ UEC on 17/3/14.
//  Copyright © 2017年 Suzhibin. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

        
        UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button1 setTitle:@"进入加载图片页面" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
        button1.backgroundColor=[UIColor brownColor];
        button1.frame=CGRectMake(100,200,150, 30);
        [button1 addTarget:self action:@selector(button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button1];
    

    
}
- (void)button1Clicked:(UIButton *)sender{

    ImageViewController *imageVC=[[ImageViewController alloc]init];
    
    [self presentViewController:imageVC animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
