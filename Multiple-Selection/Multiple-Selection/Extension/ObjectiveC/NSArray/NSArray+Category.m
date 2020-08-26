//
//  NSArray+NSArray_Category.m
//  
//
//  Created by mac on 13-12-18.
//  Copyright (c) 2013年 babytree. All rights reserved.
//

#import "NSArray+Category.h"

@implementation NSArray (Category)

- (NSArray *)arrayBySortingStrings:(BOOL)ascending {
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: ascending];
    return [self sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortOrder]];
}

#pragma mark - Json Representation
- (NSString*)jsonRepresentation {
    NSString* json = nil;
    NSError* error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return (error ? nil : json);
}
@end

