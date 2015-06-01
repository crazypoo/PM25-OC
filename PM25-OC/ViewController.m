//
//  ViewController.m
//  PM25-OC
//
//  Created by 邓杰豪 on 15/5/31.
//  Copyright (c) 2015年 邓杰豪. All rights reserved.
//

#import "ViewController.h"
#import "PCityPM25InfoViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tbView;
    NSMutableArray *indexSet;
    NSArray *dataSet;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tbView.dataSource = self;
    tbView.delegate = self;
    [self.view addSubview:tbView];
    
    indexSet = [NSMutableArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z", nil];
    
    dataSet = @[
                @[@"鞍山",@"安阳"],
                @[@"保定",@"宝鸡",@"包头",@"北海",@"北京",@"本溪",@"滨州"],
                @[@"沧州",@"长春",@"常德",@"长沙",@"常熟",@"长治",@"常州",@"潮州",@"承德",@"成都",@"赤峰",@"重庆"],
                @[@"大连",@"丹东",@"大庆",@"大同",@"德阳",@"德州",@"东莞",@"东营"],
                @[@"鄂尔多斯"],
                @[@"佛山",@"抚顺",@"富阳",@"福州"],
                @[@"广州",@"桂林",@"贵阳"],
                @[@"哈尔滨",@"海口",@"海门",@"邯郸",@"杭州",@"合肥",@"衡水",@"河源",@"菏泽",@"淮安",@"呼和浩特",@"惠州",@"葫芦岛",@"湖州"],
                @[@"江门",@"江阴",@"胶南",@"胶州",@"焦作",@"嘉兴",@"嘉峪关",@"揭阳",@"吉林",@"即墨",@"济南",@"金昌",@"荆州",@"金华",@"济宁",@"金坛",@"锦州",@"九江",@"句容"],
                @[@"开封",@"克拉玛依",@"库尔勒",@"昆明",@"昆山"],
                @[@"莱芜",@"莱西",@"莱州",@"廊坊",@"兰州",@"拉萨",@"连云港",@"聊城",@"临安",@"临汾",@"临沂",@"丽水",@"柳州",@"溧阳",@"洛阳",@"泸州"],
                @[@"马鞍山",@"茂名",@"梅州",@"绵阳",@"牡丹江"],
                @[@"南昌",@"南充",@"南京",@"南宁",@"南通",@"宁波"],
                @[@"盘锦",@"攀枝花",@"蓬莱",@"平顶山",@"平度"],
                @[@"青岛",@"清远",@"秦皇岛",@"齐齐哈尔",@"泉州",@"曲靖",@"衢州"],
                @[@"日照",@"荣成",@"乳山"],
                @[@"三门峡",@"三亚",@"上海",@"汕头",@"汕尾",@"韶关",@"绍兴",@"沈阳",@"深圳",@"石家庄",@"石嘴山",@"寿光",@"宿迁",@"苏州"],
                @[@"泰安",@"太仓",@"太原",@"台州",@"泰州",@"唐山",@"天津",@"铜川"],
                @[@"瓦房店",@"潍坊",@"威海",@"渭南",@"文登",@"温州",@"武汉",@"芜湖",@"吴江",@"乌鲁木齐",@"无锡"],
                @[@"厦门",@"西安",@"湘潭",@"咸阳",@"邢台",@"西宁",@"徐州"],
                @[@"延安",@"盐城",@"阳江",@"阳泉",@"扬州",@"烟台",@"宜宾",@"宜昌",@"银川",@"营口",@"义乌",@"宜兴",@"岳阳",@"云浮",@"玉溪"],
                @[@"枣庄",@"张家港",@"张家界",@"张家口",@"章丘",@"湛江",@"肇庆",@"招远",@"郑州",@"镇江",@"中山",@"舟山",@"珠海",@"诸暨",@"株洲",@"淄博",@"自贡",@"遵义"]
                ];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return indexSet;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return indexSet.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return indexSet[section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSet[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *searchIdentifier = @"search Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchIdentifier];
    }
    else
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.textLabel.text = dataSet[indexPath.section][indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCityPM25InfoViewController *d = [[PCityPM25InfoViewController alloc] initWithCityName:dataSet[indexPath.section][indexPath.row]];
    [self.navigationController pushViewController:d animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
