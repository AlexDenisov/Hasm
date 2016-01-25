//
// Created by AlexDenisov on 20/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "Parser.h"
#import "HTree.h"

int yyparse(HTree *tree);

typedef struct yy_buffer_state * YY_BUFFER_STATE;
extern FILE *yyin;
extern YY_BUFFER_STATE yy_scan_string(const char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);
void yyerror(const char *msg);

void yyerror(const char *err) {
    printf("something went wrong %s\n", err);
}

@implementation Parser

- (HTree *)parseString:(NSString *)string {
    YY_BUFFER_STATE state = yy_scan_string(string.UTF8String);
    HTree *tree = [self parse];
    yy_delete_buffer(state);

    return tree;
}

- (HTree *)parseFile:(NSString *)string {
    yyin = fopen(string.UTF8String, "r");
    HTree *tree = [self parse];
    fclose(yyin);

    return tree;
}

- (HTree *)parse {
    HTree *tree = [HTree new];
    yyparse(tree);
    [tree resolveSymbols];
    return tree;
}

@end
