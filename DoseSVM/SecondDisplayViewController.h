//
//  SecondDisplayViewController.h
//  DoseSVM
//
//  Created by Zhengni on 13-6-29.
//  Copyright (c) 2013年 epfl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondDisplayViewController : UIViewController
{
    IBOutlet UILabel *msgname;
}




@property(retain,strong) UILabel *msgname;
@property (strong, nonatomic) NSString *messageText;



@end
