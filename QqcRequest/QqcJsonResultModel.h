//
//  QqcJsonResultModel.h
//  QqcRequestFramework
//
//  Created by qiuqinchuan on 15/8/10.
//  Copyright (c) 2015年 Qqc. All rights reserved.
//

#import "QqcDataModel.h"

/**
 *  状态枚举
 */
typedef NS_ENUM(NSInteger, QqcStatus)
{
    /**
     *  成功
     */
    QqcStatusSuccess = 1,
    
    /**
     *  失败
     */
    QqcStatusFail = -1,
    
    /**
     *  未知
     */
    QqcStatusUnknow = -2
};

/**
 *  用于封装接口返回数据实体
 */
@interface QqcJsonResultModel : QqcDataModel

/**
 *  ret表示错误码
 */
@property (nonatomic, assign) NSInteger code;

/**
 *  出现错误时的提示信息
 */
@property (nonatomic, copy) NSString *message;

/**
 *  业务返回结果，可能为NSDictionary、NSString、NSArray[]
 */
@property (nonatomic, strong) id data;

@end
