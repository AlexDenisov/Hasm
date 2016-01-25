#import "Parser.h"
#import "HTree.h"
#import "AExpr.h"
#import "MnemonicExpr.h"
#import "DestinationExpr.h"
#import "CExpr.h"
#import "ConstIntExpr.h"
#import "NotExpr.h"
#import "NegativeExpr.h"
#import "SumExpr.h"
#import "SubstractExpr.h"
#import "AndExpr.h"
#import "OrExpr.h"
#import "JumpExpr.h"
#import "MnemonicsExpr.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

HTree *parseString(NSString *string) {
    Parser *parser = [Parser new];
    return [parser parseString:string];
}

Expr *getFirstChild(NSString *string) {
    HTree *tree = parseString(string);
    return tree.expressions[0];
}

NSDictionary *getSymbolTable(NSString *string) {
    HTree *tree = parseString(string);
    return tree.symbolTable;
}

SPEC_BEGIN(ParserSpec)

describe(@"Parser", ^{

    describe(@"parses string", ^{

        context(@"A expression", ^{

            it(@"with number", ^{
                Expr *expr = [AExpr exprWithNumber:@(123)];
                getFirstChild(@"@123") should equal(expr);
            });

            it(@"with label", ^{
                Expr *expr = [AExpr exprWithNumber:@(16)];
                getFirstChild(@"@label") should equal(expr);
            });

        });

        context(@"L expression", ^{

            it(@"saves label", ^{
                NSDictionary *table = getSymbolTable(@"(Label)");
                table.allKeys should contain(@"Label");
                table.allValues should contain(@(1));
            });

            it(@"saves label with other commands", ^{
                NSDictionary *table = getSymbolTable(@"@Label (Label)");
                table.allKeys should contain(@"Label");
                table.allValues should contain(@(2));
            });

        });

        context(@"C expression", ^{

            context(@"destination", ^{

                it(@"A=1", ^{
                    Expr *destination = [DestinationExpr exprWithMnemonics:@"A"];
                    Expr *i = [ConstIntExpr exprWithConst:1];

                    Expr *expr = [CExpr destination:destination computation:i jump:nil];
                    getFirstChild(@"A=1") should equal(expr);
                });

                it(@"D=1", ^{
                    Expr *destination = [DestinationExpr exprWithMnemonics:@"D"];
                    Expr *i = [ConstIntExpr exprWithConst:1];

                    Expr *expr = [CExpr destination:destination computation:i jump:nil];
                    getFirstChild(@"D=1") should equal(expr);
                });

                it(@"M=1", ^{
                    Expr *destination = [DestinationExpr exprWithMnemonics:@"M"];
                    Expr *i = [ConstIntExpr exprWithConst:1];

                    Expr *expr = [CExpr destination:destination computation:i jump:nil];
                    getFirstChild(@"M=1") should equal(expr);
                });

                it(@"MD=1", ^{
                    Expr *destination = [DestinationExpr exprWithMnemonics:@"MD"];
                    Expr *i = [ConstIntExpr exprWithConst:1];

                    Expr *expr = [CExpr destination:destination computation:i jump:nil];
                    getFirstChild(@"MD=1") should equal(expr);
                });

                it(@"AMD=1", ^{
                    Expr *destination = [DestinationExpr exprWithMnemonics:@"AMD"];
                    Expr *i = [ConstIntExpr exprWithConst:1];

                    Expr *expr = [CExpr destination:destination computation:i jump:nil];
                    getFirstChild(@"AMD=1") should equal(expr);
                });

            });

            context(@"computation", ^{

                context(@"constants", ^{

                    it(@"0", ^{
                        Expr *actual = getFirstChild(@"0");

                        Expr *e = [ConstIntExpr exprWithConst:0];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                    it(@"1", ^{
                        Expr *actual = getFirstChild(@"1");

                        Expr *e = [ConstIntExpr exprWithConst:1];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                });

                context(@"mnemonic", ^{

                    it(@"A=M", ^{
                        Expr *actual = getFirstChild(@"A=M");

                        Expr *destination = [DestinationExpr exprWithMnemonics:@"A"];
                        Expr *e = [MnemonicExpr exprWithMnemonic:@"M"];
                        Expr *expected = [CExpr destination:destination computation:e jump:nil];

                        actual should equal(expected);
                    });

                });

                context(@"NOT", ^{

                    it(@"!A", ^{
                        Expr *actual = getFirstChild(@"!A");

                        Expr *mnemonic = [MnemonicExpr exprWithMnemonic:@"A"];
                        Expr *e = [NotExpr exprWithMnemonic:mnemonic];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                    it(@"!D", ^{
                        Expr *actual = getFirstChild(@"!D");

                        Expr *mnemonic = [MnemonicExpr exprWithMnemonic:@"D"];
                        Expr *e = [NotExpr exprWithMnemonic:mnemonic];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                    it(@"!M", ^{
                        Expr *actual = getFirstChild(@"!M");

                        Expr *mnemonic = [MnemonicExpr exprWithMnemonic:@"M"];
                        Expr *e = [NotExpr exprWithMnemonic:mnemonic];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                });

                context(@"negative", ^{

                    it(@"-A", ^{
                        Expr *actual = getFirstChild(@"-A");

                        Expr *mnemonic = [MnemonicExpr exprWithMnemonic:@"A"];
                        Expr *e = [NegativeExpr exprWithMnemonic:mnemonic];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                    it(@"-D", ^{
                        Expr *actual = getFirstChild(@"-D");

                        Expr *mnemonic = [MnemonicExpr exprWithMnemonic:@"D"];
                        Expr *e = [NegativeExpr exprWithMnemonic:mnemonic];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                    it(@"-M", ^{
                        Expr *actual = getFirstChild(@"-M");

                        Expr *mnemonic = [MnemonicExpr exprWithMnemonic:@"M"];
                        Expr *e = [NegativeExpr exprWithMnemonic:mnemonic];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                });

                context(@"sum", ^{

                    it(@"A+1", ^{
                        Expr *actual = getFirstChild(@"A+1");

                        Expr *a = [MnemonicExpr exprWithMnemonic:@"A"];
                        Expr *one = [ConstIntExpr exprWithConst:1];
                        Expr *e = [SumExpr exprWithLHS:a RHS:one];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                    it(@"1+A", ^{
                        Expr *actual = getFirstChild(@"1+A");

                        Expr *a = [MnemonicExpr exprWithMnemonic:@"A"];
                        Expr *one = [ConstIntExpr exprWithConst:1];
                        Expr *e = [SumExpr exprWithLHS:one RHS:a];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                    it(@"A+D", ^{
                        Expr *actual = getFirstChild(@"A+D");

                        Expr *a = [MnemonicExpr exprWithMnemonic:@"A"];
                        Expr *d = [MnemonicExpr exprWithMnemonic:@"D"];
                        Expr *e = [SumExpr exprWithLHS:a RHS:d];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                });

                context(@"substract", ^{

                    it(@"A-1", ^{
                        Expr *actual = getFirstChild(@"A-1");

                        Expr *a = [MnemonicExpr exprWithMnemonic:@"A"];
                        Expr *one = [ConstIntExpr exprWithConst:1];
                        Expr *e = [SubstractExpr exprWithLHS:a RHS:one];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                    it(@"1-A", ^{
                        Expr *actual = getFirstChild(@"1-A");

                        Expr *a = [MnemonicExpr exprWithMnemonic:@"A"];
                        Expr *one = [ConstIntExpr exprWithConst:1];
                        Expr *e = [SubstractExpr exprWithLHS:one RHS:a];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                    it(@"A-D", ^{
                        Expr *actual = getFirstChild(@"A-D");

                        Expr *a = [MnemonicExpr exprWithMnemonic:@"A"];
                        Expr *d = [MnemonicExpr exprWithMnemonic:@"D"];
                        Expr *e = [SubstractExpr exprWithLHS:a RHS:d];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                });

                context(@"and", ^{

                    it(@"A&D", ^{
                        Expr *actual = getFirstChild(@"A&D");

                        Expr *a = [MnemonicExpr exprWithMnemonic:@"A"];
                        Expr *d = [MnemonicExpr exprWithMnemonic:@"D"];
                        Expr *e = [AndExpr exprWithLHS:a RHS:d];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                });

                context(@"or", ^{

                    it(@"A|D", ^{
                        Expr *actual = getFirstChild(@"A|D");

                        Expr *a = [MnemonicExpr exprWithMnemonic:@"A"];
                        Expr *d = [MnemonicExpr exprWithMnemonic:@"D"];
                        Expr *e = [OrExpr exprWithLHS:a RHS:d];
                        Expr *expected = [CExpr computation:e];

                        actual should equal(expected);
                    });

                });

            });

            context(@"jump", ^{

                it(@"JGT", ^{
                    Expr *actual = getFirstChild(@"0;JGT");

                    Expr *e = [JumpExpr exprWithJump:@"JGT"];
                    Expr *i = [ConstIntExpr exprWithConst:0];
                    Expr *expected = [CExpr destination:nil computation:i jump:e];

                    actual should equal(expected);
                });

                it(@"JEQ", ^{
                    Expr *actual = getFirstChild(@"0;JEQ");

                    Expr *e = [JumpExpr exprWithJump:@"JEQ"];
                    Expr *i = [ConstIntExpr exprWithConst:0];
                    Expr *expected = [CExpr destination:nil computation:i jump:e];

                    actual should equal(expected);
                });

                it(@"JGE", ^{
                    Expr *actual = getFirstChild(@"0;JGE");

                    Expr *e = [JumpExpr exprWithJump:@"JGE"];
                    Expr *i = [ConstIntExpr exprWithConst:0];
                    Expr *expected = [CExpr destination:nil computation:i jump:e];

                    actual should equal(expected);
                });

                it(@"JLT", ^{
                    Expr *actual = getFirstChild(@"0;JLT");

                    Expr *e = [JumpExpr exprWithJump:@"JLT"];
                    Expr *i = [ConstIntExpr exprWithConst:0];
                    Expr *expected = [CExpr destination:nil computation:i jump:e];

                    actual should equal(expected);
                });

                it(@"JNE", ^{
                    Expr *actual = getFirstChild(@"0;JNE");

                    Expr *e = [JumpExpr exprWithJump:@"JNE"];
                    Expr *i = [ConstIntExpr exprWithConst:0];
                    Expr *expected = [CExpr destination:nil computation:i jump:e];

                    actual should equal(expected);
                });

                it(@"JLE", ^{
                    Expr *actual = getFirstChild(@"0;JLE");

                    Expr *e = [JumpExpr exprWithJump:@"JLE"];
                    Expr *i = [ConstIntExpr exprWithConst:0];
                    Expr *expected = [CExpr destination:nil computation:i jump:e];

                    actual should equal(expected);
                });

                it(@"JMP", ^{
                    Expr *actual = getFirstChild(@"0;JMP");

                    Expr *e = [JumpExpr exprWithJump:@"JMP"];
                    Expr *i = [ConstIntExpr exprWithConst:0];
                    Expr *expected = [CExpr destination:nil computation:i jump:e];

                    actual should equal(expected);
                });

            });

        });

    });

    describe(@"symbols resolution", ^{

        context(@"predefined symbols", ^{

            it(@"registers", ^{
                Expr *e = getFirstChild(@"@R0");
                e.stringRep should equal(@"@0");
            });

            it(@"keyboard", ^{
                Expr *e = getFirstChild(@"@KBD");
                e.stringRep should equal(@"@24576");
            });

            it(@"screen", ^{
                Expr *e = getFirstChild(@"@SCREEN");
                e.stringRep should equal(@"@16384");
            });

        });

        context(@"custom symbols", ^{

            it(@"variable", ^{
                Expr *e = getFirstChild(@"@sum");
                e.stringRep should equal(@"@16");
            });

            it(@"two variables", ^{
                Expr *e = parseString(@"@sum @index").expressions.lastObject;
                e.stringRep should equal(@"@17");
            });

            it(@"label: forward decl", ^{
                Expr *e = parseString(@"@BEGIN (BEGIN)").expressions.lastObject;
                e.stringRep should equal(@"@1");
            });

            it(@"label: after decl", ^{
                Expr *e = parseString(@"(BEGIN) @BEGIN").expressions.lastObject;
                e.stringRep should equal(@"@0");
            });

        });

    });

    describe(@"parses file", ^{

        // do not run it with other tests!!!
        xit(@"", ^{
            Parser *parser = [Parser new];
            NSString *path = @"/tmp/parser.hasm";
            HTree *tree = [parser parseFile:path];

            Expr *e1 = [AExpr exprWithLabel:@"oh"];
            tree.expressions[0] should equal(e1);

            Expr *e2 = [AExpr exprWithLabel:@"well"];
            tree.expressions[1] should equal(e2);

            Expr *dest = [DestinationExpr exprWithMnemonics:@"A"];
            Expr *d = [MnemonicExpr exprWithMnemonic:@"D"];
            Expr *e3 = [CExpr destination:dest computation:d jump:nil];
            tree.expressions[2] should equal(e3);
        });

    });

});

SPEC_END
