//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expr.h"

@interface CExpr : Expr

+ (instancetype)destination:(Expr *)dest computation:(Expr *)comp jump:(Expr *)jump;

+ (instancetype)destination:(Expr *)expr;

+ (instancetype)computation:(Expr *)expr;

+ (instancetype)jump:(Expr *)expr;

@end
