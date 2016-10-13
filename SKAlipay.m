//
//  SKAlipay.m
//  SKZQ
//
//  Created by 沙少盼 on 16/10/12.
//  Copyright © 2016年 时刻足球. All rights reserved.
//

#import "SKAlipay.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation SKAlipay
- (void)setModel:(T_MallCommodityModel *)model{
    _model = model;
}
/** 用订单号签名并支付 */
- (void)payWithOrderId:(NSString *)orderId{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [[Order alloc]init];
    // NOTE: app_id设置
    order.app_id = @"2016092601975470";
    // NOTE: 支付接口名称
    order.method = ALIPAY_TRADE_APP_PAY;
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    // NOTE: 支付版本
    order.version = @"1.0";
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    order.notify_url = [NSString stringWithFormat:@"%@userOrder/notify",MAINURL];
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"1";
    order.biz_content.subject = _model.mallCommodityName;
    order.biz_content.out_trade_no = orderId; //订单ID（由商家自行制定）
    SKLog(@"%zd",order.biz_content.out_trade_no.length);
    order.biz_content.timeout_express = @"60m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", [_model.money floatValue] * [_model.quantity integerValue]]; //商品价格
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    SKLog(@"%@",orderInfoEncoded);
    NSString *url = [NSString stringWithFormat:@"%@userOrder/getSign",MAINURL];
    NSDictionary *para = @{@"SARRAY":orderInfo};
    [ToolClass postWithURL:url params:para completeBlock:^(id result) {
        //
        SKLog(@"%@",result[@"RETURN_CODE"]);
        if ([result[@"RETURN_CODE"] isEqualToString:@"0001"]) {
            // NOTE: 如果加签成功，则继续执行支付
            if (result[@"DATA"] != nil) {
                NSString *signStr = result[@"DATA"];
                SKLog(@"sign = %@",signStr);
                SKLog(@"orderInfo = %@",orderInfo);
                //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
                NSString *appScheme = @"skzq";
                NSString *newsign = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)signStr, NULL, (CFStringRef)@"!*'();:@&=+ $,./?%#[]", kCFStringEncodingUTF8));
                // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
                NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                         orderInfoEncoded, newsign];
                SKLog(@"%@",orderString);
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                    _callback([resultDic[@"resultStatus"] integerValue],orderId);
                }];
            }
        }
    } faildBlock:^{
        //
    }];
}
/** 生成订单,并签名支付 */
- (void)payWithOrderInfo{
    NSString *url = [NSString stringWithFormat:@"%@userOrder/setUserOrder",MAINURL];
    NSDictionary *para = @{@"USERID":_model
                           .userId,@"FINDID":_model.findId,@"MALLCOMMODITYID":_model.mallCommodityId,@"MALLCOMMODITYNAME":_model.mallCommodityName,@"SIZE":_model.size,@"COLOUR":_model.colour,@"IMGADDRESS":_model.imgAddress,@"QUANTITY":@([_model.quantity integerValue]),@"MONEY":@([_model.money floatValue] * [_model.quantity integerValue]),@"ADDRESS":_model.address,@"PROVINCE":_model.province,@"CITY":_model.city,@"DISTRICT":_model.district,@"TEL":_model.tel,@"USERNAME":_model.userName,@"PAYTYPE":@(0)};
    [ToolClass postWithURL:url params:para completeBlock:^(id result) {
        //
        SKLog(@"%@",result);
        if ([result[@"RETURN_CODE"] isEqualToString:@"0001"]) {
            [self payWithOrderId:result[@"DATA"][@"userOrderId"]];
        }
    } faildBlock:^{
        //
    }];
}

/** 同步支付结果到服务器 */
- (void)synchronize:(NSString *)orderId{
    NSString *url = [NSString stringWithFormat:@"%@userOrder/updateStatePayMentin",MAINURL];
    NSDictionary *para = @{@"USERORDERID":orderId};
    [ToolClass postWithURL:url params:para completeBlock:^(id result) {
        if ([result[@"RETURN_CODE"] isEqualToString:@"0001"]) {
            SKLog(@"支付结果同步服务器成功");
        }
    } faildBlock:^{
    }];
}

@end
