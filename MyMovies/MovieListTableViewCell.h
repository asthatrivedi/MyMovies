//
//  MovieListTableViewCell.h
//  MyMovies
//
//  Created by Trivedi, Astha on 16/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieDetailViewModel;

@interface MovieListTableViewCell : UITableViewCell

- (void)setupMovieListCellWithViewModel:(MovieDetailViewModel *)viewModel;

@end
