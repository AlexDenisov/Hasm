//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "Expr.h"

@interface Expr ()

@end

@implementation Expr

- (BOOL)isEqual:(Expr *)rhs {
    return self.class == rhs.class;
}

- (void)dump {
    printf("%s", self.stringRep.UTF8String);
}

- (NSString *)codeGen {
    return @"";
}

- (NSString *)stringRep {
    return @"{}";
}

@end
