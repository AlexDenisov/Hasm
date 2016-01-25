//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "ConstIntExpr.h"

@interface ConstIntExpr ()

@property (nonatomic) int constant;

@end

@implementation ConstIntExpr

+ (instancetype)exprWithConst:(int)i {
    ConstIntExpr *e = [self new];
    e.constant = i;
    return e;
}

- (BOOL)isEqual:(ConstIntExpr *)rhs {
    return self.class == rhs.class && self.constant == rhs.constant;
}

- (void)dump {
    printf("%d", self.constant);
}

- (NSString *)codeGen {
    if (self.constant == 0) {
        return @"0101010";
    }

    if (self.constant == 1) {
        return @"0111111";
    }

    return [super codeGen];
}

- (NSString *)stringRep {
    return @(self.constant).stringValue;
}

@end
