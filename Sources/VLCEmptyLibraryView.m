/*****************************************************************************
 * VLCEmptyLibraryView.m
 * VLC for iOS
 *****************************************************************************
 * Copyright (c) 2018 VideoLAN. All rights reserved.
 * $Id$
 *
 * Authors: Mike JS. Choi <mkchoi212 # icloud.com>
 *
 * Refer to the COPYING file of the official project for license.
 *****************************************************************************/

#import <Foundation/Foundation.h>
#import "VLCEmptyLibraryView.h"
#import "VLCFirstStepsViewController.h"

@implementation VLCEmptyLibraryView

+ (instancetype)init
{
    NSArray *subviews = [[NSBundle mainBundle] loadNibNamed:@"VLCEmptyLibraryView" owner:self options:nil];
    NSAssert([subviews count] == 1, @"VLCEmptyLibraryView nib should contain only one subview");
    NSAssert([[subviews firstObject] isKindOfClass:[VLCEmptyLibraryView class]], @"Loaded VLCEmptyLibraryView nib is invalid");
    
    VLCEmptyLibraryView *view = subviews.firstObject;
    view.emptyLibraryLabel.text = NSLocalizedString(@"EMPTY_LIBRARY", nil);
    view.emptyLibraryLongDescriptionLabel.text = NSLocalizedString(@"EMPTY_LIBRARY_LONG", nil);
    [view.learnMoreButton setTitle:NSLocalizedString(@"BUTTON_LEARN_MORE", nil) forState:UIControlStateNormal];

    return view;
}

- (IBAction)learnMore:(id)sender
{
      UIViewController *firstStepsVC = [[VLCFirstStepsViewController alloc] initWithNibName:nil bundle:nil];
      UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:firstStepsVC];
      navCon.modalPresentationStyle = UIModalPresentationFormSheet;
      [self.window.rootViewController presentViewController:navCon animated:YES completion:nil];
}

@end
