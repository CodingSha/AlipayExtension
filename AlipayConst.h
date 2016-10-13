//
//  AlipayConst.h
//  AliSDKDemo
//
//  Created by 沙少盼 on 16/9/27.
//  Copyright © 2016年 Alipay.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger ,OrderResultStatus) {
    /** 订单支付成功 */
    ORDER_PAY_SUCCESS = 9000,
    /** 正在处理中... */
    ORDER_PAY_PROCESSING = 8000,
    /** 订单支付失败 */
    ORDER_PAY_DEFEATED = 4000,
    /** 重复请求 */
    ORDER_PAY_REPEATED = 5000,
    /** 用户中途取消 */
    ORDER_PAY_CANCLED = 6001,
    /** 网络连接出错 */
    ORDER_PAY_NONETWORK = 6002,
    /** 支付结果未知 */
    ORDER_PAY_UNKNOWED = 6004
};

/////////////////////////////////////支付结果code对应的说明////////////////////////////////////////////
/** 订单支付成功 */
UIKIT_EXTERN NSString *const ORDER_PAY_CODE_SUCCESS;
/** 正在处理中... */
UIKIT_EXTERN NSString *const ORDER_PAY_CODE_PROCESSING;
/** 订单支付失败 */
UIKIT_EXTERN NSString *const ORDER_PAY_CODE_DEFEATED;
/** 重复请求 */
UIKIT_EXTERN NSString *const ORDER_PAY_CODE_REPEATED;
/** 用户中途取消 */
UIKIT_EXTERN NSString *const ORDER_PAY_CODE_CANCLED;
/** 网络连接出错 */
UIKIT_EXTERN NSString *const ORDER_PAY_CODE_NONETWORK;
/** 支付结果未知 */
UIKIT_EXTERN NSString *const ORDER_PAY_CODE_UNKNOWED;

/////////////////////////////////////Alipay接口////////////////////////////////////////////
UIKIT_EXTERN NSString *const ALIPAY_TRADE_APP_PAY;
UIKIT_EXTERN NSString *const ALIPAY_TRADE_CLOSE;
UIKIT_EXTERN NSString *const ALIPAY_TRADE_QUERY;
UIKIT_EXTERN NSString *const ALIPAY_TRADE_REFUND;
UIKIT_EXTERN NSString *const ALIPAY_TRADE_FASTPAY_REFUND_QUERY;
UIKIT_EXTERN NSString *const ALIPAY_DATA_DATASERVICE_BILL_DOWNLOADURL_QUERY;

@interface AlipayConst : NSObject
+ (NSString *)getLogStr:(OrderResultStatus)statusCode;
@end
