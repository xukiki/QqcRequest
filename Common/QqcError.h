//
//  QqcError.h
//  QqcRequestFramework
//
//  Created by qiuqinchuan on 16/3/2.
//  Copyright © 2016年 Qqc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  错误类型
 */
typedef NS_ENUM(NSUInteger, QqcErrorType)
{
    /**
     *  未知错误
     */
    QqcErrorTypeUndefinded,
    
    /**
     *  返回数据错误
     */
    QqcErrorTypeReturnDataError,
    
    /**
     *  网络错误
     */
    QqcErrorTypeNetworkUnreachable
};

/**
 *  封装错误类型
 */
@interface QqcError : NSError

/**
 *  根据给定的错误类型和信息创建QqcError实例
 *
 *  @param errorType    错误类型
 *  @param errorMessage 错误描述信息
 *
 *  @return 返回QqcError实例
 */
+ (instancetype)errorWithCode:(NSUInteger)errorType errorMessage:(NSString *)errorMessage;

/**
 *  根据给定的错误类型和信息创建QqcError实例
 *
 *  @param errorType    错误类型
 *  @param errorMessage 错误描述信息
 *
 *  @return 返回QqcError实例
 */
- (instancetype)initWithCode:(NSUInteger)errorType errorMessage:(NSString *)errorMessage;

/**
 *  根据NSError的实例生成QqcError
 *
 *  @param error NSError的实例
 *
 *  @return 返回QqcError的实例
 */
+ (instancetype)errorWithError:(NSError *)error;

/**
 *  根据NSError的实例生成QqcError
 *
 *  @param error NSError的实例
 *
 *  @return 返回QqcError的实例
 */
- (instancetype)initWithError:(NSError *)error;

/**
 *  返回数据错误
 *
 *  @return 返回数据错误的error对象
 */
+ (instancetype)returnDataError;


@end
