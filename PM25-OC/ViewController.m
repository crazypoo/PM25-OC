//
//  ViewController.m
//  PM25-OC
//
//  Created by 邓杰豪 on 15/5/31.
//  Copyright (c) 2015年 邓杰豪. All rights reserved.
//

#import "ViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "TFHpple.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tbView;
    NSMutableArray *indexSet;
    NSArray *dataSet;
    NSDictionary *pm25Data;
    NSString *url;
    NSString *city;
    NSString *cityL;
    NSString *levleL;
    NSString *updateTimeL;
    NSString *unitL;
    NSString *aqiLl;
    NSString *pollutantL;
    NSString *affectL;
    NSString *actionL;
    NSString *aqiL;
    NSString *pm25L;
    NSString *pm10L;
    NSString *coL;
    NSString *no2L;
    NSString *o31L;
    NSString *o38L;
    NSString *so2L;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"PM2.5";
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
    
    pm25Data = @{@"葫芦岛":@"http://www.pm25.in/huludao",@"泉州":@"http://www.pm25.in/quanzhou",@"赤峰":@"http://www.pm25.in/chifeng",@"营口":@"http://www.pm25.in/yingkou",@"大连":@"http://www.pm25.in/dalian",@"瓦房店":@"http://www.pm25.in/wafangdian",@"厦门":@"http://www.pm25.in/xiamen",@"湛江":@"http://www.pm25.in/zhanjiang",@"盘锦":@"http://www.pm25.in/panjin",@"海口":@"http://www.pm25.in/haikou",@"蓬莱":@"http://www.pm25.in/penglai",@"吉林":@"http://www.pm25.in/jilin",@"汕头":@"http://www.pm25.in/shantou",@"福州":@"http://www.pm25.in/fuzhou",@"大庆":@"http://www.pm25.in/daqing",@"三亚":@"http://www.pm25.in/sanya",@"锦州":@"http://www.pm25.in/jinzhou",@"梅州":@"http://www.pm25.in/meizhou",@"深圳":@"http://www.pm25.in/shenzhen",@"舟山":@"http://www.pm25.in/zhoushan",@"秦皇岛":@"http://www.pm25.in/qinhuangdao",@"肇庆":@"http://www.pm25.in/zhaoqing",@"烟台":@"http://www.pm25.in/yantai",@"哈尔滨":@"http://www.pm25.in/haerbin",@"承德":@"http://www.pm25.in/chengde",@"齐齐哈尔":@"http://www.pm25.in/qiqihaer",@"中山":@"http://www.pm25.in/zhongshan",@"珠海":@"http://www.pm25.in/zhuhai",@"阳江":@"http://www.pm25.in/yangjiang",@"玉溪":@"http://www.pm25.in/yuxi",@"西宁":@"http://www.pm25.in/xining",@"台州":@"http://www.pm25.in/taizhou",@"潮州":@"http://www.pm25.in/chaozhou",@"宁波":@"http://www.pm25.in/ningbo",@"荣成":@"http://www.pm25.in/rongcheng",@"乳山":@"http://www.pm25.in/rushan",@"张家口":@"http://www.pm25.in/zhangjiakou",@"抚顺":@"http://www.pm25.in/fushun",@"东莞":@"http://www.pm25.in/dongguan",@"泰安":@"http://www.pm25.in/taian",@"沈阳":@"http://www.pm25.in/shenyang",@"莱州":@"http://www.pm25.in/laizhou",@"云浮":@"http://www.pm25.in/yunfu",@"文登":@"http://www.pm25.in/wendeng",@"本溪":@"http://www.pm25.in/benxi",@"河源":@"http://www.pm25.in/heyuan",@"汕尾":@"http://www.pm25.in/shanwei",@"威海":@"http://www.pm25.in/weihai",@"揭阳":@"http://www.pm25.in/jieyang",@"温州":@"http://www.pm25.in/wenzhou",@"清远":@"http://www.pm25.in/qingyuan",@"平度":@"http://www.pm25.in/pingdu",@"曲靖":@"http://www.pm25.in/qujing",@"惠州":@"http://www.pm25.in/huizhou",@"北海":@"http://www.pm25.in/beihai",@"昆明":@"http://www.pm25.in/kunming",@"茂名":@"http://www.pm25.in/maoming",@"德州":@"http://www.pm25.in/dezhou",@"鞍山":@"http://www.pm25.in/anshan",@"招远":@"http://www.pm25.in/zhaoyuan",@"宝鸡":@"http://www.pm25.in/baoji",@"滨州":@"http://www.pm25.in/binzhou",@"银川":@"http://www.pm25.in/yinchuan",@"廊坊":@"http://www.pm25.in/langfang",@"北京":@"http://www.pm25.in/beijing",@"呼和浩特":@"http://www.pm25.in/huhehaote",@"丹东":@"http://www.pm25.in/dandong",@"长春":@"http://www.pm25.in/changchun",@"青岛":@"http://www.pm25.in/qingdao",@"金昌":@"http://www.pm25.in/jinchang",@"即墨":@"http://www.pm25.in/jimo",@"盐城":@"http://www.pm25.in/yancheng",@"大同":@"http://www.pm25.in/datong",@"韶关":@"http://www.pm25.in/shaoguan",@"莱西":@"http://www.pm25.in/laixi",@"洛阳":@"http://www.pm25.in/luoyang",@"长治":@"http://www.pm25.in/changzhi",@"上海":@"http://www.pm25.in/shanghai",@"开封":@"http://www.pm25.in/kaifeng",@"库尔勒":@"http://www.pm25.in/kuerle",@"重庆":@"http://www.pm25.in/chongqing",@"克拉玛依":@"http://www.pm25.in/kelamayi",@"嘉峪关":@"http://www.pm25.in/jiayuguan",@"柳州":@"http://www.pm25.in/liuzhou",@"咸阳":@"http://www.pm25.in/xianyang",@"莱芜":@"http://www.pm25.in/laiwu",@"天津":@"http://www.pm25.in/tianjin",@"太原":@"http://www.pm25.in/taiyuan",@"石家庄":@"http://www.pm25.in/shijiazhuang",@"济宁":@"http://www.pm25.in/jining",@"包头":@"http://www.pm25.in/baotou",@"宜宾":@"http://www.pm25.in/yibin",@"淄博":@"http://www.pm25.in/zibo",@"乌鲁木齐":@"http://www.pm25.in/wulumuqi",@"泸州":@"http://www.pm25.in/luzhou",@"自贡":@"http://www.pm25.in/zigong",@"唐山":@"http://www.pm25.in/tangshan",@"海门":@"http://www.pm25.in/haimen",@"江门":@"http://www.pm25.in/jiangmen",@"贵阳":@"http://www.pm25.in/guiyang",@"章丘":@"http://www.pm25.in/zhangqiu",@"邢台":@"http://www.pm25.in/xingtai",@"鄂尔多斯":@"http://www.pm25.in/eerduosi",@"广州":@"http://www.pm25.in/guangzhou",@"阳泉":@"http://www.pm25.in/yangquan",@"牡丹江":@"http://www.pm25.in/mudanjiang",@"三门峡":@"http://www.pm25.in/sanmenxia",@"南宁":@"http://www.pm25.in/nanning",@"吴江":@"http://www.pm25.in/wujiang",@"西安":@"http://www.pm25.in/xian",@"石嘴山":@"http://www.pm25.in/shizuishan",@"铜川":@"http://www.pm25.in/tongchuan",@"攀枝花":@"http://www.pm25.in/panzhihua",@"佛山":@"http://www.pm25.in/foshan",@"荆州":@"http://www.pm25.in/jingzhou",@"胶州":@"http://www.pm25.in/jiaozhou",@"枣庄":@"http://www.pm25.in/zaozhuang",@"平顶山":@"http://www.pm25.in/pingdingshan",@"胶南":@"http://www.pm25.in/jiaonan",@"兰州":@"http://www.pm25.in/lanzhou",@"遵义":@"http://www.pm25.in/zunyi",@"保定":@"http://www.pm25.in/baoding",@"昆山":@"http://www.pm25.in/kunshan",@"丽水":@"http://www.pm25.in/lishui",@"常熟":@"http://www.pm25.in/changshu",@"太仓":@"http://www.pm25.in/taicang",@"徐州":@"http://www.pm25.in/xuzhou",@"寿光":@"http://www.pm25.in/shouguang",@"绵阳":@"http://www.pm25.in/mianyang",@"东营":@"http://www.pm25.in/dongying",@"渭南":@"http://www.pm25.in/weinan",@"济南":@"http://www.pm25.in/jinan",@"延安":@"http://www.pm25.in/yanan",@"焦作":@"http://www.pm25.in/jiaozuo",@"郑州":@"http://www.pm25.in/zhengzhou",@"安阳":@"http://www.pm25.in/anyang",@"南通":@"http://www.pm25.in/nantong",@"邯郸":@"http://www.pm25.in/handan",@"潍坊":@"http://www.pm25.in/weifang",@"成都":@"http://www.pm25.in/chengdu",@"张家界":@"http://www.pm25.in/zhangjiajie",@"衢州":@"http://www.pm25.in/quzhou",@"衡水":@"http://www.pm25.in/hengshui",@"临汾":@"http://www.pm25.in/linfen",@"聊城":@"http://www.pm25.in/liaocheng",@"嘉兴":@"http://www.pm25.in/jiaxing",@"宜昌":@"http://www.pm25.in/yichang",@"菏泽":@"http://www.pm25.in/heze",@"桂林":@"http://www.pm25.in/guilin",@"江阴":@"http://www.pm25.in/jiangyin",@"张家港":@"http://www.pm25.in/zhangjiagang",@"常德":@"http://www.pm25.in/changde",@"宿迁":@"http://www.pm25.in/suqian",@"岳阳":@"http://www.pm25.in/yueyang",@"长沙":@"http://www.pm25.in/changsha",@"南充":@"http://www.pm25.in/nanchong",@"杭州":@"http://www.pm25.in/hangzhou",@"湘潭":@"http://www.pm25.in/xiangtan",@"沧州":@"http://www.pm25.in/cangzhou",@"拉萨":@"http://www.pm25.in/lasa",@"常州":@"http://www.pm25.in/changzhou",@"宜兴":@"http://www.pm25.in/yixing",@"苏州":@"http://www.pm25.in/suzhou",@"株洲":@"http://www.pm25.in/zhuzhou",@"南昌":@"http://www.pm25.in/nanchang",@"无锡":@"http://www.pm25.in/wuxi",@"淮安":@"http://www.pm25.in/huaian",@"富阳":@"http://www.pm25.in/fuyang",@"绍兴":@"http://www.pm25.in/shaoxing",@"临沂":@"http://www.pm25.in/linyi",@"湖州":@"http://www.pm25.in/huzhou",@"九江":@"http://www.pm25.in/jiujiang",@"泰州":@"http://www.pm25.in/taizhoushi",@"日照":@"http://www.pm25.in/rizhao",@"溧阳":@"http://www.pm25.in/liyang",@"德阳":@"http://www.pm25.in/deyang",@"临安":@"http://www.pm25.in/linan",@"连云港":@"http://www.pm25.in/lianyungang",@"金华":@"http://www.pm25.in/jinhua",@"义乌":@"http://www.pm25.in/yiwu",@"芜湖":@"http://www.pm25.in/wuhu",@"诸暨":@"http://www.pm25.in/zhuji",@"马鞍山":@"http://www.pm25.in/maanshan",@"金坛":@"http://www.pm25.in/jintan",@"武汉":@"http://www.pm25.in/wuhan",@"镇江":@"http://www.pm25.in/zhenjiang",@"南京":@"http://www.pm25.in/nanjing",@"扬州":@"http://www.pm25.in/yangzhou",@"句容":@"http://www.pm25.in/jurong",@"合肥":@"http://www.pm25.in/hefei"};

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
    [SVProgressHUD show];
    url = pm25Data[dataSet[indexPath.section][indexPath.row]];
    city = dataSet[indexPath.section][indexPath.row];
    [self getData];

}

