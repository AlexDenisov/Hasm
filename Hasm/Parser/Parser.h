//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTree;

@interface Parser : NSObject

- (HTree *)parseString:(NSString *)string;
- (HTree *)parseFile:(NSString *)string;

@end
