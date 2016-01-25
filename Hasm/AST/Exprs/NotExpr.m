//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "NotExpr.h"

@interface NotExpr ()

@property (nonatomic) Expr *mnemonic;

@end

@implementation NotExpr

+ (instancetype)exprWithMnemonic:(Expr *)m {
    NotExpr *e = [self new];

    e.mnemonic = m;

    return e;
}

- (BOOL)isEqual:(NotExpr *)rhs {
    return self.class == rhs.class &&
        [self.mnemonic isEqual:rhs.mnemonic];
}

- (void)dump {
    printf("!");
    [self.mnemonic dump];
}

- (NSString *)codeGen {
    NSString *code = [self.mnemonic codeGen];
    code = [code stringByReplacingCharactersInRange:NSMakeRange(code.length - 1, 1)
                                         withString:@"1"];

    return code;
}

@end
