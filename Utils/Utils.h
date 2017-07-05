
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define kTutorialScreenHide                               @"kTutorialScreenHide"

@interface Utils : NSObject

+ (NSString*)stringWithFloat:(CGFloat)_float;

+(NSMutableDictionary *)recursiveNull:(NSMutableDictionary *)dictionary;

+(NSDate *)getDateFromserverDate:(NSString *)str;

+(NSArray *)convertCommaSepratedStringToArray:(NSString *)str;

+(NSString *)convertArrayToCommaSepratedString:(NSArray *)arr;

+(NSString*)MonthNameString:(int)monthNumber;

+(NSString *)TimeFromDate:(NSDate *)date;

+(NSArray *)convertStringToArray:(NSString *)strData;

+(NSString *)dateFormatDDMMYYYYHHMMA:(NSDate *)date;

+(NSDate *)ConvertstringToDate:(NSString *)date;

+(NSString *)dateFormatDDMMYYYY:(NSDate *)date;

+(NSString *)dateFormatYYYYMMDD:(NSDate *)date;
+(CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font;
+(void)SetCategoryObjectID:(NSString *)objID;
+(NSString *)encodeUrlString:(NSString *)string;
+(void)setDailyReminder:(BOOL)value;
+(void)setMessage:(BOOL)value;
+(void)setForum:(BOOL)value;
+(void)setNewMatirial:(BOOL)value;
+(void)setReminderTime:(NSString*)value;

+(BOOL)getDailyReminder;
+(BOOL)getMessage;
+(BOOL)getForum;
+(BOOL)getNewMatirial;
+(NSString *)getReminderTime;




+(void)setGooglLanguageArray:(NSMutableArray *)arr;
+(NSMutableArray *)getGoogleLanguageArray;

+(id)addBottomBorderToTextField:(id)txtField;

+(NSString *)getCommaSepratedStringFromArray:(NSArray *)arr;

+(void)setWordMeaning:(NSString *)str;

+(NSString *)getWordMeaning;

+(void *)clearWordMeaning;

+(void)setLaxinLanguagePrefix:(NSMutableArray *)arr;

+(NSMutableArray *)getLaxinLanguagePrefix;

+(void)setGoogleLanguagePrefix:(NSMutableArray *)arr;

+(NSMutableArray *)getGoogleLanguagePrefix;

+(CGSize)getStringSize:(UIFont *)font andString:(NSString *)str;

+(BOOL)validateEmailWithString:(NSString*)email;

+(void)speechFromText:(NSString *)txt;

+(void)setlaxinLanguageArray:(NSMutableArray *)arr;

+(NSMutableArray *)getlaxinArray;

+ (CGFloat)getLabelHeight:(UILabel*)label;


+(NSString *)getWordCount;

#pragma mark - Userdefault

+ (void) setValue:(NSString *)value Key:(NSString *)key;

+ (NSString *) getValueForKey:(NSString *)key;

+ (BOOL)getBoolForKey:(NSString *)key;

+ (void)setBool:(BOOL)value Key:(NSString *)key;

+ (NSString *)getCurrencyStringFromAmount:(float)amount;

+ (void)setObject:(NSDictionary *)value Key:(NSString *)key;

+ (NSNumber *)generateRandomNumber;

+ (NSDictionary *)getObjectForKey:(NSString *)key;

+ (NSString *)getFileName:(UIImageView *)imgView;

+ (UIViewController *)getTopViewController;

+(NSString *)getStringDateFromserverDateForTimeStampwithTimezone:(NSString *)str;

+(NSString *)getStringDateFromserverDateForTimeStampwithTimezoneandhhmmaddmmm:(NSString *)str;

+(NSString *)removeWhiteSpace:(NSString *)str;

+(NSString *)removeNull:(NSString *)str;

+ (NSString *) hexFromUIColor:(UIColor *)color;

+ (NSString *) base64EncodeImage: (UIImage*)image;

+(NSString *)dateFormatMMddyyyyHHmm:(NSDate* )date;

+(NSString *)dateFormatDDMMYYYYWithCurrentTimeZone:(NSDate *)date;

+(NSString *)dateFormathMMAWithCurrentTimeZone:(NSDate *)date;

+(NSDate *)getDateFromserverDateForTimeStamp:(NSString *)str;

+(NSDate *)getDateFromserverDateForTimeStampwithTimezone:(NSString *)str;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (NSAttributedString *)attributedTextViewString:(NSMutableArray *)arr;

+(NSAttributedString *)attributedStringForString:(NSString *)str;

+ (UIViewController*) topMostController;

+(void)showAlertDismissActionWithMessage:(NSString *)msg;

+(NSMutableArray *)getDeviceJSON;

+ (UIImage *)cropImageAccordingToSize:(UIImage *)img andSize:(CGSize)newSize;

+(UILabel *)roundCornersOnView:(UILabel *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius;

@end
