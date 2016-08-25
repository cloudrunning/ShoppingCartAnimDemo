//
//  ViewController.m
//  PruchaseCarAnimation
//
//  Created by zhenyong on 16/8/17.
//  Copyright © 2016年 com.demo. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
//#import "PurchaseCarAnimationTool.h"
#import "HSShoppingCartAniTool.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong , nonatomic) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    CGPoint thirdTabbarItemTopCenterPoint = CGPointMake(kScreenWidth * 2.5 / 4, kScreenHeight - 49);
    [HSShoppingCartAniTool shareInstance].finishPoint = thirdTabbarItemTopCenterPoint;
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)setUI
{
    if (_isList) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
        [tableView reloadData];
        [self.view addSubview:tableView];
    }
    else
    {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 80, 80)];
        [self.view addSubview:_imageView];
        [_imageView setImage:[UIImage imageNamed:@"watch"]];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 130, 42)];
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"加入购物车" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(clickCar) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark -- Delegate and DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    
    cell.clickCars = ^(UIImageView *imageView){
        CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
        //获取当前cell 相对于self.view 当前的坐标
        rect.origin.y = rect.origin.y - [tableView contentOffset].y;
        CGRect imageViewRect = imageView.frame;
        imageViewRect.origin.y = rect.origin.y+imageViewRect.origin.y;
        
    
        
        [[HSShoppingCartAniTool shareInstance]startAniView:imageView rect:imageViewRect finishBlock:^(BOOL finish) {
            UIView *thirdTabBarItem = [self.tabBarController.tabBar subviews][3];
            [HSShoppingCartAniTool addShakeAni:thirdTabBarItem];
        }];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 114;
}
-(void)clickCar
{
  
    [[HSShoppingCartAniTool shareInstance]startAniView:_imageView rect:_imageView.frame finishBlock:^(BOOL finish) {
        UIView *thirdTabBarItem = [self.tabBarController.tabBar subviews][3];
        [HSShoppingCartAniTool addShakeAni:thirdTabBarItem];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