-(void)getData
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:NSOperationQueue.mainQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError != nil) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:connectionError.localizedDescription delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            [SVProgressHUD dismiss];
        }
        else
        {
            [self parseData:data];
            [SVProgressHUD dismiss];
        }
    }];
}

-(void)parseData:(NSData *)data
{
    TFHpple *doc = [TFHpple hppleWithHTMLData:data encoding:@"UTF8"];
    TFHppleElement *cityE = [doc peekAtSearchWithXPathQuery:@"//div[@class='city_name']/h2"];
    cityL = cityE.firstChild.content;
    
    TFHppleElement *level = [doc peekAtSearchWithXPathQuery:@"//div[@class='level']/h4"];
    levleL = level.firstChild.content;
    
    TFHppleElement *uptime = [doc peekAtSearchWithXPathQuery:@"//div[@class='live_data_time']/p"];
    updateTimeL = uptime.firstChild.content;
    
    TFHppleElement *unit = [doc peekAtSearchWithXPathQuery:@"//div[@class='live_data_unit']"];
    unitL = unit.firstChild.content;
    
    NSArray *caption = [doc searchWithXPathQuery:@"//div[@class='span1']/div[@class='caption']"];
    NSArray *value = [doc searchWithXPathQuery:@"//div[@class='span1']/div[@class='value']"];
    
    NSMutableArray *capArr = [[NSMutableArray alloc] init];
    NSMutableArray *valArr = [[NSMutableArray alloc] init];
    
    for (TFHppleElement *c in caption) {
        [capArr addObject:[[c.firstChild.content stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    }
    
    for (TFHppleElement *c in value) {
        [valArr addObject:[[c.firstChild.content stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    }
    
    aqiL = [NSString stringWithFormat:@"%@  :  %@",capArr[0],valArr[0]];
    pm25L = [NSString stringWithFormat:@"%@  :  %@",capArr[1],valArr[1]];
    pm10L = [NSString stringWithFormat:@"%@  :  %@",capArr[2],valArr[2]];
    coL = [NSString stringWithFormat:@"%@  :  %@",capArr[3],valArr[3]];
    no2L = [NSString stringWithFormat:@"%@  :  %@",capArr[4],valArr[4]];
    o31L = [NSString stringWithFormat:@"%@  :  %@",capArr[5],valArr[5]];
    o38L = [NSString stringWithFormat:@"%@  :  %@",capArr[6],valArr[6]];
    so2L = [NSString stringWithFormat:@"%@  :  %@",capArr[7],valArr[7]];
    
    TFHppleElement *pollutant = [doc peekAtSearchWithXPathQuery:@"//div[@class='primary_pollutant']/p"];
    pollutantL = [[pollutant.firstChild.content stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    TFHppleElement *affect = [doc peekAtSearchWithXPathQuery:@"//div[@class='affect']/p"];
    affectL = [[affect.firstChild.content stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    TFHppleElement *action = [doc peekAtSearchWithXPathQuery:@"//div[@class='action']/p"];
    actionL = [[action.firstChild.content stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *infoStr = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n\n%@\n\n%@\n\n%@",levleL,updateTimeL,unitL,aqiL,pm25L,pm10L,coL,no2L,o31L,o38L,so2L,pollutantL,affectL,actionL];
    [[[UIAlertView alloc] initWithTitle:city message:infoStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
