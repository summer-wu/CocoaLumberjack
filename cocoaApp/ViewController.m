//
//  ViewController.m
//  cocoaApp
//
//  Created by n on 2017/4/18.
//
//

#import "ViewController.h"
#import "LogManager.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [NSColor redColor].CGColor;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)startLog:(id)sender {
    [[LogManager sharedInstance] createAndAdd3Loggers];
}

- (IBAction)writeLog10K:(id)sender {
    //0123456789abcdef //0x10 字节 共0x10000 字节
    for (NSInteger i=0; i<0x10000/0x10; i++) {
        NSString *s = [NSString stringWithFormat:@"%ld 0123456789abcdef",i];
        LogManagerAddLogNoFunctionName(s);
    }
}

- (IBAction)writeLog100K:(id)sender {
    for (NSInteger i=0; i<10; i++) {
        [self writeLog10K:nil];
    }
}



@end
