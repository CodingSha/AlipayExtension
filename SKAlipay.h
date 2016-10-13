//
//  SKAlipay.h
//  SKZQ
//
//  Created by 沙少盼 on 16/10/12.
//  Copyright © 2016年 时刻足球. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T_MallCommodityModel.h"
#import "AlipayConst.h"

@interface SKAlipay : NSObject
/** 生成订单所需商品信息的model  这里需要自己设计自己的model */
@property (nonatomic,strong)T_MallCommodityModel *model;
@property (nonatomic,copy)void(^callback)(OrderResultStatus status,NSString *userOrderId);

- (void)payWithOrderId:(NSString *)orderId;
- (void)payWithOrderInfo;
- (void)synchronize:(NSString *)orderId;

/**      从商城直接支付
 SKAlipay *alipay = [[SKAlipay alloc]init];
 alipay.model = _model;
 [alipay payWithOrderInfo];
 alipay.callback = ^(OrderResultStatus status,NSString *orderId){
 if (status == ORDER_PAY_SUCCESS) {
 填写自己的处理
 }
 [ToolClass showSuccessMessage:[AlipayConst getLogStr:status] toView:[UIApplication sharedApplication].keyWindow];
 };
 */

/**      从订单支付
 SKAlipay *alipay = [[SKAlipay alloc]init];
 alipay.model = _model;
 [alipay payWithOrderId:_model.userOrderId];
 alipay.callback = ^(OrderResultStatus status,NSString *orderId){
 if (status == ORDER_PAY_SUCCESS) {
 自己的处理逻辑
 }
 [ToolClass showSuccessMessage:[AlipayConst getLogStr:status] toView:[UIApplication sharedApplication].keyWindow];
 };
 */
@end
