//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expr.h"

@interface SumExpr : Expr

+ (instancetype)exprWithLHS:(Expr *)LHS RHS:(Expr *)RHS;

@end
