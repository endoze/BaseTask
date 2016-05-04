//
//  BaseTaskObjC.m
//  BaseTask
//
//  Created by Endoze on 5/2/16.
//  Copyright © 2016 Chris Stephan. All rights reserved.
//

#import "BaseTaskObjC.h"

#import <BaseTask/BaseTask-Swift.h>

@interface BaseTaskObjC ()

@property (nonatomic, strong) BaseTask *baseTask;

@end

@implementation BaseTaskObjC

- (instancetype)init
{
  NSURLSession *session = [NSURLSession sessionWithConfiguration:
                           [[NSURLSession sharedSession] configuration]];

  return [self initWithSession:session];
}

- (instancetype)initWithSession:(NSURLSession *)session
{
  self = [super init];

  if (self) {
    self.baseTask = [[BaseTask alloc] initWithSession:session];
  }

  return self;
}

- (NSURLSessionDataTask *)makeHTTPRequest:(NSURL *)url
                           bodyDictionary:(NSDictionary *)bodyDictionary
                               httpMethod:(NSInteger)httpMethod
                              httpHeaders:(NSArray<HTTPHeader *> *)httpHeaders
                               bodyParser:(id<BodyParseable>)bodyParser
                          responseParsers:(NSArray<id<ResponseParseable>> *)responseParsers
                            dispatchQueue:(dispatch_queue_t)dispatchQueue
                               completion:(CompletionHandler)completionHandler
{
  if (!dispatchQueue) {
    dispatchQueue = dispatch_get_main_queue();
  }

  return [self.baseTask makeHTTPRequest:url
                         bodyDictionary:bodyDictionary
                             httpMethod:httpMethod
                            httpHeaders:httpHeaders
                             bodyParser:bodyParser
                        responseParsers:responseParsers
                          dispatchQueue:dispatchQueue
                             completion:completionHandler];
}

- (BaseTask *)baseTask
{
  if (!_baseTask) {
    _baseTask = [BaseTask new];
  }

  return _baseTask;
}

- (void)setSession:(NSURLSession *)session
{
  [self.baseTask setSession:session];
}

- (NSURLSession *)session
{
  return [self.baseTask session];
}

- (void)setDefaultBodyParser:(id<BodyParseable>)defaultBodyParser
{
  [self.baseTask setDefaultBodyParser:defaultBodyParser];
}

- (id<BodyParseable>)defaultBodyParser
{
  return [self.baseTask defaultBodyParser];
}

- (void)setDefaultResponseParsers:(NSArray<ResponseParseable> *)defaultResponseParsers
{
  [self.baseTask setDefaultResponseParsers:defaultResponseParsers];
}

- (NSArray<id<ResponseParseable>> *)defaultResponseParsers
{
  return [self.baseTask defaultResponseParsers];
}

- (void)setValidationHandler:(ValidationHandler)validationHandler
{
  [self.baseTask setValidationHandler:validationHandler];
}

- (ValidationHandler)validationHandler
{
  return [self.baseTask validationHandler];
}

@end
