//
//  DoseViewController.h
//  DoseSVM
//
//  Created by Zhengni on 13-6-29.
//  Copyright (c) 2013年 epfl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPKeyboardAvoidingScrollView;

@interface DoseViewController : UIViewController<UITextFieldDelegate>
{
    TPKeyboardAvoidingScrollView *scrollview;
    IBOutlet UITextField *textname;
    IBOutlet UITextField *textage;
    IBOutlet UITextField *textgender;

    IBOutlet UITextField *textweight;
    
    int count;
    UIButton *button;
}


@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollview;
@property (nonatomic,retain) UITextField *textname;
@property (nonatomic,retain) UITextField *textage;
@property (nonatomic,retain) UITextField *textgender;

@property (nonatomic,retain) UITextField *textweight;

@property (nonatomic) int count;

@property (nonatomic,retain) IBOutlet UIButton *button;
- (IBAction) pushButton:(id) sender;

@property (strong, nonatomic) NSString *messageText;



@end
