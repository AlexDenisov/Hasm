//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expr.h"

@interface AExpr : Expr

@property (nonatomic, copy) NSString *label;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic) BOOL resolved;

+ (instancetype)exprWithLabel:(NSString *)label;
+ (instancetype)exprWithNumber:(NSNumber *)number;

@end
