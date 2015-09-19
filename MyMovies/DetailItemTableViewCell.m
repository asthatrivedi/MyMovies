//
//  DetailItemTableViewCell.m
//  MyMovies
//
//  Created by Trivedi, Astha on 18/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "DetailItemTableViewCell.h"

#import "DetailItemViewModel.h"

@interface DetailItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *infoType;
@property (weak, nonatomic) IBOutlet UILabel *value;

@end

@implementation DetailItemTableViewCell

- (void)setupViewModel:(DetailItemViewModel *)inViewModel {
    self.infoType.text = inViewModel.infoType;
    self.value.text = inViewModel.value;
}

@end
