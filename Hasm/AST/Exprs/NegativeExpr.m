//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "NegativeExpr.h"
#import "ConstIntExpr.h"

@interface NegativeExpr ()

@property (nonatomic) Expr *mnemonic;

@end

@implementation NegativeExpr

+ (instancetype)exprWithMnemonic:(Expr *)m {
    NegativeExpr *e = [self new];

    e.mnemonic = m;

    return e;
}

- (BOOL)isEqual:(NegativeExpr *)rhs {
    return self.class ==  rhs.class &&
        [self.mnemonic isEqual:rhs.mnemonic];
}

- (void)dump {
    printf("-");
    [self.mnemonic dump];
}

- (NSString *)codeGen {
    NSString *code = [self.mnemonic codeGen];
    code = [code stringByReplacingCharactersInRange:NSMakeRange(code.length - 2, 2)
                                         withString:@"11"];

    if ([self.mnemonic isKindOfClass:[ConstIntExpr class]]) {
        return @"0111010";
    }

    return code;
}

@end
