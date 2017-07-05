//
//  NSString+Utils.h
//  Minnaz
//
//  Created by Jignesh Bhensadadiya on 7/5/17.
//  Copyright © 2017 app. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)
-(NSString *)removeSpace;
-(NSString *)makeUrl;
-(NSString *)Firstname;
-(NSString *)Lastname;
-(NSString *)append:(NSString *)str;
-(NSString *)camelCased;
-(NSString *)pascalCased;
-(NSString *)withUppercasedFirstChar;
-(NSString *)withLowercasedFirstChar;
-(NSString *)amount;


-(NSArray *)arrayComponentSepratedByString:(NSString *)str;
-(BOOL)isValidPassword;
-(BOOL)isMinLength:(int)Minlength andMaximumLength:(int)Maxlength;
-(BOOL)isEmpty;
-(BOOL)isValidUserName;
-(BOOL)isValidEmail;
-(BOOL)isvalidName;
-(BOOL)isvalidPhoneNo;
-(BOOL)isvalidUrl;
-(BOOL)isValidFullName;


@end
