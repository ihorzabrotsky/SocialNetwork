//
//  ViewController.h
//  SocialNetworkNew
//
//  Created by Ihor Zabrotsky on 10/30/15.
//  Copyright (c) 2015 Ihor Zabrotsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKSdk.h"

@interface SNViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView * tableView;

@end

