//
//  LeftMenuVC.m
//  AMSlideMenu
//
// The MIT License (MIT)
//
// Created by : arturdev
// Copyright (c) 2014 SocialObjects Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

#import "SMLeftMenuVC.h"
#import "sensmove-swift.h"
#import "ReactiveCocoa.h"

@interface SMLeftMenuVC()

@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) SMUserService *userService;
@property (nonatomic, weak) IBOutlet UILabel *firstName;
@property (nonatomic, weak) IBOutlet UIImageView *userPicture;
@property (nonatomic, weak) IBOutlet UILabel *numberOfSessions;

@end

@implementation SMLeftMenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userService = [SMUserService sharedInstance];
    [self initializeUserProfile];
}

/**
 *  Initialize user profile in left side menu
 */
- (void)initializeUserProfile
{
    self.firstName.text = self.userService.currentUser.firstName;
    [self setImage];

    /// Observe change on sessions array then set the correct value in side menu
    [RACObserve(self.userService.currentUser, sessions) subscribeNext:^(NSMutableArray *sessions) {
        if (sessions != nil) {
            [self setSessions:[NSString stringWithFormat:@"%lu sessions", sessions.count]];
        }
    }];
}

/**
 *  Set number of session text
 *  :param: numberOfSessions
 */
- (void)setSessions:(NSString *)numberOfSessions {
    self.numberOfSessions.text = numberOfSessions;
}

/**
 *  Set user picture
 */
- (void)setImage
{
    self.userPicture.layer.cornerRadius = self.userPicture.frame.size.height /2;
    self.userPicture.layer.masksToBounds = YES;
    self.userPicture.layer.borderWidth = 0;
    self.userPicture.image =  [UIImage imageNamed:self.userService.currentUser.picturePath];
}

@end