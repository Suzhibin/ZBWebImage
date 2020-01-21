//
//  ImageViewController.m
//  ZBWebImage
//
//  Created by NQ UEC on 17/3/14.
//  Copyright © 2017年 Suzhibin. All rights reserved.
//

#import "ImageViewController.h"
#import "ZBWebImageManager.h"
#import "UIImageView+ZBWebCache.h"
#define IMAGE1   @"http://t8.baidu.com/it/u=1484500186,1503043093&fm=79&app=86&f=JPEG?w=1280&h=853"

#define IMAGE2   @"http://t9.baidu.com/it/u=1307125826,3433407105&fm=79&app=86&f=JPEG?w=5760&h=3240"
//屏幕宽
#define SCREEN_WIDTH                ([UIScreen mainScreen].bounds.size.width)
//屏幕高
#define SCREEN_HEIGHT               ([UIScreen mainScreen].bounds.size.height)
@interface ImageViewController ()
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"cachePath = %@",cachePath);
    
    UIButton *dismiss=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [dismiss setTitle:@"返回上一页" forState:UIControlStateNormal];
    [dismiss setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dismiss.backgroundColor=[UIColor brownColor];
    dismiss.frame=CGRectMake(20,60,100, 30);
    [dismiss addTarget:self action:@selector(dismissClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismiss];
    


    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10,560, 200, 30)];
    label1.textAlignment=NSTextAlignmentLeft;
    label1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:label1];
    self.label1=label1;
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10,600, 200, 30)];
    label2.textAlignment=NSTextAlignmentLeft;
    label2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:label2];
    self.label2=label2;
    
    self.imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 94, SCREEN_WIDTH, 200)];
    
    [self.view addSubview:self.imageView1];
    
    [self.imageView1 zb_setImageWithURL:IMAGE1 placeholderImage:[UIImage imageNamed:@"zhanweitu"] completion:^(UIImage *image) {
        //下载完毕显示缓存大小
        [self sizeAndCount];
        
    }];
    
    self.imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 330, SCREEN_WIDTH, 200)];
    [[ZBWebImageManager sharedInstance]  downloadImageUrl:IMAGE2 completion:^(UIImage *image){
        
        self.imageView2.image=image;
        //下载完毕显示缓存大小
        [self sizeAndCount];
    }];
    
    [self.view addSubview:self.imageView2];
    
    
    NSArray *array=[NSArray arrayWithObjects:@"清除所有图片缓存",@"清除某一个图片缓存",nil];
    
    for (int i = 0; i<array.count; i++) {
        
        UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button1 setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button1.tag=2000+i;
        button1.backgroundColor=[UIColor brownColor];
        button1.frame=CGRectMake(200,560+40*i,150, 30);
        [button1 addTarget:self action:@selector(button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button1];
    }
    
    
    
}
- (void)button1Clicked:(UIButton *)sender{
    
    NSArray *imageArray = @[IMAGE1,IMAGE2];
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    if (sender.tag==2000) {
        //删除图片缓存 及完成操作
        [[ZBWebImageManager sharedInstance] clearImageFileCompletion:^{
            [self sizeAndCount];
        }];
        
    }else if (sender.tag==2001){
        //删除单个图片缓存 及完成操作
        [[ZBWebImageManager sharedInstance] clearImageForkey:imageUrl completion:^{
            [self sizeAndCount];
        }];
    }
    
}
- (void)sizeAndCount{
    float imageSize=[[ZBWebImageManager sharedInstance] imageFileSize];//图片大小
    self.label1.text=[NSString stringWithFormat:@"缓存图片大小:%@",[[ZBCacheManager sharedInstance] fileUnitWithSize:imageSize]];
    
    float count=[[ZBWebImageManager sharedInstance] imageFileCount];//个数
    self.label2.text=[NSString stringWithFormat:@"缓存图片数量:%.f",count];
}

- (void)dismissClicked:(UIButton *)sender{
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
