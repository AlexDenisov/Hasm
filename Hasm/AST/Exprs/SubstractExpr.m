//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "SubstractExpr.h"
#import "ConstIntExpr.h"

@interface SubstractExpr ()

@property (nonatomic) Expr *LHS;
@property (nonatomic) Expr *RHS;

@end

@implementation SubstractExpr

+ (instancetype)exprWithLHS:(Expr *)LHS RHS:(Expr *)RHS {
    SubstractExpr *e = [self new];

    e.LHS = LHS;
    e.RHS = RHS;

    return e;
}

- (BOOL)isEqual:(SubstractExpr *)rhs {
    return self.class == rhs.class &&
    [self.LHS isEqual:rhs.LHS] &&
    [self.RHS isEqual:rhs.RHS];
}

- (void)dump {
    [self.LHS dump];
    printf(" - ");
    [self.RHS dump];
}

- (NSString *)stringRep {
    return [NSString stringWithFormat:@"%@-%@", self.LHS.stringRep, self.RHS.stringRep];
}

- (NSString *)codeGen {
    if ([self.RHS isKindOfClass:[ConstIntExpr class]]) {
        return [self decrementCodeGen];
    }

    NSString *code = @"x010011";

    NSString *stringRep = self.stringRep;
    NSString *aBit = [[self.RHS codeGen] substringToIndex:1];
    if ([stringRep hasSuffix:@"D"]) {
        code = @"x000111";
        aBit = [[self.LHS codeGen] substringToIndex:1];
    }

    code = [code stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                         withString:aBit];

    return code;
}

- (NSString *)decrementCodeGen {
    NSString *code = [self.LHS codeGen];
    code = [code stringByReplacingCharactersInRange:NSMakeRange(code.length - 2, 1)
                                         withString:@"1"];

    return code;
}

@end
