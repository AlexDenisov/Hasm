//
//  CGDriver.m
//  Hasm
//
//  Created by AlexDenisov on 24/05/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "CGDriver.h"
#import "HTree.h"
#import "Expr.h"

#include <fstream>
using namespace std;

@implementation CGDriver

- (void)emitCodeGen:(HTree *)tree outputFile:(NSString *)fileName {
    ofstream myfile;
    myfile.open (fileName.UTF8String);
    if (!myfile.is_open()) {
        printf("CG: smth went wrong\n");
        exit(1);
    }
    for (Expr *e in tree.expressions) {
        NSString *code = [NSString stringWithFormat:@"%@\n", e.codeGen];
        myfile << code.UTF8String;
    }
    myfile.close();
}

@end
