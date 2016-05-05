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

/**
 *  Block that captures logic on how to validate an http response sent back from a server.
 *
 *  @param response HTTP response object.
 *  @param data     HTTP response data.
 *  @param error    Populated with error if one occurs during the request/response cycle.
 *
 *  @return Boolean representing a valid or invalid request
 */
typedef BOOL (^ValidationHandler)(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError ** error);

/**
 *  Block that captures what to do when an http request completes and a response sent back.
 *
 *  @param parsedObject An object returned from the http request and processed by the response parsers.
 *  @param response     HTTP response object.
 *  @param error        Populated with error if one occurs during the request/response cycle.
 */
typedef void (^CompletionHandler)(_Nullable id parsedObject, NSURLResponse * _Nullable response, NSError * _Nullable error);

/**
 * BaseTaskObjC is a class designed to be subclassed. It helps in defining an API interface to a web service.
 */
@interface BaseTaskObjC : NSObject

/**
 *  The session to use when making requests.
 */
@property (nonatomic, strong) NSURLSession *session;

/**
 *  The default body parser to use when sending requests.
 */
@property (nonatomic, strong) id<BodyParseable> defaultBodyParser;

/**
 *  The default chain of response parsers to use when parsing an http response body.
 */
@property (nonatomic, strong) NSArray<id<ResponseParseable>> *defaultResponseParsers;

/**
 *  The block to use when validating http response bodies.
 */
@property (nonatomic, copy) ValidationHandler validationHandler;

/**
 *  This is the default initializer for BaseTaskObjC. It defaults to using a session created from the standard shared session configuration.
 *
 *  @param session NSURLSesson to use when making requests. Defaults to using a session created from the standard shared session configuration.
 *
 *  @return An instance of BaseTaskObjC
 */
- (instancetype)initWithSession:(NSURLSession * _Nullable)session;

/**
 *  This is the workhorse method that creates new instances of NSURLSessionDataTask created based on the parameters passed in.
 *
 *  @param url               URL that you are sending your requests to.
 *  @param bodyDictionary    Dictionary representing the data sent in the http request body.
 *  @param httpMethod        HTTP Method to use when making the request.
 *  @param httpHeaders       HTTP headers to use when making the request.
 *  @param bodyParser        Body parser to use when parsing the bodyDictionary.
 *  @param responseParsers   Chain of response parsers to use when parsing an http response body.
 *  @param dispatchQueue     Dispatch queue to run the completion handler on.
 *  @param completionHandler Block that captures the logic to execute after completion of the request/response cycle.
 *
 *  @return Returns a ready to go NSURLSessionDataTask configured based on the parameters passed in. Calling resume on it starts your request.
 */
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