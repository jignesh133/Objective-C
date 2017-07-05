
#import "Utils.h"
#import <AVFoundation/AVFoundation.h>
#import "Constants.h"


@implementation Utils

+ (NSString*)stringWithFloat:(CGFloat)_float
{
    NSString *format = (NSInteger)_float == _float ? @"%.0f" : @"%.2f";
    return [NSString stringWithFormat:format, _float];
}

+(NSDate *)getDateFromserverDate:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}
+(NSDate *)getDateFromserverDateForTimeStamp:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}
+(NSDate *)getDateFromserverDateForTimeStampwithTimezone:(NSString *)str{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date = [dateFormatter dateFromString:str]; // create date from string
    
    // change to a readable time format and change to local time zone
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *timestamp = [dateFormatter stringFromDate:date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    return [dateFormatter dateFromString:timestamp];
}
+(NSString *)getStringDateFromserverDateForTimeStampwithTimezone:(NSString *)str{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date = [dateFormatter dateFromString:str]; // create date from string
    
    // change to a readable time format and change to local time zone
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *timestamp = [dateFormatter stringFromDate:date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDate *dt = [dateFormatter dateFromString:timestamp];
    
    return [dateFormatter stringFromDate:date];
}

+(NSString *)getStringDateFromserverDateForTimeStampwithTimezoneandhhmmaddmmm:(NSString *)str{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date = [dateFormatter dateFromString:str]; // create date from string
    
    // change to a readable time format and change to local time zone
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"hh:mm a,dd MMM"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *timestamp = [dateFormatter stringFromDate:date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a,dd MMM"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *dt = [dateFormatter dateFromString:timestamp];
    return [dateFormatter stringFromDate:date];
}

+(NSString *)convertArrayToCommaSepratedString:(NSArray *)arr{
    if ([arr count]==0) {
        return @"";
    }
    return [arr componentsJoinedByString:@","];
}
+(NSArray *)convertCommaSepratedStringToArray:(NSString *)strData{
    if ([strData length]==0) {
        return [[NSArray alloc] init];
    }
    return [strData componentsSeparatedByString:@","];
}

+(NSString*)MonthNameString:(int)monthNumber
{
    NSDateFormatter *formate = [NSDateFormatter new];
    [formate setDateFormat:@"MM"];
    
    NSArray *monthNames = [formate standaloneMonthSymbols];
    
    NSString *monthName = [monthNames objectAtIndex:(monthNumber - 1)];
    
    return monthName;
}
+ (NSMutableDictionary *)recursiveNull:(NSMutableDictionary *)dictionary {
    for (NSString *key in [dictionary allKeys]) {
        id nullString = [dictionary objectForKey:key];
        if ([nullString isKindOfClass:[NSDictionary class]]) {
            [self recursiveNull:(NSMutableDictionary*)nullString];
        } else {
            if ((NSString*)nullString == (id)[NSNull null])
                [dictionary setValue:@"" forKey:key];
        }
    }
    return dictionary;
}


+ (UIColor *)colorWithHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
+(NSString *)encodeUrlString:(NSString *)string {
    return CFBridgingRelease(
                             CFURLCreateStringByAddingPercentEscapes(
                                                                     kCFAllocatorDefault,
                                                                     (__bridge CFStringRef)string,
                                                                     NULL,
                                                                     CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                     kCFStringEncodingUTF8)
                             );
}


+ (NSString *) hexFromUIColor:(UIColor *)color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0] green:components[0] blue:components[0] alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0]*255.0), (int)((CGColorGetComponents(color.CGColor))[1]*255.0), (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

+(BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

+ (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}

+(void)speechFromText:(NSString *)txt {
    if (txt.length <= 0) {
        return;
    }
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:txt];
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
    [synth speakUtterance:utterance];
}

+(NSAttributedString *)attributedStringForString:(NSString *)str {
    return [[NSAttributedString alloc] initWithString:str];
}

+(void)showAlertDismissActionWithMessage:(NSString *)msg {
    if (![msg hasSuffix:@"."]) {
        NSString *dot = @".";
        msg = [msg stringByAppendingString:dot];
    }
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okayAction];
    [[Utils topMostController] presentViewController:alert animated:true completion:nil];
}

