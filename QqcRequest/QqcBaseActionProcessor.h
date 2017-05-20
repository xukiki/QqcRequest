//
//  QqcBaseActionProcessor.h
//  QqcRequestFramework
//
//  Created by qiuqinchuan on 16/3/1.
//  Copyright © 2016年 Qqc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QqcError;
@class QqcParamModel;
@class QqcBaseActionProcessor;
@class QqcParamPostFile;

typedef void(^blockParseJsonData2Dic)(NSDictionary* dataRet);

typedef NS_ENUM(NSUInteger, QqcDataType)
{
    QqcDataTypeJson,
};

typedef NS_ENUM(NSInteger , QqcRequestSerializerType)
{
    QqcRequestSerializerTypeHTTP,
    QqcRequestSerializerTypeJSON,
};

typedef NS_ENUM(NSInteger , QqcRequestMethod)
{
    QqcRequestMethodGet = 0,
    QqcRequestMethodPost,
    QqcRequestMethodHead,
    QqcRequestMethodPut,
    QqcRequestMethodDelete,
    QqcRequestMethodPatch
};


//操作结果代理
@protocol QqcBaseActionProcessorDelegate <NSObject>

@optional
//请求成功的回调方法
- (void)retSuccess:(QqcBaseActionProcessor *)actionProcessor;

//请求失败的回调方法
- (void)retFail:(QqcBaseActionProcessor *)actionProcessor;

@end



@interface QqcBaseActionProcessor : NSObject

#pragma mark - 调用设置
//操作结果代理
@property (nonatomic, weak) id<QqcBaseActionProcessorDelegate> delegate;

//接口地址 的 基础公共部分，如
@property (nonatomic, copy) NSString *urlBaseCommon;

//接口地址 的 操作部分，默认由类名解析获得
@property (nonatomic, copy) NSString *urlAction;

//http的请求类型，默认QqcRequestMethodGet
@property (nonatomic, assign) QqcRequestMethod requestMethod;

//请求的序列化类型，默认QqcRequestSerializerTypeHTTP
@property (nonatomic, assign) QqcRequestSerializerType reqSerializerType;

//请求参数
@property (nonatomic, strong) QqcParamModel *reqParam;

//Post附带文件
@property (nonatomic, strong) QqcParamPostFile* postFileParam;

//传输数据类型，默认JSON，暂时也只有JSON
@property (nonatomic, assign) QqcDataType dataType;

/**
 *  如果 返回的数据 是如何框架定义格式的
 *  为nil时，系统将把 返回的数据 转换为 QqcJsonResultModel,寄存在responseObject
 *  不为nil时，框架将 返回的数据 自动转换为 该 类型的实例
 */
@property (nonatomic, strong) Class parseToThisEntifyClass;

//定制错误显示字符串,默认显示 “网络请求失败，请稍后重试！”
@property (nonatomic, copy) NSString *errorString;

//操作成功时，服务器返回的成功提示
@property (nonatomic, copy) NSString *successString;

#pragma mark - 结果获取
//经过处理后的返回数据
@property (nonatomic, strong) id responseObject;

//错误
@property (nonatomic, strong) QqcError *error;

- (void)retFail;

- (void)retSuccess;

#pragma mark - 外部接口,初始化及基本操作
/**
 *  根据给定参数实体初始化业务控制类
 *
 *  @param reqParam 传递的参数实体
 *
 *  @return 返回业务控制类
 */
- (instancetype)initWithParam:(QqcParamModel *)reqParam postFileParam:(QqcParamPostFile*) postFileParam;

/**
 *  指定成功和失败的回调，开始请求
 *
 *  @param successBlock 请求成功的回调
 *  @param failBlock 请求失败的回调
 */
- (void)startWithCompletionBlockWithSuccess:(void (^)(QqcBaseActionProcessor *actionProcessor))successBlock
                                    fail:(void (^)(QqcBaseActionProcessor *actionProcessor))failBlock;

#pragma mark - 结果解析定制
/**
 *  子类可以重载这个方法来自己解析 返回的数据
 *  先尝试调用子类自己的解析方法来解析 返回的数据
 *  如果返回YES，则框架认为子类已经解析数据成功，不在对返回的数据进行框架自带解析
 *  如果返回NO,则框架认为子类无法解析返回的数据，框架会对返回的数据进行框架自带解析
 *
 *  @param jsonResponse http返回的数据
 *
 *  @return 解析成功返回YES，失败为NO
 */
- (BOOL)customParseResponseData:(id)jsonResponse;

@end