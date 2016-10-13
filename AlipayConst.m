//
//  AlipayConst.m
//  AliSDKDemo
//
//  Created by 沙少盼 on 16/9/27.
//  Copyright © 2016年 Alipay.com. All rights reserved.
//

#import "AlipayConst.h"

NSString *const ORDER_PAY_CODE_SUCCESS = @"订单支付成功";
NSString *const ORDER_PAY_CODE_PROCESSING = @"订单正在处理中";
NSString *const ORDER_PAY_CODE_DEFEATED = @"订单支付失败";
NSString *const ORDER_PAY_CODE_REPEATED = @"重复请求";
NSString *const ORDER_PAY_CODE_CANCLED = @"用户中途取消";
NSString *const ORDER_PAY_CODE_NONETWORK = @"网络连接出错";
NSString *const ORDER_PAY_CODE_UNKNOWED = @"支付结果未知";

NSString *const ALIPAY_TRADE_APP_PAY = @"alipay.trade.app.pay";
NSString *const ALIPAY_TRADE_CLOSE = @"alipay.trade.close";
NSString *const ALIPAY_TRADE_QUERY = @"alipay.trade.query";
NSString *const ALIPAY_TRADE_REFUND = @"alipay.trade.refund";
NSString *const ALIPAY_TRADE_FASTPAY_REFUND_QUERY = @"alipay.trade.fastpay.refund.query";
NSString *const ALIPAY_DATA_DATASERVICE_BILL_DOWNLOADURL_QUERY = @"alipay.data.dataservice.bill.downloadurl.query";

@implementation AlipayConst
+ (NSString *)getLogStr:(OrderResultStatus)statusCode{
    NSString *logStr = @"";
    switch (statusCode) {
        case ORDER_PAY_SUCCESS:
        {
            logStr = ORDER_PAY_CODE_SUCCESS;
        }
            break;
        case ORDER_PAY_PROCESSING:
        {
            logStr = ORDER_PAY_CODE_PROCESSING;
        }
            break;
        case ORDER_PAY_DEFEATED:
        {
            logStr = ORDER_PAY_CODE_DEFEATED;
        }
            break;
        case ORDER_PAY_CANCLED:
        {
            logStr = ORDER_PAY_CODE_CANCLED;
        }
            break;
        case ORDER_PAY_NONETWORK:
        {
            logStr = ORDER_PAY_CODE_NONETWORK;
        }
            break;
        case ORDER_PAY_UNKNOWED:
        {
            logStr = ORDER_PAY_CODE_UNKNOWED;
        }
            break;
        case ORDER_PAY_REPEATED:
        {
            logStr = ORDER_PAY_CODE_REPEATED;
        }
            break;
        default:
            break;
    }
    return logStr;
}
@end