+(id)addBottomBorderToTextField:(id)txtField {
    UIView *vw  = txtField;
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, vw.frame.size.height - borderWidth, vw.frame.size.width, vw.frame.size.height);
    border.borderWidth = borderWidth;
    [vw.layer addSublayer:border];
    vw.layer.masksToBounds = YES;
    return txtField;
}
+ (UIImage *) resizeImage: (UIImage*) image toSize: (CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString *) base64EncodeImage: (UIImage*)image {
    NSData *imagedata = UIImagePNGRepresentation(image);
    
    // Resize the image if it exceeds the 2MB API limit
    if ([imagedata length] > 2097152) {
        CGSize oldSize = [image size];
        CGSize newSize = CGSizeMake(800, oldSize.height / oldSize.width * 800);
        image = [self resizeImage: image toSize: newSize];
        imagedata = UIImagePNGRepresentation(image);
    }
    
    NSString *base64String = [imagedata base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    return base64String;
}

#pragma mark -

+(NSString *)TimeFromDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    NSString *timeformat = [formatter stringFromDate:date];
    return timeformat;
}
+(BOOL)getDailyReminder{
    BOOL value;
    value = [[NSUserDefaults standardUserDefaults] boolForKey:kDailyReminder];
    return value;
}
+(BOOL)getForum{
    BOOL value;
    value = [[NSUserDefaults standardUserDefaults] boolForKey:kForum];
    return value;
}
+(BOOL)getMessage{
    BOOL value;
    value = [[NSUserDefaults standardUserDefaults] boolForKey:kMessage];
    return value;
}
+(BOOL)getNewMatirial{
    BOOL value;
    value = [[NSUserDefaults standardUserDefaults] boolForKey:kNewMaterial];
    return value;
}


+(void)clearWordMeaning{
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:kWordMeaning];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getCommaSepratedStringFromArray:(NSArray *)arr{
        NSString *joinedComponents = [arr componentsJoinedByString:@","];
        return joinedComponents;
}
+(NSString *)removeNull:(NSString *)str{
    return [str stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
}
+(CGSize)getStringSize:(UIFont *)font andString:(NSString *)str{

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    CGSize constraint = CGSizeMake(screenWidth/2, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [str boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size;
}
+ (CGFloat)getLabelHeight:(UILabel*)label
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    CGSize constraint = CGSizeMake(screenWidth/2, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height;
}

+(NSString *)removeWhiteSpace:(NSString *)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
+(NSString *)dateFormatDDMMYYYYHHMMA:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy  hh:mm a"];
    NSString *dateformat = [formatter stringFromDate:date];
    return dateformat;

}
+(NSString *)dateFormatDDMMYYYY:(NSDate *)date{
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateformat = [formatter stringFromDate:date];
    return dateformat;
}
+(NSString *)dateFormatDDMMYYYYWithCurrentTimeZone:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSTimeZone *localTimeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:localTimeZone];
    NSString *dateformat = [formatter stringFromDate:date];
    return dateformat;
}
+(NSString *)dateFormathMMAWithCurrentTimeZone:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:MM a"];
    NSTimeZone *localTimeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:localTimeZone];
    NSString *dateformat = [formatter stringFromDate:date];
    return dateformat;
}
+(NSString *)dateFormatYYYYMMDD:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateformat = [formatter stringFromDate:date];
    return dateformat;
    
}
+(NSDate *)ConvertstringToDate:(NSString *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    return  [formatter dateFromString:date];
}
+(NSArray *)convertStringToArray:(NSString *)strData{
    if ([strData length]==0) {
        return [[NSArray alloc] init];
    }
    NSData *data = [strData dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return json;
}
+ (NSString *)getValueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]
            stringForKey:key];
}
+ (NSDictionary *)getObjectForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]
            valueForKey:key];
}

