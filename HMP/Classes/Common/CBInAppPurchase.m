//
//  CBInAppPurchase.m
//  HMP
//
//  Created by hcb on 2019/2/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CBInAppPurchase.h"
#import <StoreKit/StoreKit.h>

//在内购项目中创的商品单号
//类型1普通会员充值2vip充值3vip差价4修改资料5同方申请解除爱人关系普通6同方申请解除爱人关系vip

#define ProductID_IAP1 @"ZR.HMP01" //20
#define ProductID_IAP2 @"ZR.HMP02" //100
#define ProductID_IAP3 @"ZR.HMP03" //600
#define ProductID_IAP4 @"ZR.HMP04" //1000
#define ProductID_IAP5 @"ZR.HMP05" //6000
#define ProductID_IAP6 @"ZR.HMP06" //6000

@interface CBInAppPurchase ()<SKProductsRequestDelegate,SKRequestDelegate,SKPaymentTransactionObserver>
{
    SKProductsRequest *productReq;
    NSMutableArray *allProducts;
    NSString *cur_Buy;
}

@end

@implementation CBInAppPurchase

- (void)buy:(NSString *)type {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    cur_Buy = type;
    if (allProducts.count>0) {
        for (SKProduct *duct in allProducts) {
            if ([duct.productIdentifier isEqualToString:cur_Buy]) {
                //
                [LoadingView showLoading];
                
                SKPayment *payment  = [SKPayment paymentWithProduct:duct];    //支付
                
                [[SKPaymentQueue defaultQueue] addPayment:payment];
                
                
            }
        }
    }else{
        // 6.请求苹果后台商品
        [self requestAppleProduct];
    }
    
    if ([SKPaymentQueue canMakePayments]) {
        //        [self getRequestAppleProduct];
        NSLog(@"允许程序内付费购买");
    } else {
        NSLog(@"不允许程序内付费购买");
        UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的手机没有打开程序内付费购买" delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
        [alerView show];
    }
}

//请求苹果商品
- (void)requestAppleProduct
{
    // 7.这里的数组对应着苹果后台的商品ID,他们是通过这个ID进行联系的。
    NSArray *product = @[@"100002"];
    
    NSSet *nsset = [NSSet setWithArray:product];
    
    SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
    request.delegate=self;
    [request start];
    
}


///<> 请求协议
//收到的产品信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"-----------收到产品反馈信息--------------");
    NSArray *myProduct = response.products;
    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %d", (int)[myProduct count]);
    [LoadingView stopLoading];

    
    
    allProducts = response.products.mutableCopy;
    // populate UI
    for(SKProduct *product in myProduct){
        NSLog(@"product info");
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"Product id: %@" , product.productIdentifier);
    }
    
}

//弹出错误信息
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"-------弹出错误信息----------");
    [LoadingView stopLoading];
}

-(void) requestDidFinish:(SKRequest *)request
{
    NSLog(@"----------反馈信息结束--------------");
    
    [LoadingView stopLoading];
    
    
}

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"-----PurchasedTransaction----");
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
}


//----监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions//交易结果
{
    
    
    NSLog(@"-----paymentQueue--------");
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:{//交易完成
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [LoadingView stopLoading];

                });
                [self completeTransaction:transaction];
                NSLog(@"-----交易完成 --------");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"购买成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                
                
                
                [alert show];
                
            } break;
            case SKPaymentTransactionStateFailed://交易失败
            {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [LoadingView stopLoading];

                });
                [self failedTransaction:transaction];
                NSLog(@"-----交易失败 --------");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"购买失败，请尝试重新购买" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                
                
                [alert show];
                
            }break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [LoadingView stopLoading];

                });
                [self restoreTransaction:transaction];
                
                NSLog(@"-----已经购买过该商品 --------");
            }
            case SKPaymentTransactionStatePurchasing:      //商品添加进列表
                NSLog(@"-----商品添加进列表 --------");
                break;
            default:
                break;
        }
    }
    
    
}
- (void) completeTransaction: (SKPaymentTransaction *)transaction

{
    NSLog(@"-----completeTransaction--------");
    // Your application should implement these two methods.
    NSString *product = transaction.payment.productIdentifier;
    if ([product length] > 0) {
        
        NSArray *tt = [product componentsSeparatedByString:@"."];
        NSString *bookid = [tt lastObject];
        if ([bookid length] > 0) {
            [self recordTransaction:bookid];
            
        }
    }
    
    // Remove the transaction from the payment queue.
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

#pragma mark - 购买该产品成功，此处保存到服务器
-(void)recordTransaction:(NSString *)product{
    NSLog(@"-----记录交易--------");
    [self verifyRecipt:product];
}



- (void) failedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"失败");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}
-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction{
    
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@" 交易恢复处理");
    
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    NSLog(@"-------paymentQueue----");
}


#pragma mark - 与自己server交互
-(void)verifyRecipt:(NSString *)product{
    [LoadingView showLoading];
    [CBBaseModel request:@"notify/Index/applePay" par:@{@"receipt_data":product?:@""} callback:^(id  _Nonnull data, NSString * _Nonnull msg) {
        [LoadingView stopLoading];

        [LoadingView showAMessage:msg];
        
    }];
    
}

- (void)createOrder:(HMPOrderType)type jiechuId:(NSString *)uid{
    [LoadingView showLoading];
//    类型1普通会员充值2vip充值3vip差价4修改资料5同方申请解除爱人关系普通6同方申请解除爱人关系vip
    __weak typeof(self) weakSelf = self;
    [CBBaseModel request:@"order/index/create" par:@{@"type":@(type),@"pay_type":@3,@"uid":uid} callback:^(id  _Nonnull data, NSString * _Nonnull msg) {
        [LoadingView stopLoading];

        if ([msg containsString:@"下单成功"]) {
            NSString *goodsID = ProductID_IAP1;
            if (type==HMPOrderTypeNormal) {
                goodsID = ProductID_IAP1;
            }else if (type==HMPOrderTypeVIP) {
                goodsID = ProductID_IAP2;
            }else if (type==HMPOrderTypeVIPCha) {
                goodsID = ProductID_IAP3;
            }else if (type==HMPOrderTypeChangeInfo) {
                goodsID = ProductID_IAP4;
            }else if (type==HMPOrderTypeJiechuNormal) {
                goodsID = ProductID_IAP5;
            }else if (type==HMPOrderTypeJiechuVIP) {
                goodsID = ProductID_IAP6;
            }
            [weakSelf buy:goodsID];
        }
        [LoadingView showAMessage:msg];
        
    }];
    
}
@end
