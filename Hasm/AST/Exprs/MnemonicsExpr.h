//
//  MnemonicsExpr.h
//  Hasm
//
//  Created by AlexDenisov on 22/05/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "Expr.h"

@interface MnemonicsExpr : Expr

+ (instancetype)exprWithMnemonics:(NSString *)mnemonics;

@end
