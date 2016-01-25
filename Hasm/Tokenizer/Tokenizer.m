//
// Created by AlexDenisov on 19/05/15.
// Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "Tokenizer.h"
#import "y.tab.h"

typedef struct yy_buffer_state * YY_BUFFER_STATE;

extern enum yytokentype yylex();
extern YY_BUFFER_STATE yy_scan_string(const char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);
extern const char *yytext;

@interface Tokenizer ()

@end

@implementation Tokenizer

- (NSArray *)tokenizeString:(NSString *)string {
    YY_BUFFER_STATE state = yy_scan_string(string.UTF8String);
    enum yytokentype token;
    NSMutableArray *tokens = [NSMutableArray new];
    while( (token = yylex()) != 0 ) {
        [tokens addObject:@(token)];
    }
    yy_delete_buffer(state);
    return tokens;
}

@end
