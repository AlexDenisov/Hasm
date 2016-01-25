//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "HTree.h"
#import "Expr.h"
#import "AExpr.h"

@interface HTree ()

@property (nonatomic) NSMutableArray *subExpressions;
@property (nonatomic) NSMutableArray *unresolvedExpressions;
@property (nonatomic) NSMutableDictionary *table;
@property (nonatomic) unsigned lowestMemReg;

@end

@implementation HTree

- (instancetype)init {
    self.subExpressions = [NSMutableArray new];
    self.unresolvedExpressions = [NSMutableArray new];
    self.lowestMemReg = 16;
    self.table = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                   @"R0" : @(0),
                                                                   @"R1" : @(1),
                                                                   @"R2" : @(2),
                                                                   @"R3" : @(3),
                                                                   @"R4" : @(4),
                                                                   @"R5" : @(5),
                                                                   @"R6" : @(6),
                                                                   @"R7" : @(7),
                                                                   @"R8" : @(8),
                                                                   @"R9" : @(9),
                                                                   @"R10" : @(10),
                                                                   @"R11" : @(11),
                                                                   @"R12" : @(12),
                                                                   @"R13" : @(13),
                                                                   @"R14" : @(14),
                                                                   @"R15" : @(15),
                                                                   @"SCREEN" : @(16384),
                                                                   @"KBD" : @(24576),
                                                                   @"SP" : @(0),
                                                                   @"LCL" : @(1),
                                                                   @"ARG" : @(2),
                                                                   @"THIS" : @(3),
                                                                   @"THAT" : @(4)
                                                                   }];

    return self;
}

- (void)addUnresolvedExpression:(Expr *)expr {
    [self.unresolvedExpressions addObject:expr];
}

- (void)addExpression:(Expr *)expr {
    [self.subExpressions addObject:expr];
}

- (void)addLabel:(NSString *)label {
    [self.table setValue:@(self.expressions.count) forKey:label];
}

- (NSArray *)expressions {
    return self.subExpressions;
}

- (void)dump {
    printf("%lu instructions:\n\n", (unsigned long)self.expressions.count);
    for (Expr *e in self.expressions) {
        [e dump];
    }
}

- (NSDictionary *)symbolTable {
    return self.table;
}

- (void)resolveSymbols {
    for (AExpr *e in self.unresolvedExpressions) {
        NSNumber *number = self.table[e.label];
        if (!number) {
            number = [self nextMemoryRegister];
            self.table[e.label] = number;
        }
        e.number = number;
        if (number) {
            e.resolved = YES;
        }
    }
}

- (NSNumber *)nextMemoryRegister {
    return @(self.lowestMemReg++);
}

@end
