//
//  QqcParamPostFile.h
//  QqcRequestFramework
//
//  Created by admin on 16/3/22.
//  Copyright © 2016年 Qqc. All rights reserved.
//
#import "QqcParamModel.h"

@interface QqcParamPostFile : QqcParamModel

@property(nonatomic, copy) NSString* filename;
@property(nonatomic, copy) NSString* name;
@property(nonatomic, strong) NSData* formdata;
@property(nonatomic, copy) NSString* mimeType;

@end
