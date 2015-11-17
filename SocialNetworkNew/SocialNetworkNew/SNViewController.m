//
//  ViewController.m
//  SocialNetworkNew
//
//  Created by Ihor Zabrotsky on 10/30/15.
//  Copyright (c) 2015 Ihor Zabrotsky. All rights reserved.
//

#import "SNViewController.h"

@interface SNViewController ()<VKSdkDelegate>

@end

@implementation SNViewController
{
    NSMutableArray  *arr;
}


- (void)viewDidLoad {
    [super viewDidLoad];

//    arr  =  [NSArray  arrayWithObjects:@"first", @"second", @"third", nil];
    
    

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [VKSdk initializeWithDelegate:self andAppId:@"5118020"];

    
    if ([VKSdk isLoggedIn])  {
        
        NSLog(@"YES");
        
    }
    else  {
        
        NSLog(@"NO");
        
    }
    
    if (![VKSdk wakeUpSession]) {
        
        NSArray *scope = @[@"friends"];
        [VKSdk authorize:scope];
        
        NSLog(@"%@",  [[VKSdk  getAccessToken]  userId]);

        
        
    }  else  {
        
        NSLog(@"wakeUpSession will die");

        
//        [VKSdk forceLogout];
        
    }
    
    if  ([[VKSdk  getAccessToken]  userId])  {
        
        NSDictionary  *mydict1  =  [NSDictionary dictionaryWithObjectsAndKeys:
                                    [[VKSdk      getAccessToken]  userId], @"user_id",
                                    @"20", @"count",
                                    @"random", @"order",
                                    @"domain", @"fields",
                                    nil];
        
        VKRequest  *someReq  =  [  [VKApi  friends]  get:mydict1];
        
        [someReq  executeWithResultBlock:^(VKResponse  *response)  {
            
            NSLog(@"Json result: %@",  response.json);
            
            NSLog(@"Response try: %@",  response.json[@"count"]);
            
            arr  =  [NSMutableArray  array];
            
            for (int i = 0; i < 4; i++)  {
                
                [arr addObject:[  [response.json[@"items"]  objectAtIndex:i]  objectForKey:@"first_name" ]  ];
                
                NSLog(@"%@", [  [response.json[@"items"]  objectAtIndex:i]  objectForKey:@"first_name" ]);
            }
            
            //        [arr removeAllObjects];
            
            NSLog(@"My arr:%@", arr);
            
            [self.tableView  reloadData];
            
            
            
        }  errorBlock:^(NSError  *error) {
            if (error.code  !=  VK_API_ERROR) {
                [error.vkError.request  repeat];
            }
            else  {
                NSLog(@"VK error: %@",  error);
            }
        }];

        
        
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - VKSdkDelegate

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    
}

/**
 Notifies delegate about existing token has expired
 @param expiredToken old token that has expired
 */
- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    
}

/**
 Notifies delegate about user authorization cancelation
 @param authorizationError error that describes authorization error
 */
- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError {
    
//    NSArray *scope = @[@"friends,audio"];
//    [VKSdk authorize:scope];
}

/**
 Pass view controller that should be presented to user. Usually, it's an authorization window
 @param controller view controller that must be shown to user
 */
- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    
    [self presentViewController:controller
                       animated:YES
                     completion:^{}];
}

/**
 Notifies delegate about receiving new access token
 @param newToken new token for API requests
 */
- (void)vkSdkReceivedNewToken:(VKAccessToken *)newToken {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MyArrayCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text  =  [arr  objectAtIndex:indexPath.row];
    return cell;

}



@end
