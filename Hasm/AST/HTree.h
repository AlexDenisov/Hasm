//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Expr;

@interface HTree : NSObject

- (NSArray *)expressions;
- (NSDictionary *)symbolTable;

- (void)addExpression:(Expr *)expr;
- (void)addUnresolvedExpression:(Expr *)expr;
- (void)addLabel:(NSString *)label;
- (void)dump;

- (void)resolveSymbols;

@end
