//
//  SecondDisplayViewController.m
//  to show the text field input in the label of the 2nd view
//  DoseSVM
//
//  Created by Zhengni on 13-6-29.
//  Copyright (c) 2013年 epfl. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>



#import "SecondDisplayViewController.h"

@interface SecondDisplayViewController ()

@end

@implementation SecondDisplayViewController
@synthesize messageText;
@synthesize msgname;

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
    msgname.text = self.messageText;
	// Do any additional setup after loading the view.
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
