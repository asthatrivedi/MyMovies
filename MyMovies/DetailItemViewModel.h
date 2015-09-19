//
//  DetailItemViewModel.h
//  MyMovies
//
//  Created by Trivedi, Astha on 18/09/15.
//  Copyright (c) 2015 Astha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailItemViewModel : NSObject

@property (nonatomic, strong) NSString *infoType;
@property (nonatomic, strong) NSString *value;

+ (DetailItemViewModel *)viewModelWithInfoType:(NSString *)infoType andValue:(NSString *)value;

@end
