//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "AExpr.h"
#import "NSString+h_binaryString.h"

#pragma mark - AExpr

@implementation AExpr

+ (instancetype)exprWithLabel:(NSString *)label {
    AExpr *e = [AExpr new];
    e.label = label;
    return e;
}

+ (instancetype)exprWithNumber:(NSNumber *)number {
    AExpr *e = [AExpr new];
    e.number = number;
    e.resolved = YES;
    return e;
}

- (BOOL)isEqual:(AExpr *)rhs {
    if (self.class != rhs.class) {
        return NO;
    }
    if (self.resolved && rhs.resolved) {
        return [self.number isEqual:rhs.number];
    }

    return !self.resolved && !rhs.resolved &&
        [self.label isEqual:rhs.label];
}

- (void)dump {
    printf("%s\n", self.stringRep.UTF8String);
}

- (NSString *)stringRep {
    NSString *rep = self.label;
    if (self.resolved) {
        rep = self.number.stringValue;
    }

    return [NSString stringWithFormat:@"@%@", rep];
}

- (NSString *)codeGen {
    return [NSString binaryStringFromNumber:self.number.shortValue];
}

@end
