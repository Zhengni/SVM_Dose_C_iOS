//
//  DoseViewController.m
//  DoseSVM
//
//  Created by Zhengni on 13-6-29.
//  Copyright (c) 2013年 epfl. All rights reserved.
//

#import "DoseViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "SecondDisplayViewController.h"

//for server
#import "AFJSONRequestOperation.h"
#import "AFImageRequestOperation.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

@interface DoseViewController ()

@end

@implementation DoseViewController
@synthesize scrollview, textname,textage,textgender,textweight,button;
@synthesize messageText,count;

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
    
    self.title = @"Please type in your data";
	// Do any additional setup after loading the view.
    self.textname.delegate = self;
    self.textweight.delegate = self;

    self.textage.delegate = self;
    self.textgender.delegate = self;
    
    [button addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchUpInside];
    
    count = 0;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == textname) {
        [textname becomeFirstResponder];
    }
    
    else if (textField == textage) {
        [textage becomeFirstResponder];
    }
    
    else if (textField == textgender) {
        [textgender becomeFirstResponder];
    }
    
   
    else{
        [textweight resignFirstResponder];
        
    }
    
    //[textField resignFirstResponder];  //if need return dismiss keyboard everytime.
    // but scrollview is not that satisfied
    return YES;
  
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollview adjustOffsetToIdealIfNeeded];
}


-(void)dealloc
{
    [scrollview release];
    [textgender release];
    [textage release];
   
    [textname release];
    [textweight release];
    [button release];
    [super dealloc];
    
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Perform if the segue is by name @"First to second".
    if ([[segue identifier] isEqualToString:@"First to second"])
    {
        // Store the text we entered to messageText
        self.messageText = textname.text;
        // Get reference to the destination view controller
        SecondDisplayViewController *targetVC = [segue destinationViewController];
        // Pass any objects to the view controller here, like...
        targetVC.messageText = self.messageText;
    }
}


//set the button to upload IBAction
- (IBAction) pushButton:(id) sender
{
    count = count +1;
    
    [self uploadToServer:count]; //can upload, then check update
    //upload is ok
    
    
    
    
    //add subview
    //....
    
    
    //HOW TO DOWNLOAD FROM SERVER ? DOWNLOAD FROM URL MAYBE CHECK DOC OL
    
    
    //TO ENSURE CHANGE SEGUE AFTER THIS 可以在prepare for segue里面加if条件，确定从serverdownload之后再传。设targetVC.text(要显示的数据)/targetVC.image(要显示的图)
    
}

-(void) uploadToServer:(int)count
{
    NSString *name = textname.text; //means a new data/sample
    NSString *age = textage.text;
    NSString *sex = textgender.text;
    NSString *w = textweight.text;
    NSString *c = [NSString stringWithFormat:@"%d",count];
    
    
    NSLog(@"%@",c);
    //
    // 1. Set up Target URL
    //
    NSString *url = @"http://127.0.0.1:8888/index.php";
    //
    // 2. Set up the request object
    //
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    //
    // 3. Add the header information
    //
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    //
    // 4. Create the body of the post
    //
    NSMutableData *body = [NSMutableData data];
    

    // 4-1. Add Name/Age/Sex/Weight in the body
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"c\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[c dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[name dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"age\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[age dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"sex\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[sex dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"w\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[w dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //
    // 5. Set the body of the post to the reqeust
    //
    [request setHTTPBody:body];
    
    //
    // 6. Make the connection to the web
    //
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse* reponse, NSData* data, NSError* error)
     {
         
         if ([data length] >0 && error == nil)
         {
             NSLog(@"Data was uploaded to server");
         }
         else if ([data length] == 0 && error == nil)
         {
             NSLog(@"Nothing was uploaded");
         }
         else if (error != nil)
         {
             NSLog(@"Error = %@", error);
         }
     }];
    NSLog(@"finish");
    
}



@end
