#import <Cedar/Cedar.h>
#import "HAST.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(CodeGenSpecSpec)

describe(@"CodeGenSpec", ^{

    context(@"A expr", ^{

        it(@"@2", ^{
            Expr *expr = [AExpr exprWithNumber:@(2)];

            NSString *actual = [expr codeGen];
            NSString *expected = @"0000000000000010";

            actual should equal(expected);
        });

        it(@"@133", ^{
            Expr *expr = [AExpr exprWithNumber:@(133)];

            NSString *actual = [expr codeGen];
            NSString *expected = @"0000000010000101";

            actual should equal(expected);
        });

        it(@"@0", ^{
            Expr *expr = [AExpr exprWithNumber:@(0)];

            NSString *actual = [expr codeGen];
            NSString *expected = @"0000000000000000";

            actual should equal(expected);
        });

    });

    context(@"C expr", ^{

        ConstIntExpr *zero = [ConstIntExpr exprWithConst:0];
        ConstIntExpr *one = [ConstIntExpr exprWithConst:1];

        MnemonicExpr *A = [MnemonicExpr exprWithMnemonic:@"A"];
        MnemonicExpr *D = [MnemonicExpr exprWithMnemonic:@"D"];
        MnemonicExpr *M = [MnemonicExpr exprWithMnemonic:@"M"];

        describe(@"full expr", ^{

            it(@"0;JMP", ^{
                Expr *j = [JumpExpr exprWithJump:@"JMP"];
                Expr *e = [CExpr destination:nil computation:zero jump:j];

                e.codeGen should equal(@"1110101010000111");
            });

            it(@"D=M-D", ^{
                Expr *comp = [SubstractExpr exprWithLHS:M RHS:D];
                Expr *dest = [DestinationExpr exprWithMnemonics:@"D"];
                Expr *e = [CExpr destination:dest computation:comp jump:nil];

                e.codeGen should equal(@"1111000111010000");
            });

        });

        describe(@"jump", ^{

            it(@"NULL", ^{
                Expr *e = [JumpExpr new];

                NSString *actual = [e codeGen];
                NSString *expected = @"000";

                actual should equal(expected);
            });

            it(@"JGT", ^{
                Expr *e = [JumpExpr exprWithJump:@"JGT"];

                NSString *actual = [e codeGen];
                NSString *expected = @"001";

                actual should equal(expected);
            });

            it(@"JEQ", ^{
                Expr *e = [JumpExpr exprWithJump:@"JEQ"];

                NSString *actual = [e codeGen];
                NSString *expected = @"010";

                actual should equal(expected);
            });

            it(@"JGE", ^{
                Expr *e = [JumpExpr exprWithJump:@"JGE"];

                NSString *actual = [e codeGen];
                NSString *expected = @"011";

                actual should equal(expected);
            });

            it(@"JLT", ^{
                Expr *e = [JumpExpr exprWithJump:@"JLT"];

                NSString *actual = [e codeGen];
                NSString *expected = @"100";

                actual should equal(expected);
            });

            it(@"JNE", ^{
                Expr *e = [JumpExpr exprWithJump:@"JNE"];

                NSString *actual = [e codeGen];
                NSString *expected = @"101";

                actual should equal(expected);
            });

            it(@"JLE", ^{
                Expr *e = [JumpExpr exprWithJump:@"JLE"];

                NSString *actual = [e codeGen];
                NSString *expected = @"110";

                actual should equal(expected);
            });

            it(@"JMP", ^{
                Expr *e = [JumpExpr exprWithJump:@"JMP"];

                NSString *actual = [e codeGen];
                NSString *expected = @"111";

                actual should equal(expected);
            });

        });

        describe(@"destination", ^{

            it(@"empty", ^{
                DestinationExpr *expr = [DestinationExpr new];
                NSString *actual = [expr codeGen];
                NSString *expected = @"000";

                actual should equal(expected);
            });

            it(@"M", ^{
                DestinationExpr *expr = [DestinationExpr exprWithMnemonics:@"M"];
                NSString *actual = [expr codeGen];
                NSString *expected = @"001";

                actual should equal(expected);
            });

            it(@"D", ^{
                DestinationExpr *expr = [DestinationExpr exprWithMnemonics:@"D"];
                NSString *actual = [expr codeGen];
                NSString *expected = @"010";

                actual should equal(expected);
            });

            it(@"A", ^{
                DestinationExpr *expr = [DestinationExpr exprWithMnemonics:@"A"];
                NSString *actual = [expr codeGen];
                NSString *expected = @"100";

                actual should equal(expected);
            });

            it(@"AD", ^{
                DestinationExpr *expr = [DestinationExpr exprWithMnemonics:@"AD"];
                NSString *actual = [expr codeGen];
                NSString *expected = @"110";

                actual should equal(expected);
            });
            
        });

        describe(@"computation", ^{

            context(@"const int", ^{

                it(@"0", ^{
                    NSString *actual = [zero codeGen];
                    NSString *expected = @"0101010";

                    actual should equal(expected);
                });

                it(@"1", ^{
                    NSString *actual = [one codeGen];
                    NSString *expected = @"0111111";

                    actual should equal(expected);
                });

            });

            context(@"mnemonics", ^{

                it(@"D", ^{
                    NSString *actual = [D codeGen];
                    NSString *expected = @"0001100";

                    actual should equal(expected);
                });

                it(@"A", ^{
                    NSString *actual = [A codeGen];
                    NSString *expected = @"0110000";

                    actual should equal(expected);
                });

                it(@"M", ^{
                    NSString *actual = [M codeGen];
                    NSString *expected = @"1110000";
                    
                    actual should equal(expected);
                });

            });

            context(@"not", ^{

                it(@"!D", ^{
                    Expr *expr = [NotExpr exprWithMnemonic:D];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0001101";

                    actual should equal(expected);
                });

                it(@"!A", ^{
                    Expr *expr = [NotExpr exprWithMnemonic:A];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0110001";

                    actual should equal(expected);
                });

                it(@"!M", ^{
                    Expr *expr = [NotExpr exprWithMnemonic:M];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"1110001";

                    actual should equal(expected);
                });

            });

            context(@"negative", ^{

                it(@"-D", ^{
                    Expr *expr = [NegativeExpr exprWithMnemonic:D];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0001111";

                    actual should equal(expected);
                });

                it(@"-A", ^{
                    Expr *expr = [NegativeExpr exprWithMnemonic:A];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0110011";

                    actual should equal(expected);
                });

                it(@"-M", ^{
                    Expr *expr = [NegativeExpr exprWithMnemonic:M];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"1110011";
                    
                    actual should equal(expected);
                });

                it(@"-1", ^{
                    Expr *expr = [NegativeExpr exprWithMnemonic:one];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0111010";

                    actual should equal(expected);
                });

            });

            context(@"increment", ^{

                it(@"D+1", ^{
                    Expr *expr = [SumExpr exprWithLHS:D RHS:one];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0011111";

                    actual should equal(expected);
                });

                it(@"A+1", ^{
                    Expr *expr = [SumExpr exprWithLHS:A RHS:one];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0110111";

                    actual should equal(expected);
                });

                it(@"M+1", ^{
                    Expr *expr = [SumExpr exprWithLHS:M RHS:one];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"1110111";

                    actual should equal(expected);
                });
                
            });

            context(@"decrement", ^{

                it(@"D-1", ^{
                    Expr *expr = [SubstractExpr exprWithLHS:D RHS:one];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0001110";

                    actual should equal(expected);
                });

                it(@"A-1", ^{
                    Expr *expr = [SubstractExpr exprWithLHS:A RHS:one];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0110010";

                    actual should equal(expected);
                });

                it(@"M-1", ^{
                    Expr *expr = [SubstractExpr exprWithLHS:M RHS:one];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"1110010";
                    
                    actual should equal(expected);
                });
                
            });

            context(@"sum", ^{

                it(@"D+A", ^{
                    Expr *expr = [SumExpr exprWithLHS:D RHS:A];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0000010";

                    actual should equal(expected);
                });

                it(@"D+M", ^{
                    Expr *expr = [SumExpr exprWithLHS:D RHS:M];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"1000010";
                    
                    actual should equal(expected);
                });
                
            });

            context(@"subtract", ^{

                it(@"D-A", ^{
                    Expr *expr = [SubstractExpr exprWithLHS:D RHS:A];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0010011";

                    actual should equal(expected);
                });

                it(@"D-M", ^{
                    Expr *expr = [SubstractExpr exprWithLHS:D RHS:M];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"1010011";

                    actual should equal(expected);
                });

                it(@"A-D", ^{
                    Expr *expr = [SubstractExpr exprWithLHS:A RHS:D];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0000111";

                    actual should equal(expected);
                });

                it(@"M-D", ^{
                    Expr *expr = [SubstractExpr exprWithLHS:M RHS:D];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"1000111";
                    
                    actual should equal(expected);
                });
                
            });

            context(@"AND", ^{

                it(@"D&A", ^{
                    Expr *expr = [AndExpr exprWithLHS:D RHS:A];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0000000";

                    actual should equal(expected);
                });

                it(@"D&M", ^{
                    Expr *expr = [AndExpr exprWithLHS:D RHS:M];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"1000000";

                    actual should equal(expected);
                });
                
            });

            context(@"OR", ^{

                it(@"D|A", ^{
                    Expr *expr = [OrExpr exprWithLHS:D RHS:A];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"0010101";

                    actual should equal(expected);
                });

                it(@"D|M", ^{
                    Expr *expr = [OrExpr exprWithLHS:D RHS:M];

                    NSString *actual = [expr codeGen];
                    NSString *expected = @"1010101";

                    actual should equal(expected);
                });
                
            });

        });

    });

});

SPEC_END
