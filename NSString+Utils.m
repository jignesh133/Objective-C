#import "NSString+Utils.h"
#import <UIKit/UIKit.h>

@implementation NSString (Utils)
-(BOOL)isEmpty{
    if ([[self removeSpace] length]==0) {
        return YES;
    }
    return NO;
}
-(NSString *)removeSpace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
-(NSString *)makeUrl{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
}
- (NSString *)camelCased{
    NSMutableString *result = [NSMutableString new];
    NSArray *words = [self componentsSeparatedByString: @" "];
    for (uint i = 0; i < words.count; i++) {
        if (i==0) {
            [result appendString:((NSString *) words[i]).withLowercasedFirstChar];
        }
        else {
            [result appendString:((NSString *)words[i]).withUppercasedFirstChar];
        }
    }
    return result;
}
- (NSString *)pascalCased{
    NSMutableString *result = [NSMutableString new];
    NSArray *words = [self componentsSeparatedByString: @" "];
    for (NSString *word in words) {
        [result appendString:word.withUppercasedFirstChar];
    }
    return result;
}
-(NSString *)withUppercasedFirstChar{
    if (self.length <= 1) {
        return self.uppercaseString;
    } else {
        return [NSString stringWithFormat:@"%@%@",[[self substringToIndex:1] uppercaseString],[self substringFromIndex:1]];
    }
}
- (NSString *)withLowercasedFirstChar {
    if (self.length <= 1) {
        return self.lowercaseString;
    } else {
        return [NSString stringWithFormat:@"%@%@",[[self substringToIndex:1] lowercaseString],[self substringFromIndex:1]];
    }
}
-(NSString *)amount{
    NSNumber *someNumber = [NSNumber numberWithDouble:[self doubleValue]];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    return  [nf stringFromNumber:someNumber];
}
-(BOOL)isValidUserName{
    NSString *emailRegex = @"^([a-z0-9]+[._])*[a-z0-9]+$";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [regex evaluateWithObject:self];
}
-(BOOL)isValidEmail{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
-(BOOL)isvalidName{
    NSString *emailRegex = @"[a-zA-z]+([ '-][a-zA-Z]+)*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:self];
    return isValid;
}
-(BOOL)isvalidPhoneNo{
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
-(BOOL)isvalidUrl{
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:self];
}
-(BOOL)isValidFullName{
    NSString *nameRegex = @"([^\\s]+)\\s([^\\s]+)(.*)";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject: self];
}
-(BOOL)isMinLength:(int)Minlength andMaximumLength:(int)Maxlength{
    if ([self length]>=Minlength && [self length]<=Maxlength) {
        return YES;
    }
    return NO;
}
-(BOOL)isValidPassword{
    NSString *regex = @"^(?=.{10,})(?=.*[0-9])(?=.*[a-zA-Z])([@#$%^&=a-zA-Z0-9_-]+)$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return  [passwordTest evaluateWithObject:self];
}
-(NSArray *)arrayComponentSepratedByString:(NSString *)str{
    return [self componentsSeparatedByString:str];
}
-(NSString *)append:(NSString *)str{
    return [self stringByAppendingString:str];
}
-(NSString *)Firstname{
    if ([self isValidFullName]) {
        NSArray *arr = [[self removeSpace] componentsSeparatedByString:@" "];
        [arr firstObject];
    }
    return @"Invalid Name";
}
-(NSString *)Lastname{
    if ([self isValidFullName]) {
        NSArray *arr = [[self removeSpace] componentsSeparatedByString:@" "];
        [arr lastObject];
    }
    return @"Invalid Name";
}

@end
