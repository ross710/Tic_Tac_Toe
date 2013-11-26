//
//  Square.m
//  TicTacToe
//
//  Created by Ross Tang Him on 11/26/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "Square.h"

@interface Square()
//types:
//0 = E
//1 = X
//2 = O
@property (nonatomic) NSNumber *type;
@property (nonatomic) CGRect frame;
@end

@implementation Square
@synthesize frame;
@synthesize type;

//-(id) init {
//    if (self == [super init]) {
//        
//    }
//    return self;
//}

-(id) initWithFrame : (CGRect) frame_ {
    if (self == [super init]){
        frame = frame_;
        type = [NSNumber numberWithInt:0];
    }
    return self;
}

-(void) changeType : (NSUInteger) type_ {
    type = [NSNumber numberWithInt:type_];
}

-(NSUInteger) getType {
    return [type integerValue];
}

-(CGRect) getFrame {
    return frame;
}
-(BOOL) isInside : (CGPoint) point {
    if ((point.x >= frame.origin.x) && (point.x <= (frame.origin.x + frame.size.width))) {
        if ((point.y >= frame.origin.y) && (point.y <= (frame.origin.y + frame.size.height))) {
            return YES;
        }
    }
    return NO;
}
@end
