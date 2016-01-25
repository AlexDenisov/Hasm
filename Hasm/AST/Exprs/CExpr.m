//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "CExpr.h"
#import "DestinationExpr.h"
#import "JumpExpr.h"

@interface CExpr ()

@property (nonatomic) Expr *destination;
@property (nonatomic) Expr *computation;
@property (nonatomic) Expr *jump;

@end

@implementation CExpr

+ (instancetype)destination:(Expr *)dest computation:(Expr *)comp jump:(Expr *)jump {
    CExpr *e = [CExpr new];

    e.destination = dest ?: [DestinationExpr new];
    e.computation = comp ?: [Expr new];
    e.jump = jump ?: [JumpExpr new];

    return e;
}

+ (instancetype)destination:(Expr *)expr {
    return [self destination:expr computation:nil jump:nil];
}

+ (instancetype)computation:(Expr *)expr {
    return [self destination:nil computation:expr jump:nil];
}

+ (instancetype)jump:(Expr *)expr {
    return [self destination:nil computation:nil jump:expr];
}

- (BOOL)isEqual:(CExpr *)rhs {
    return (self.class == rhs.class) &&
        [self.destination isEqual:rhs.destination] &&
        [self.computation isEqual:rhs.computation] &&
        [self.jump isEqual:rhs.jump];
}

- (void)dump {
    [self.destination dump];

    printf(" = ");

    [self.computation dump];

    printf(" ; ");

    [self.jump dump];

    printf("\n");
}

- (NSString *)codeGen {
    return [NSString stringWithFormat:@"111%@%@%@",
            self.computation.codeGen,
            self.destination.codeGen,
            self.jump.codeGen];
}

@end
