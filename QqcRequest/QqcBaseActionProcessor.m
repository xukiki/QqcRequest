//
//  QqcBaseActionProcessor.m
//  QqcRequestFramework
//
//  Created by qiuqinchuan on 16/3/1.
//  Copyright © 2016年 Qqc. All rights reserved.
//

#import "QqcBaseActionProcessor.h"
#import "YTKNetworkAgent.h"
#import "QqcRequest.h"
#import "QqcParamModel.h"
#import "QqcParamPostFile.h"
#import "QqcDataModel.h"
#import "QqcJsonResultModel.h"
#import "QqcError.h"
#import "QqcLog.h"
#import "Json+Qqc.h"
#import "QqcComFuncDef.h"

@interface QqcPrivateRequest : QqcRequest

@property (nonatomic, weak) QqcBaseActionProcessor *actionProcessor;

@end

@implementation QqcPrivateRequest

- (NSString *)requestUrl
{
    return self.actionProcessor.urlAction;
}

- (YTKRequestMethod)requestMethod
{
    QqcRequestMethod method = self.actionProcessor.requestMethod;
    YTKRequestMethod requestMethod;
    
    switch (method)
    {
        case QqcRequestMethodGet:
            requestMethod = YTKRequestMethodGet;
            break;
        case QqcRequestMethodPost:
            requestMethod = YTKRequestMethodPost;
            break;
        case QqcRequestMethodHead:
            requestMethod = YTKRequestMethodHead;
            break;
        case QqcRequestMethodPut:
            requestMethod = YTKRequestMethodPut;
            break;
        case QqcRequestMethodDelete:
            requestMethod = YTKRequestMethodDelete;
            break;
        case QqcRequestMethodPatch:
            requestMethod = YTKRequestMethodPatch;
            break;
        default:
            requestMethod = YTKRequestMethodGet;
            break;
    }
    
    return requestMethod;
}

- (YTKRequestSerializerType)requestSerializerType
{
    QqcRequestSerializerType type = self.actionProcessor.reqSerializerType;
    YTKRequestSerializerType serializerType;
    
    switch (type)
    {
        case QqcRequestSerializerTypeHTTP:
            serializerType = YTKRequestSerializerTypeHTTP;
            break;
        case QqcRequestSerializerTypeJSON:
            serializerType = YTKRequestSerializerTypeJSON;
            break;
        default:
            serializerType = YTKRequestSerializerTypeJSON;
            break;
    }
    
    return serializerType;
}

- (id)requestArgument
{
    //NSDictionary* dic = [self.actionProcessor.reqParam mj_keyValues];
    NSDictionary* dic = [self.actionProcessor.reqParam dictionaryValue];
    
    return dic;
}

- (AFConstructingBlock)constructingBodyBlock
{
    if (nil == self.actionProcessor.postFileParam) {
        return nil;
    }
    else
    {
        return ^(id<AFMultipartFormData> formData) {
            
            [formData appendPartWithFileData:self.actionProcessor.postFileParam.formdata name:self.actionProcessor.postFileParam.name fileName:self.actionProcessor.postFileParam.filename mimeType:self.actionProcessor.postFileParam.mimeType];

        };
    }
}

@end


@interface QqcBaseActionProcessor ()

@property (nonatomic, strong) QqcPrivateRequest *request;
@property (nonatomic, copy) void (^successBlock)(QqcBaseActionProcessor *);
@property (nonatomic, copy) void (^failBlock)(QqcBaseActionProcessor *);

@end

@implementation QqcBaseActionProcessor

#pragma mark - 系统方法
- (id)init
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

- (void)dealloc
{
#ifdef DEBUG
    if (![NSStringFromClass([self class]) isEqualToString:@"Action_Users_IMUser0520heartbeat"]) {
        QqcDebugLog(@"类:%@ 实例释放", name_class_qqc);
    }
#endif
    
    _delegate = nil;
    _reqParam = nil;
    _request = nil;
    _successBlock = nil;
    _failBlock = nil;
    _parseToThisEntifyClass = nil;
    _responseObject = nil;
    _error = nil;
}

