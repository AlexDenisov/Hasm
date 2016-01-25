//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "DestinationExpr.h"

@interface DestinationExpr ()

@property (copy, nonatomic)  NSString *mnemonics;

@end

@implementation DestinationExpr

+ (instancetype)exprWithMnemonics:(NSString *)mnemonics {
    DestinationExpr *e = [self new];

    e.mnemonics = mnemonics;

    return e;
}

- (instancetype)init {
    self = [super init];

    self.mnemonics = @"";

    return self;
}

- (BOOL)isEqual:(DestinationExpr *)rhs {
    return (self.class == rhs.class) &&
        [self.mnemonics isEqual:rhs.mnemonics];
}

- (void)dump {
    printf("%s\n", self.mnemonics.UTF8String);
}

- (NSString *)codeGen {
    // A D M
    //     1
    //   1
    // 1

    NSString *mnemonics = self.mnemonics;
    char mnem[] = { "000" };

    if ([mnemonics containsString:@"M"]) {
        mnem[2] = '1';
    }
    if ([mnemonics containsString:@"D"]) {
        mnem[1] = '1';
    }
    if ([mnemonics containsString:@"A"]) {
        mnem[0] = '1';
    }

    return @(mnem);
}

@end
