//
//  ViewController.m
//  Strong_weak
//
//  Created by y on 2018/1/23.
//  Copyright © 2018年 cy. All rights reserved.
// test demo

#import "ViewController.h"

@protocol TaskDelegate <NSObject>

- (void)taskDone;

@end

@interface Task : NSObject

@property (nonatomic, weak) id <TaskDelegate> delegate;

@property (nonatomic, strong) NSTimer *timer;

- (void)doSomething;

@end

@implementation Task

- (void)doSomething {
    if ([self.delegate respondsToSelector:@selector(taskDone)]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run:) userInfo:nil repeats:YES];
        [self.timer fire];
        [self.delegate taskDone];
    }
    [self cleanup];
}

- (void)run:(NSTimer *)timer {
    NSLog(@"run"); // run run run...
}

- (void)cleanup {
    NSLog(@"cleanup");
}

- (void)dealloc { // not 
    NSLog(@"dealloc");
}

@end

@interface ViewController () <TaskDelegate>

@property (nonatomic, strong) Task *task;

@end

@implementation ViewController

- (void)taskDone {
    NSLog(@"taskDone %@", _task);
    _task = nil; // 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.task = [[Task alloc] init];
    self.task.delegate = self;
    [_task doSomething];
}

@end
