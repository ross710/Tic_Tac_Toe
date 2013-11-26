//
//  BoardView.m
//  TicTacToe
//
//  Created by Ross Tang Him on 11/26/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "BoardView.h"
#import "Square.h"

//#define BOARD_PADDING = 20;
//#define INNER_PADDING_RATIO = 10;
@interface BoardView()
@property (nonatomic) NSMutableArray *board;
@property (nonatomic) CGRect boardRect;
@property (nonatomic) NSNumber *size;
@property (nonatomic) Square *lastPlay;
//@property (nonatomic) NSNumber *win;
@end
@implementation BoardView
@synthesize board, boardRect, size, lastPlay;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        CGFloat padding = 20;
        CGFloat uWidth = screenWidth - padding*2;
        
        CGFloat top = screenHeight/4;
        CGFloat left = padding;
        
        size = [NSNumber numberWithInt:3];
        
        boardRect = CGRectMake(left, top, uWidth, uWidth);
        

    
        [self resetBoard];
        
    }
    return self;
}

-(void) resetBoard {
    NSUInteger s = [size integerValue];
    
    //allocate board
    board = [[NSMutableArray alloc] initWithCapacity:s];
    for (NSUInteger i = 0; i < s; i++) {
        [board addObject:[[NSMutableArray alloc] initWithCapacity:s]];
    }
    
    for (NSUInteger i = 0; i < s; i++)
    {
        for (NSUInteger j = 0; j < s; j++)
        {
            CGRect frame = CGRectMake(boardRect.origin.x + (CGFloat)i/(CGFloat)s*boardRect.size.height, boardRect.origin.y + (CGFloat)j/(CGFloat)s*boardRect.size.width, boardRect.size.width/s, boardRect.size.height/s);
            [[board objectAtIndex:i] addObject:[[Square alloc] initWithFrame: frame]];
        }
        
    }
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    //set background color to white
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    

    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGContextSetLineWidth(context, 2.0);
    
    CGFloat s = [size doubleValue];
    for (CGFloat i = 1; i < s; i++) {
        //draw vertical line
        CGContextMoveToPoint(context, boardRect.origin.x + boardRect.size.width*i/s, boardRect.origin.y);
        CGContextAddLineToPoint(context, boardRect.origin.x + boardRect.size.width*i/s, boardRect.origin.y + boardRect.size.height);
        
        //draw horizontal line
        CGContextMoveToPoint(context, boardRect.origin.x, boardRect.origin.y + boardRect.size.height*i/s);
        CGContextAddLineToPoint(context, boardRect.origin.x + boardRect.size.width, boardRect.origin.y + boardRect.size.height*i/s);
    }
    CGContextStrokePath(context);


    CGContextSetLineWidth(context, 5.0);

    for (NSUInteger i = 0; i < s; i++)
    {
        for (NSUInteger j = 0; j < s; j++)
        {
            Square *sq = [self getSquare:i :j];
            NSInteger type = [sq getType];
            if (type == 1) { //X
                CGRect frame = [sq getFrame];
                CGFloat paddingRatio = 10;
                
                CGFloat paddingH = frame.size.height/paddingRatio;
                CGFloat paddingW = frame.size.width/paddingRatio;
                
                CGFloat uWidth = frame.size.width - paddingW*2;
                CGFloat uHeight = frame.size.height - paddingH*2;
                

                CGContextMoveToPoint(context, frame.origin.x + paddingW, frame.origin.y + paddingH);
                CGContextAddLineToPoint(context, frame.origin.x + paddingW + uWidth, frame.origin.y + paddingH + uHeight);
                
                CGContextMoveToPoint(context, frame.origin.x + paddingW + uWidth, frame.origin.y + paddingH);
                CGContextAddLineToPoint(context, frame.origin.x + paddingW, frame.origin.y + paddingH + uHeight);
            }
            if (type == 2) { //O
                CGRect frame = [sq getFrame];
                CGFloat paddingRatio = 10;
                
                CGFloat paddingH = frame.size.height/paddingRatio;
                CGFloat paddingW = frame.size.width/paddingRatio;
                
                CGFloat uWidth = frame.size.width - paddingW*2;
                CGFloat uHeight = frame.size.height - paddingH*2;
                
                CGRect uFrame = CGRectMake(frame.origin.x + paddingW, frame.origin.y + paddingH, uWidth, uHeight);
                
                CGContextAddEllipseInRect(context, uFrame);
            }
        }
        
    }
    CGContextStrokePath(context);


}

