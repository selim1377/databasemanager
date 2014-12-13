//
//  ViewController.m
//  DatabaseManager
//
//  Created by Selim on 13.12.14.
//  Copyright (c) 2014 Selim Bakdemir. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    DatabaseManager *db = [[DatabaseManager alloc] initWithDatabase:@"sgk.sqlite"];
    if ([db open]){
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
