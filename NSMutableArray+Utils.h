//
//  NSMutableArray+Utils.h
//  Minnaz
//
//  Created by Jignesh Bhensadadiya on 7/5/17.
//  Copyright © 2017 app. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Utils)

-(NSMutableArray *)sortAsc;
-(NSString *)joined:(NSString *)str;
-(BOOL)isExist:(id)obj;
-(NSUInteger)getIndexOfObject:(id)obj;
@end
