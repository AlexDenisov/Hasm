//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expr.h"

@interface JumpExpr : Expr

+ (instancetype)exprWithJump:(NSString *)string;

@end
