BaseTask is a set of classes that allow you to easily create an API client
for a web service. It reduces the boilerplate down to just the specifics you
need to interact with an API.

[![Build Status](https://travis-ci.org/endoze/BaseTask.svg)](https://travis-ci.org/endoze/BaseTask)
[![Coverage Status](https://coveralls.io/repos/github/endoze/BaseTask/badge.svg?branch=master)](https://coveralls.io/github/endoze/BaseTask?branch=master)
[![License](https://img.shields.io/cocoapods/l/BaseTask.svg?style=flat)](http://cocoapods.org/pods/BaseTask)
[![Platform](https://img.shields.io/cocoapods/p/BaseTask.svg?style=flat)](http://cocoadocs.org/docsets/BaseTask)
[![CocoaPods](https://img.shields.io/cocoapods/v/BaseTask.svg?style=flat)](https://img.shields.io/cocoapods/v/BaseTask.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Motivation

When building applications that interact with web services, I wanted something
that took advantage of the existing NSURLSession classes that Apple introduced
with iOS 7 and OSX 10.9. I also wanted something that could be subclassed so I
could encapsulate different web resource requests within concreate classes that
only add in their specific details.

## Features

- Small public API surface
- Works with your own custom objects
- Customizeable via method override
- Well documented
- Tested
- Support For Cocoapods/Carthage integration

## Installation

### Carthage

Add the following to your Cartfile:

```
github "Endoze/BaseTask"
```

Then add the framework as a linked framework.

### CocoaPods

Add the following to your Podfile:

```
use_frameworks!


pod 'BaseTask'
```

Then run `pod install`

## Show me the code

### If your language of choice is Swift

```swift
// UserTask.swift

import BaseTask

class PostTask: BaseTask {
  typealias Post = [String: AnyObject]
  typealias GetPostCompletionHandler = (Post?, NSURLResponse?, NSError?) -> Void
  typealias GetAllPostsCompletionHandler = ([Post]?, NSURLResponse?, NSError?) -> Void

  let baseURLString = "http://jsonplaceholder.typicode.com/posts"

  func getPost(id: String, completionHandler: GetPostCompletionHandler) -> NSURLSessionDataTask {
    let url = NSURL(string: "\(baseURLString)/\(id)")!

    return makeHTTPRequest(url,
      bodyDictionary: nil,
      httpMethod: .Get,
      httpHeaders: nil,
      bodyParser: nil,
      responseParsers: [JSONResponseParser()],
      completion: { (parsedObject, response, error) in
        let objectToReturn = parsedObject as? Post
        completionHandler(objectToReturn, response, error)
      }
    )
  }

  func getAllPosts(completionHandler: GetAllPostsCompletionHandler) -> NSURLSessionDataTask {
    let url = NSURL(string: baseURLString)!

    return makeHTTPRequest(url,
      bodyDictionary: nil,
      httpMethod: .Get,
      httpHeaders: nil,
      bodyParser: nil,
      responseParsers: [JSONResponseParser()],
      completion: { (parsedObject, response, error) in
        let objectToReturn = parsedObject as? [Post]
        completionHandler(objectToReturn, response, error)
    })
  }
}
```

```swift
// Elsewhere

let task = PostTask().getAllPosts() { posts, response, error in
  if let posts = posts where error == nil {
    // do something with posts
    print(posts)
  }
}

task.resume()
```

### Or if you prefer Objective-C

```objective-c
// PostTask.h

#import "BaseTask.h"

typedef NSDictionary<NSString *, id> Post;
typedef void (^GetAllPostsCallback)(NSArray<Post *> * _Nullable posts, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface PostTask : BaseTask

- (NSString *)baseURL;

- (void)getAllPostsWithCompletionHandler:(GetAllPostsCallback)completionHandler;

@end
```

```objective-c
// PostTask.m

#import "PostTask.h"

@implementation PostTask

- (NSString *)baseURL
{
	return @"http://jsonplaceholder.typicode.com/posts";
}

- (void)getAllPostsWithCompletionHandler:(GetAllPostsCallback)completionHandler
{
	NSURL *url = [NSURL URLWithString:[self baseURL]];

  return [self makeHTTPRequest:url
                bodyDictionary:nil
                    httpMethod:GET
                   httpHeaders:nil
                    bodyParser:nil
               responseParsers:@[[JSONResponseParser new]]
                dispatch_queue:nil
                    completion:completionHandler];
}

@end
```

```objective-c
// Elsewhere

NSURLSessionDataTask *task = [[PostTask new]
 getAllPostsWithCompletionHandler:^(NSArray<Post *> *posts, NSURLResponse *response, NSError *error) {
	if (!error && posts) {
	  // do something with posts
		NSLog(@"%@", posts);
	}
}];

[task resume];
```
