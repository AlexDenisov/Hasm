//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "MnemonicExpr.h"

@interface MnemonicExpr ()

@property (nonatomic, copy) NSString *mnemonic;

@end

@implementation MnemonicExpr

+ (instancetype)exprWithMnemonic:(NSString *)string {
    MnemonicExpr *e = [self new];
    e.mnemonic = string;
    return e;
}

- (BOOL)isEqual:(MnemonicExpr *)rhs {
    return (self.class == rhs.class) &&
        [self.mnemonic isEqual:rhs.mnemonic];
}

- (void)dump {
    printf("%s", self.mnemonic.UTF8String);
}

- (NSString *)stringRep {
    return self.mnemonic;
}

- (NSString *)codeGen {
    if ([self.mnemonic isEqual:@"A"]) {
        return @"0110000";
    }

    if ([self.mnemonic isEqual:@"M"]) {
        return @"1110000";
    }

    if ([self.mnemonic isEqual:@"D"]) {
        return @"0001100";
    }

    return [super codeGen];
}

@end
