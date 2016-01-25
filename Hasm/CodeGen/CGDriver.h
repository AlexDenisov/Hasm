//
//  CGDriver.h
//  Hasm
//
//  Created by AlexDenisov on 24/05/15.
//  Copyright (c) 2015 AlexDenisov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTree;

@interface CGDriver : NSObject

- (void)emitCodeGen:(HTree *)tree outputFile:(NSString *)fileName;

@end
