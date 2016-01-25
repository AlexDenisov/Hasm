//
//  main.cpp
//  Hasm
//
//  Created by AlexDenisov on 17/05/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "Parser.h"
#import "HTree.h"
#import "CGDriver.h"

int main(int argc, const char * argv[]) {
    NSString *path = @"/Users/alexdenisov/Studying/nand2tetris1-001/projects/06/pong/Pong.asm";
    NSString *output = [[path stringByDeletingPathExtension] stringByAppendingPathExtension:@"hack"];
    Parser *p = [Parser new];
    HTree *tree = [p parseFile:path];
    CGDriver *codegen = [CGDriver new];
    [codegen emitCodeGen:tree outputFile:output];

    return 0;
}
