//
//  DetailItemViewModel.m
//  MyMovies
//
//  Created by Trivedi, Astha on 18/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import "DetailItemViewModel.h"

@implementation DetailItemViewModel

+ (DetailItemViewModel *)viewModelWithInfoType:(NSString *)infoType andValue:(NSString *)value {
    DetailItemViewModel *viewModel = [[DetailItemViewModel alloc] init];
    viewModel.infoType = infoType;
    viewModel.value = value;
    
    return viewModel;
}

@end
