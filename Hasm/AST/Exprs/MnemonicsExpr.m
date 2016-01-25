//
//  MnemonicsExpr.m
//  Hasm
//
//  Created by AlexDenisov on 22/05/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "MnemonicsExpr.h"

@interface MnemonicsExpr ()

@property (nonatomic, copy) NSString *mnemonics;

@end

@implementation MnemonicsExpr

+ (instancetype)exprWithMnemonics:(NSString *)mnemonics {
    MnemonicsExpr *e = [self new];
    e.mnemonics = mnemonics;
    return e;
}

- (BOOL)isEqual:(MnemonicsExpr *)rhs {
    return (self.class == rhs.class) &&
        [self.mnemonics isEqual:rhs.mnemonics];
}

- (void)dump {
    printf("%s", self.mnemonics.UTF8String);
}

@end
