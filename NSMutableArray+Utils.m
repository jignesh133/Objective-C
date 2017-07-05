//
//  NSMutableArray+Utils.m
//  Minnaz
//
//  Created by Jignesh Bhensadadiya on 7/5/17.
//  Copyright © 2017 app. All rights reserved.
//

#import "NSMutableArray+Utils.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation NSMutableArray (Utils)

-(NSMutableArray *)sortAsc{
    return (NSMutableArray *)[self sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}
-(NSString *)joined:(NSString *)str{
    return [self componentsJoinedByString:str];
}
-(BOOL)isExist:(id)obj{
    return [self containsObject:obj];
}
-(NSUInteger)getIndexOfObject:(id)obj{
    return [self indexOfObject: obj];
}
@end
