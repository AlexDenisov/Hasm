#import "AExpr.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AExprSpec)

describe(@"AExpr", ^{

    describe(@"equality", ^{

        it(@"label", ^{
            AExpr *lhs = [AExpr exprWithLabel:@"label"];
            AExpr *rhs = [AExpr exprWithLabel:@"label"];

            lhs should equal(rhs);
        });

        it(@"number", ^{
            AExpr *lhs = [AExpr exprWithNumber:@12];
            AExpr *rhs = [AExpr exprWithNumber:@12];

            lhs should equal(rhs);
        });

        it(@"label and number", ^{
            AExpr *lhs = [AExpr exprWithLabel:@"label"];
            AExpr *rhs = [AExpr exprWithNumber:@12];

            lhs should_not equal(rhs);
        });

    });

});

SPEC_END
