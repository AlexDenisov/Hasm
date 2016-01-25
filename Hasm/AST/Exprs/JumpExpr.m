//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "JumpExpr.h"

@interface JumpExpr ()

@property (nonatomic, copy) NSString *jump;

@end

@implementation JumpExpr

+ (instancetype)exprWithJump:(NSString *)string {
    JumpExpr *j = [self new];
    j.jump = string;
    return j;
}

- (BOOL)isEqual:(JumpExpr *)rhs {
    return self.class == rhs.class &&
        [self.jump isEqual:rhs.jump];
}

- (NSString *)jump {
    if (!_jump) {
        _jump = [@"" copy];
    }

    return _jump;
}

- (void)dump {
    printf("%s", self.jump.UTF8String);
}

- (NSString *)codeGen {
    if ([self.jump isEqual:@"JGT"]) {
        return @"001";
    }

    if ([self.jump isEqual:@"JEQ"]) {
        return @"010";
    }

    if ([self.jump isEqual:@"JGE"]) {
        return @"011";
    }

    if ([self.jump isEqual:@"JLT"]) {
        return @"100";
    }

    if ([self.jump isEqual:@"JNE"]) {
        return @"101";
    }

    if ([self.jump isEqual:@"JLE"]) {
        return @"110";
    }

    if ([self.jump isEqual:@"JMP"]) {
        return @"111";
    }

    return @"000";
}

@end
