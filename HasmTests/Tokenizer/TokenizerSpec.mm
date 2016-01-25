#import "Tokenizer.h"
#import "y.tab.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

int getToken(NSString *string) {
    Tokenizer *tokenizer = [Tokenizer new];
    NSArray *tokens = [tokenizer tokenizeString:string];
    return [tokens.firstObject intValue];
}

NSArray *getTokens(NSString *string) {
    Tokenizer *tokenizer = [Tokenizer new];
    return [tokenizer tokenizeString:string];
}

SPEC_BEGIN(TokenizerSpec)

describe(@"Tokenizer", ^{

    describe(@"tokenize", ^{

        context(@"symbol", ^{

            it(@"@", ^{
                getToken(@"@") should equal(t_at);
            });

            it(@"+", ^{
                getToken(@"+") should equal(t_plus);
            });

            it(@"-", ^{
                getToken(@"-") should equal(t_minus);
            });

            it(@"=", ^{
                getToken(@"=") should equal(t_equal);
            });

            it(@";", ^{
                getToken(@";") should equal(t_semi);
            });

            it(@"&", ^{
                getToken(@"&") should equal(t_and);
            });

            it(@"|", ^{
                getToken(@"|") should equal(t_or);
            });

            it(@"!", ^{
                getToken(@"!") should equal(t_not);
            });

            it(@"(", ^{
                getToken(@"(") should equal(t_lparen);
            });

            it(@")", ^{
                getToken(@")") should equal(t_rparen);
            });

        });

        context(@"mnemonic", ^{

            it(@"A", ^{
                getToken(@"A") should equal(t_amnemonic);
            });

            it(@"D", ^{
                getToken(@"D") should equal(t_dmnemonic);
            });

            it(@"M", ^{
                getToken(@"M") should equal(t_mmnemonic);
            });

        });

        context(@"identifier", ^{

            it(@"with letters", ^{
                getToken(@"UnCoPyRightABlezzz") should equal(t_identifier);
            });

            it(@"with letters and symbols", ^{
                getToken(@"UnCoPyRightABlezzz._$") should equal(t_identifier);
            });

            it(@"with letters and symbols", ^{
                getToken(@"UnCoPyRightABlezzz._$12309875") should equal(t_identifier);
            });
            
        });

        context(@"number", ^{

            it(@"short", ^{
                getToken(@"0") should equal(t_number);
            });

            it(@"long", ^{
                getToken(@"01234567890") should equal(t_number);
            });
            
        });

        context(@"whitespace", ^{

            it(@"space", ^{
                getTokens(@" ") should be_empty;
            });

            it(@"\r", ^{
                getTokens(@"\r") should be_empty;
            });

            it(@"\n", ^{
                getTokens(@"\n") should be_empty;
            });

            it(@"\t", ^{
                getTokens(@"\t") should be_empty;
            });

        });

        context(@"jump", ^{

            it(@"JGT", ^{
                getToken(@"JGT") should equal(t_jump);
            });

            it(@"JEQ", ^{
                getToken(@"JEQ") should equal(t_jump);
            });

            it(@"JGE", ^{
                getToken(@"JGE") should equal(t_jump);
            });

            it(@"JLT", ^{
                getToken(@"JLT") should equal(t_jump);
            });

            it(@"JNE", ^{
                getToken(@"JNE") should equal(t_jump);
            });

            it(@"JLE", ^{
                getToken(@"JLE") should equal(t_jump);
            });

            it(@"JMP", ^{
                getToken(@"JMP") should equal(t_jump);
            });

        });

        context(@"comment", ^{

            it(@"with spaces", ^{
                getTokens(@"   //asd") should be_empty;
            });

            it(@"without spaces", ^{
                getTokens(@"//asd") should be_empty;
            });

            it(@"with token", ^{
                getTokens(@"16 // just number 16").count should equal(1);
            });

            it(@"with tokens", ^{
                getTokens(@"1 + 16 // adds 1 + 16").count should equal(3);
            });

            it(@"multiline", ^{
                id s = @"1 + 16 // adds 1 + 16\n2 + 16 // adds 2 + 16";
                getTokens(s).count should equal(6);
            });

        });

        context(@"unknown symbols", ^{

            it(@"*", ^{
                getToken(@"*") should equal(t_unknown);
            });

            it(@"^", ^{
                getToken(@"^") should equal(t_unknown);
            });

            it(@"я", ^{
                getToken(@"я") should equal(t_unknown);
            });

            it(@">", ^{
                getToken(@">") should equal(t_unknown);
            });

        });

    });

});

SPEC_END
