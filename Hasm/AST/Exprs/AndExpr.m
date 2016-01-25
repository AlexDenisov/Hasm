//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "AndExpr.h"

@interface AndExpr ()

@property (nonatomic) Expr *LHS;
@property (nonatomic) Expr *RHS;

@end

@implementation AndExpr


+ (instancetype)exprWithLHS:(Expr *)LHS RHS:(Expr *)RHS {
    AndExpr *e = [self new];

    e.LHS = LHS;
    e.RHS = RHS;

    return e;
}

- (BOOL)isEqual:(AndExpr *)rhs {
    return self.class == rhs.class &&
    [self.LHS isEqual:rhs.LHS] &&
    [self.RHS isEqual:rhs.RHS];
}

- (void)dump {
    [self.LHS dump];
    printf(" & ");
    [self.RHS dump];
}

- (NSString *)stringRep {
    return [NSString stringWithFormat:@"%@&%@", self.LHS.stringRep, self.RHS.stringRep];
}

- (NSString *)codeGen {
    NSString *code = @"x000000";
    NSString *aBit = [[self.RHS codeGen] substringToIndex:1];
    code = [code stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                         withString:aBit];

    return code;
}

@end
