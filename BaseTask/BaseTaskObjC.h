//
//  BaseTaskObjC.h
//  BaseTask
//
//  Created by Endoze on 5/2/16.
//  Copyright © 2016 Chris Stephan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BodyParseable, ResponseParseable;
@class BaseTask, HTTPHeader;

NS_ASSUME_NONNULL_BEGIN

typedef BOOL (^ValidationHandler)(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError ** error);
typedef void (^CompletionHandler)(_Nullable id parsedObject, NSURLResponse * _Nullable response, NSError * _Nullable error);


@interface BaseTaskObjC : NSObject

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) id<BodyParseable> defaultBodyParser;
@property (nonatomic, strong) NSArray<id<ResponseParseable>> *defaultResponseParsers;
@property (nonatomic, copy) ValidationHandler validationHandler;

- (instancetype)initWithSession:(NSURLSession * _Nullable)session;

- (NSURLSessionDataTask *)makeHTTPRequest:(NSURL *)url
                           bodyDictionary:(NSDictionary  * _Nullable)bodyDictionary
                               httpMethod:(NSInteger)httpMethod
                              httpHeaders:(NSArray<HTTPHeader *> * _Nullable)httpHeaders
                               bodyParser:(_Nullable id<BodyParseable>)bodyParser
                          responseParsers:(NSArray<id<ResponseParseable>> * _Nullable)responseParsers
                            dispatchQueue:(_Nullable dispatch_queue_t)dispatchQueue
                               completion:(CompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END