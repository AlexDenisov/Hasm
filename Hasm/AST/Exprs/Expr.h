//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Expr : NSObject

- (void)dump;
- (NSString *)codeGen;
- (NSString *)stringRep;

@end
