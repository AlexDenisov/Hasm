//
//  NSString+h_binaryString.m
//  Hasm
//
//  Created by AlexDenisov on 23/05/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import "NSString+h_binaryString.h"

@implementation NSString (h_binaryString)

+ (NSString *)binaryStringFromNumber:(short)number {
    NSMutableString * string = [[NSMutableString alloc] init];

    int spacing = pow( 2, 3 );
    int width = ( sizeof( number ) ) * spacing;
    int binaryDigit = 0;
    int integer = number;

    while ( binaryDigit < width ) {
        binaryDigit++;

        [string insertString:( (integer & 1) ? @"1" : @"0" )atIndex:0];
        integer = integer >> 1;
    }

    return string;
}

@end
