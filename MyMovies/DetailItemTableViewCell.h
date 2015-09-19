//
//  DetailItemTableViewCell.h
//  MyMovies
//
//  Created by Trivedi, Astha on 18/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailItemViewModel;

@interface DetailItemTableViewCell : UITableViewCell

- (void)setupViewModel:(DetailItemViewModel *)inViewModel;

@end
