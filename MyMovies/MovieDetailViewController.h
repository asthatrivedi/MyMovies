//
//  MovieDetailViewController.h
//  MyMovies
//
//  Created by Trivedi, Astha on 14/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieDetailViewModel;

@interface MovieDetailViewController : UITableViewController

- (void)setupViewModel:(MovieDetailViewModel *)inViewModel;

@end