#pragma mark - 外部接口
- (instancetype)initWithParam:(QqcParamModel *)reqParam postFileParam:(QqcParamPostFile*) postFileParam
{
    self = [self init];
    
    if (self)
    {
        if (nil != reqParam)
        {
            self.reqParam = reqParam;
#ifdef DEBUG
            if (![NSStringFromClass([self class]) isEqualToString:@"Action_Users_IMUser0520heartbeat"]) {
                //QqcDebugLog(@"类:%@\n传入参数:%@", NSStringFromClass([self class]), reqParam.mj_keyValues);
                QqcDebugLog(@"类:%@\n传入参数:%@", NSStringFromClass([self class]), [reqParam dictionaryValue]);
            }
#endif
        }
        if (nil != postFileParam)
        {
            self.postFileParam = postFileParam;
#ifdef DEBUG
            if (![NSStringFromClass([self class]) isEqualToString:@"Action_Users_IMUser0520heartbeat"]) {
                //QqcDebugLog(@"类:%@\n附带Post文件:%@", NSStringFromClass([self class]), postFileParam.mj_keyValues);
                QqcDebugLog(@"类:%@\n附带Post文件:%@", NSStringFromClass([self class]), [postFileParam dictionaryValue]);
            }
#endif
        }
    }
    
    return self;
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(QqcBaseActionProcessor *actionProcessor))successBlock
                                       fail:(void (^)(QqcBaseActionProcessor *actionProcessor))failBlock
{
    self.successBlock = successBlock;
    self.failBlock = failBlock;
    [self start];
}

#pragma mark - 初始化
- (QqcPrivateRequest *)request
{
    if (!_request)
    {
        _request = [[QqcPrivateRequest alloc] init];
        _request.actionProcessor = self;
    }
    
    return _request;
}

- (QqcDataType)dataType
{
    return QqcDataTypeJson;
}

- (QqcRequestMethod)requestMethod
{
    return QqcRequestMethodGet;
}

- (QqcRequestSerializerType)reqSerializerType
{
    return QqcRequestSerializerTypeHTTP;
}

