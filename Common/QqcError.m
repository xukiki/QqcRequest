//
//  QqcError.m
//  QqcRequestFramework
//
//  Created by qiuqinchuan on 16/3/2.
//  Copyright © 2016年 Qqc. All rights reserved.
//

#import "QqcError.h"

NSString *const kQqcErrorDomain = @"com.qqc";

@implementation QqcError

/**
 *  根据给定的错误类型和信息创建QqcError实例
 *
 *  @param errorType    错误类型
 *  @param errorMessage 错误描述信息
 *
 *  @return 返回QqcError实例
 */
+ (instancetype)errorWithCode:(NSUInteger)errorType errorMessage:(NSString *)errorMessage
{
    return [[self alloc] initWithCode:errorType errorMessage:errorMessage];
}

/**
 *  根据给定的错误类型和信息创建QqcError实例
 *
 *  @param errorType    错误类型
 *  @param errorMessage 错误描述信息
 *
 *  @return 返回QqcError实例
 */
- (instancetype)initWithCode:(NSUInteger)errorType errorMessage:(NSString *)errorMessage
{
    return [self initWithDomain:kQqcErrorDomain
                           code:errorType
                       userInfo:(errorMessage != nil
                                 ? [NSDictionary dictionaryWithObjectsAndKeys:
                                    [errorMessage description], NSLocalizedDescriptionKey, nil]
                                 : nil)];
}

/**
 *  根据NSError的实例生成QqcError
 *
 *  @param error NSError的实例
 *
 *  @return 返回QqcError的实例
 */
+ (instancetype)errorWithError:(NSError *)error
{
    return [[self alloc] initWithCode:error.code errorMessage:error.localizedDescription];
}

/**
 *  根据NSError的实例生成QqcError
 *
 *  @param error NSError的实例
 *
 *  @return 返回QqcError的实例
 */
- (instancetype)initWithError:(NSError *)error
{
    return [self initWithCode:error.code errorMessage:error.localizedDescription];
}

/**
 *  返回数据错误
 *
 *  @return 返回数据错误的error对象
 */
+ (instancetype)returnDataError
{
    return [[self alloc] initWithCode:QqcErrorTypeReturnDataError errorMessage:@"返回数据错误"];
}

@end
