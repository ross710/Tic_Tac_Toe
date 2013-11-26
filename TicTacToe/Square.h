//
//  Square.h
//  TicTacToe
//
//  Created by Ross Tang Him on 11/26/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Square : NSObject
-(id) initWithFrame : (CGRect) frame_;
-(void) changeType : (NSUInteger) type_;
-(NSUInteger) getType;
-(BOOL) isInside : (CGPoint) point;
-(CGRect) getFrame;
@end