+ (void)setValue:(NSString *)value Key:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)setObject:(NSDictionary *)value Key:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)setBool:(BOOL)value Key:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (UIViewController *)getTopViewController{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}
+ (BOOL)getBoolForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (NSNumber *)generateRandomNumber{
    int randNum = rand() % (10000 - 0) + 0;
    
    return [NSNumber numberWithInt:randNum];
}
+ (NSString *)getFileName:(UIImageView *)imgView{
    NSString *imgName = [imgView image].accessibilityIdentifier;
    NSLog(@"%@",imgName);
    return imgName;
}

+ (NSAttributedString *)attributedTextViewString:(NSMutableArray *)arr
{
    NSMutableAttributedString *paragraph = [[NSMutableAttributedString alloc] initWithString:@"Hello" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];

    for (NSString * str in arr) {
       NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:str
                                        attributes:@{@"tappable":@(YES),
                                                     @"networkCallRequired": @(YES),
                                                     @"loadCatPicture": @(NO)}];
         [paragraph appendAttributedString:attributedString];
        
    }

    return [paragraph copy];
}


+(NSString *)dateFormatMMddyyyyHHmm:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateformat = [formatter stringFromDate:date];
    
    NSDateFormatter *dFormatter = [[NSDateFormatter alloc] init];
    [dFormatter setDateFormat:@"HH:mm"];
    NSString *timeformat = [dFormatter stringFromDate:date];
    
    NSString * totalStr = [NSString stringWithFormat:@"%@ %@", dateformat, timeformat];
    
    return totalStr;
}

+ (NSString *)getCurrencyStringFromAmount:(float)amount {
    NSString * ss = [Utils getCurrencyStringFromAmountString:[NSString stringWithFormat:@"%.2f", amount]];
    NSString *someText = ss;
    NSRange range = NSMakeRange(0,1);
    NSString *newText = [someText stringByReplacingCharactersInRange:range withString:@"$"];
    return newText;
}
//
+ (NSString *)getCurrencyStringFromAmountString:(NSString *)amount {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [formatter setLenient:YES];
    [formatter setGeneratesDecimalNumbers:YES];
    NSDecimalNumber *number = (NSDecimalNumber*) [formatter numberFromString:amount];
    return [formatter stringFromNumber:number];
}

+(NSMutableArray *)getDeviceJSON{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"document" ofType:@"json"];
    
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSMutableArray * devices = [json objectForKey:@"devices"];
    return devices;
}

+ (UIImage *)cropImageAccordingToSize:(UIImage *)img andSize:(CGSize)newSize{
    int x =0,y = 0,width = 0,height = 0;
    if (img.size.width > newSize.width) {
        int difference = img.size.width - newSize.width;
        x = difference/2;
        width = newSize.width;
    }else{
        width = img.size.width;
    }
    if (img.size.height > newSize.height) {
        int difference = img.size.height - newSize.height;
        y = difference / 2;
        height = newSize.height;
    }else{
        height = img.size.height;
    }
    
    CGRect cropRegion = CGRectMake(x, y, width, height);
    CGImageRef subImage = CGImageCreateWithImageInRect(img.CGImage, cropRegion);
    UIImage *croppedImage = [UIImage imageWithCGImage:subImage];
    return croppedImage;
}

+(UILabel *)roundCornersOnView:(UILabel *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius {
    if (tl || tr || bl || br) {
        UIRectCorner corner = 0;
        if (tl) corner = corner | UIRectCornerTopLeft;
        if (tr) corner = corner | UIRectCornerTopRight;
        if (bl) corner = corner | UIRectCornerBottomLeft;
        if (br) corner = corner | UIRectCornerBottomRight;
        
        UILabel *roundedView = view;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:roundedView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = roundedView.bounds;
        maskLayer.path = maskPath.CGPath;
        roundedView.layer.mask = maskLayer;
        return roundedView;
    }
    return view;
}

@end
