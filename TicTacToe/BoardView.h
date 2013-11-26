//
//  BoardView.h
//  TicTacToe
//
//  Created by Ross Tang Him on 11/26/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardView : UIView
-(void) handleTouch: (CGPoint) point;
-(void) resetBoard;
@end
