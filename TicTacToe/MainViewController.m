//
//  MainViewController.m
//  TicTacToe
//
//  Created by Ross Tang Him on 11/26/13.
//  Copyright (c) 2013 Ross Tang Him. All rights reserved.
//

#import "MainViewController.h"
#import "BoardView.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    UIBarButtonItem *newGame = [[UIBarButtonItem alloc] initWithTitle:@"New Game" style:UIBarButtonItemStylePlain target:self action:@selector(newGame)];
    [[self navigationItem] setRightBarButtonItem:newGame];
    
    BoardView *board = [[BoardView alloc] init];
//    board.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self setView:board];
    

    
}

-(void) newGame {
    [(BoardView *)self.view resetBoard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    [(BoardView *)self.view handleTouch:touchLocation];

//    for (UIView *view in self.view.subviews)
//    {
//        if ([view isKindOfClass:[BoardView class]] &&
//            CGRectContainsPoint(view.frame, touchLocation))
//        {
//            [(BoardView *)view handleTouch:touchLocation];
//        }
//    }
}
@end
