//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expr.h"

@interface ConstIntExpr : Expr
+ (instancetype)exprWithConst:(int)i;
@end
