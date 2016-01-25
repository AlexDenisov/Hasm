//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "SumExpr.h"
#import "ConstIntExpr.h"

@interface SumExpr ()

@property (nonatomic) Expr *LHS;
@property (nonatomic) Expr *RHS;

@end

@implementation SumExpr

+ (instancetype)exprWithLHS:(Expr *)LHS RHS:(Expr *)RHS {
    SumExpr *e = [self new];

    e.LHS = LHS;
    e.RHS = RHS;

    return e;
}

- (BOOL)isEqual:(SumExpr *)rhs {
    return self.class == rhs.class &&
        [self.LHS isEqual:rhs.LHS] &&
        [self.RHS isEqual:rhs.RHS];
}

- (void)dump {
    [self.LHS dump];
    printf(" + ");
    [self.RHS dump];
}

- (NSString *)stringRep {
    return [NSString stringWithFormat:@"%@+%@", self.LHS.stringRep, self.RHS.stringRep];
}

- (NSString *)codeGen {
    if ([self.RHS isKindOfClass:[ConstIntExpr class]]) {
        return [self incrementCodeGen];
    }

    NSString *code = @"x000010";
    NSString *aBit = [[self.RHS codeGen] substringToIndex:1];
    code = [code stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                         withString:aBit];

    return code;
}

- (NSString *)incrementCodeGen {
    NSString *stringRep = self.stringRep;
    if ([stringRep hasPrefix:@"D"]) {
        return @"0011111";
    }

    if ([stringRep hasPrefix:@"A"]) {
        return @"0110111";
    }

    if ([stringRep hasPrefix:@"M"]) {
        return @"1110111";
    }

    return @"";
}

@end