-(Square *) getSquare: (NSUInteger) x : (NSUInteger) y {
    return [[board objectAtIndex:x] objectAtIndex:y];
}

//returns what type of win
-(NSDictionary *) hasWon {
    CGFloat s = [size doubleValue];
    NSUInteger type = 0;
    
    
    //check vertical wins
    for (NSUInteger i = 0; i < s; i++)
    {
        for (NSUInteger j = 0; j < s; j++)
        {
            if (j == 0) { //start at the first column
                type = [[self getSquare:i :j] getType];
                if (type == 0) {
                    return nil;
                }
            } else if ([[self getSquare:i :j] getType] != type){ //
                continue;
            } else if ((j == s - 1) && [[self getSquare:i :j] getType] == type) {
                NSLog(@"Vertical win, on row %d", i);
                return [[NSDictionary alloc] initWithObjects:@[[NSNumber numberWithInteger:i]] forKeys:@[@"Vertical"]];
            }
        }
    }
    
    
    //check horizontal wins
    for (NSUInteger i = 0; i < s; i++)
    {
        for (NSUInteger j = 0; j < s; j++)
        {
            if (i == 0) { //start at the first row
                type = [[self getSquare:i :j] getType];
                if (type == 0) {
                    return nil;
                }
            } else if ([[self getSquare:i :j] getType] != type){ //
                continue;
            } else if ((i == s - 1) && [[self getSquare:i :j] getType] == type) {
                NSLog(@"Horizontal win, on column %d", j);
                return [[NSDictionary alloc] initWithObjects:@[[NSNumber numberWithInteger:j]] forKeys:@[@"Horizontal"]];
            }
        }
    }
    
    //check diagonal wins
    //type 0 = top left to bottom right
    for (NSUInteger i = 0; i < s; i++)
    {
        if (i == 0) {
            type = [[self getSquare:i :i] getType];
            if (type == 0) {
                return nil;
            }
        } else if ([[self getSquare:i :i] getType] != type){ //
            break;
        } else if ((i == s - 1) && [[self getSquare:i :i] getType] == type) {
            NSLog(@"Diagonal win, from top left to bottom right");
            return [[NSDictionary alloc] initWithObjects:@[[NSNumber numberWithInteger:0]] forKeys:@[@"Diagonal"]];
        }
    }
    for (NSUInteger i = 0; i < s; i++)
    {
        if (i == 0) {
            type = [[self getSquare:i :(s-1)-i] getType];
            if (type == 0) {
                return nil;
            }
        } else if ([[self getSquare:i :(s-1)-i] getType] != type){ //
            break;
        } else if ((i == s - 1) && [[self getSquare:i :(s-1)-i] getType] == type) {
            NSLog(@"Diagonal win, from top left to bottom right");
            return [[NSDictionary alloc] initWithObjects:@[[NSNumber numberWithInteger:1]] forKeys:@[@"Diagonal"]];
        }
    }
    return nil;
}


-(void) handleTouch: (CGPoint) point {
    CGFloat s = [size doubleValue];

    for (NSUInteger i = 0; i < s; i++)
    {
        for (NSUInteger j = 0; j < s; j++)
        {

            Square *sq = [self getSquare:i :j];
            if ([sq isInside:point] && [sq getType] == 0) {
                
                if (lastPlay == nil) {
                    [sq changeType:1];
                } else if ([lastPlay getType] == 1) {
                    [sq changeType:2];
                } else if ([lastPlay getType] == 2) {
                    [sq changeType:1];
                }
                
                lastPlay = sq;
                [self setNeedsDisplay];
                [self hasWon];
                
            }
            
        }
        
    }
}


@end