- (NSString *)urlAction
{
    if (!_urlAction)
    {
        if (!self.urlBaseCommon || self.urlBaseCommon.length == 0)
        {
            [NSException raise:NSInvalidArgumentException
                        format:@"self.urlBaseCommon is null in %@", NSStringFromClass([self class])];
        }
        
        NSString* strAction = [name_class_qqc stringByReplacingOccurrencesOfString:@"Action_" withString:@""];
        NSArray* arrayAction =  [strAction componentsSeparatedByString:@"0520"];
        if ( !arrayAction || arrayAction.count < 2 )
        {
            [NSException raise:NSInvalidArgumentException format:@"自动解析Action失败"];
        }
        
        NSString* strNameSpace = [arrayAction[0] stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
        NSString* strRealAction = [arrayAction[1] stringByReplacingOccurrencesOfString:@"_" withString:@","];
        _urlAction = [NSString stringWithFormat:@"%@%@%@%@", self.urlBaseCommon, strNameSpace, @".ashx?action=", strRealAction];
        
#ifdef DEBUG
        if (![NSStringFromClass([self class]) isEqualToString:@"Action_Users_IMUser0520heartbeat"]) {
            QqcDebugLog(@"请求地址: %@", _urlAction);
        }
#endif
    }
    
    return _urlAction;
}
- (NSString *)errorString
{
    return @"网络请求失败，请稍后重试！";
}

- (Class)parseToThisEntifyClass
{
    return nil;
}

- (BOOL)customParseResponseData:(id)jsonResponse
{
    return NO;
}

#pragma mark - 内部调用方法
- (void)start
{
    [self reset];
    [self.request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
#ifdef DEBUG
        if (![NSStringFromClass([self class]) isEqualToString:@"Action_Users_IMUser0520heartbeat"]) {
            QqcDebugLog(@"请求响应：= %@", request.responseString);

        }
#endif
        if (QqcDataTypeJson == self.dataType)
        {
#warning mark - 这样原来是使用 request.responseJSONObject
            //modify_by_qqchuan
            //[self processDicData:request.responseJSONObject reqOrigin:request];
            
            //[self processDicData:[request.responseString qwt_JSONObject] reqOrigin:request];
            [self processDicData:[request.responseString qwt_JSONObject] reqOrigin:request];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        QqcWarnLog(@"网络请求失败， 地址:%@%@", request.baseUrl, request.requestUrl);
        self.error = [QqcError errorWithCode:QqcErrorTypeNetworkUnreachable
                               errorMessage:self.errorString];
        [self retFail];
    }];
}

- (void)reset
{
    if (_request && _request.isExecuting)
    {
        [[YTKNetworkAgent sharedInstance] cancelRequest:_request];
    }
    
    self.error = nil;
    self.responseObject = nil;
}

- (void)processDicData:(id)dataRet reqOrigin:(YTKBaseRequest*)request
{
    //先调用子类自解析函数
    if ([self customParseResponseData:request.responseString])
    {
//        if (!self.responseObject) {
//            self.responseObject = request.responseString;
//        }
        [self retSuccess];
    }
    else
    {
        if (!dataRet || ![dataRet isKindOfClass:[NSDictionary class]])
        {
            QqcWarnLog(@"服务端返回数据格式有误");
            [self retFail];
        }
        else
        {
            [self parseResponseObject:dataRet];
        }
    }
}

- (void)parseResponseObject:(NSDictionary *)jsonDictionary
{
    if (![jsonDictionary.allKeys containsObject:@"code"]
        || ![jsonDictionary.allKeys containsObject:@"message"]
        || ![jsonDictionary.allKeys containsObject:@"data"])
    {
        QqcWarnLog(@"返回的数据字典格式不是预定义的格式");
        [self retFail];
        return;
    }
    
    //框架自带的返回数据解析
    QqcJsonResultModel* respRet = [QqcJsonResultModel instanceWithDictionary:jsonDictionary];
    if (respRet.code >= QqcStatusSuccess)
    {
        //如果子类有指定返回数据的实体类型，则把返回的数据respRet.data按指定的实体类型进行解析
        Class entityClass = [self parseToThisEntifyClass];
        if (entityClass)
        {
            if ([respRet.data isKindOfClass:[NSArray class]]){
                
                respRet.data = [entityClass modelArrayWithDictionaryArray:respRet.data];
            }
            else if ([respRet.data isKindOfClass:[NSDictionary class]]){
                
                respRet.data = [entityClass instanceWithDictionary:respRet.data];
            }
        }
        
        self.successString = respRet.message;
        _responseObject = respRet.data;
        [self retSuccess];
    }
    else
    {
        self.error = [QqcError errorWithCode:QqcErrorTypeReturnDataError
                               errorMessage:[respRet.message description]];
        [self retFail];
    }
}

- (void)retSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(retSuccess:)])
        {
            [self.delegate retSuccess:self];
        }
        
        if (self.successBlock)
        {
            self.successBlock(self);
        }
        
        [self clearCompletionBlock];
    });
}

- (void)retFail
{
    if (!self.error)
    {
        self.error = [QqcError errorWithCode:QqcErrorTypeReturnDataError errorMessage:self.errorString];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(retFail:)])
        {
            [self.delegate retFail:self];
        }
        
        if (self.failBlock)
        {
            self.failBlock(self);
        }
        
        [self clearCompletionBlock];
    });
}

- (void)clearCompletionBlock
{
    self.successBlock = nil;
    self.failBlock = nil;
}

@end
