//
//  wiNSString+MD5HexDigest.m
//  wiIos
//
//  Created by qq on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>

#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation NSString (Category)

#pragma mark - UUID
- (NSString*)uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


#pragma mark - Date
- (NSDate *)dateWithFormat:(NSString*)dateFormat {
    NSDateFormatter *formator = [[NSDateFormatter alloc] init];
    [formator setDateFormat:dateFormat];
    NSDate *date = [formator dateFromString:self];
    return date;
}

#pragma mark - File Utility


+ (NSString *)getCGFormattedFileSize:(long long)size
{
    if (size > 1024*1024)
    {
        float s = size/1024.0/1024.0;
        return [NSString stringWithFormat:@"%.1fM",s];
    }
    else if(size > 1024)
    {
        float s = size/1024.0;
        return [NSString stringWithFormat:@"%.1fK",s];
    }
    
    return [NSString stringWithFormat:@"%lld",size];
}

- (NSString *) getFileName {
    NSString *fileName;
    NSArray *pathComponents = [self pathComponents];
    if (pathComponents.count > 0) {
        fileName = [NSString stringWithString:[pathComponents lastObject]];
    }else {
        return @"";
    }
    return fileName;
}

- (NSString *) getFilePath
{
    return [self stringByDeletingLastPathComponent];
}


- (NSString *)getFullFileExtension
{
    NSString *extension = [self pathExtension];
    if (![extension isEqualToString:@""])
    {
        extension = [NSString stringWithFormat:@".%@", extension];
    }
    
    return extension;
}

#pragma mark - Validation

// Is Valid Email

- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

// Is Valid Phone

- (BOOL)isValidPhoneNumber
{
    NSString *regex = @"[235689][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:self];
}

// Is Valid URL

- (BOOL)isValidUrl
{
    NSString *regex =@"((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}


- (BOOL) isValidPassword
{
    NSString *patternStr = @"^[a-zA-Z0-9]{6,16}$";
    
    NSPredicate *strTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", patternStr];
    if ([strTest evaluateWithObject:self])
    {
        NSLog(@"%@ is Valid UserPasswd", self);
        return YES;
    }
    
    NSLog(@"%@ is inValid UserPasswd", self);
    return NO;
}


- (BOOL)isValid {
    return ([[self trim] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]) ? NO :YES;
}

// 校验验证码
- (BOOL) isVerifyCode
{
    NSString *patternStr = @"^[0-9]{4,8}$";
    
    NSPredicate *strTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", patternStr];
    if ([strTest evaluateWithObject:self])
    {
        NSLog(@"%@ is Valid VerifyCode", self);
        return YES;
    }
    
    NSLog(@"%@ is inValid VerifyCode", self);
    return NO;
}


- (BOOL) isPureInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL) isPureFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    
    float val;
    
    return [scan scanFloat:&val] && [scan isAtEnd];
}


- (BOOL)containsString:(NSString *)subString {
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}


- (BOOL)isBeginsWith:(NSString *)string {
    return ([self hasPrefix:string]) ? YES : NO;
}


- (BOOL)isEndssWith:(NSString *)string {
    return ([self hasSuffix:string]) ? YES : NO;
}

- (BOOL)isEqualIgnoreCase:(NSString*)str {
    return [[self lowercaseString] isEqualToString:[str lowercaseString]];
}

- (BOOL)isEmptyOrWhitespace {
    return !self.length ||
    ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}

// If my string contains ony letters
- (BOOL)containsOnlyLetters {
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// If my string contains only numbers
- (BOOL)containsOnlyNumbers {
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

- (BOOL)containsOnlyNumbersWithDecimal {
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"-0123456789."] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

- (BOOL)containsOnlyNumbersWithDot {
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

- (BOOL)containsOnlyNumbersWithDotAndBracket {
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.()"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// If my string contains letters and numbers
- (BOOL)containsOnlyNumbersAndLetters {
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

#pragma mark - Trim


- (NSString *)trimEnd {
    NSString *string1;
    
    string1 = [[@"a" stringByAppendingString:self] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [string1 substringFromIndex:1];
}

- (NSString *)trimStart {
    NSString *string1;
    
    string1 = [[self stringByAppendingString:@"a"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [string1 substringToIndex:[string1 length]-1];
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}



- (NSString *) appendRandom:(NSInteger)ram {
    int randValue = arc4random();
    if (randValue < 0)
    {
        randValue = randValue * -1;
    }
    randValue = randValue % (ram+1);
    return [NSString stringWithFormat:@"%@%d", self, randValue];
}


- (NSString *)removeCharacterSet:(NSString *)strCharacterSet
{
    //e.g = /.,()-+
    NSCharacterSet *toExclude = [NSCharacterSet characterSetWithCharactersInString:strCharacterSet];
    return [[self componentsSeparatedByCharactersInSet:toExclude] componentsJoinedByString:@""];
}



#pragma mark - Size From Text

- (CGSize)sizeForMaxWidth:(CGFloat)width withFont:(UIFont *)font {
    /*
     NSTextStorage *textStorage = [[NSTextStorage alloc]
     initWithString:self];
     NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize: CGSizeMake(width, MAXFLOAT)];
     NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
     [layoutManager addTextContainer:textContainer];
     [textStorage addLayoutManager:layoutManager];
     [textStorage addAttribute:NSFontAttributeName value:font
     range:NSMakeRange(0, [textStorage length])];
     [textContainer setLineFragmentPadding:0.0];
     
     [layoutManager glyphRangeForTextContainer:textContainer];
     CGRect frame = [layoutManager usedRectForTextContainer:textContainer];
     return CGSizeMake(ceilf(frame.size.width),ceilf(frame.size.height));
     */
    
    return [self sizeForMaxWidth:width withAttributes:@{NSFontAttributeName : font}];
    
}

- (CGSize)sizeForMaxWidth:(CGFloat)width withAttributes:(NSDictionary *)attributes {
    /*
     NSAttributedString *attrutedString = [[NSAttributedString alloc] initWithString:self attributes:attributes];
     
     UITextView *tempTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
     [tempTextView setTextContainerInset:UIEdgeInsetsZero];
     tempTextView.textContainer.lineFragmentPadding = 0;
     
     tempTextView.attributedText = attrutedString;
     [tempTextView.layoutManager glyphRangeForTextContainer:tempTextView.textContainer];
     
     CGRect usedFrame = [tempTextView.layoutManager usedRectForTextContainer:tempTextView.textContainer];
     
     return CGSizeMake(ceilf(usedFrame.size.width),ceilf(usedFrame.size.height));
     */
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceilf(size.width);
    size.height = ceilf(size.height);
    return size;
}

- (CGSize)sizeForMaxHeight:(CGFloat)height withFont:(UIFont *)font {
    return [self sizeForMaxHeight:height withAttributes:@{NSFontAttributeName : font}];
    
}

- (CGSize)sizeForMaxHeight:(CGFloat)height withAttributes:(NSDictionary *)attributes {
    CGSize size = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceilf(size.width);
    size.height = ceilf(size.height);
    return size;
}


#pragma mark - Emoji

- (BOOL)isAllEmojisAndSpace {
    NSArray *array = [self componentsSeparatedByCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0] ;
    for(NSString *word in array) {
        [output appendString:word];
    }
    return [output isAllEmojis];
}

- (BOOL)isAllEmojis {
    __block BOOL returnValue = YES;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        if (![substring isEmoji]) {
            returnValue = NO;
            *stop = YES;
        }
    }];
    return returnValue;
}


- (BOOL)isContainsEmojis {
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         if ([substring isEmoji]) {
             returnValue = YES;
             *stop = YES;
         }
     }];
    return returnValue;
}

- (BOOL)isNotEmpty {
    return !(self == nil
             || [self isKindOfClass:[NSNull class]]
             || ([self respondsToSelector:@selector(length)]
                 && [(NSData *)self length] == 0)
             || ([self respondsToSelector:@selector(count)]
                 && [(NSArray *)self count] == 0));
}

- (BOOL)isEmoji {
    if (![self isNotEmpty]) {
        return NO;
    }
    if (self.length > 2) {
        return NO;
    }
    
    const unichar hs = [self characterAtIndex:0];
    
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                return YES;
            }
        }
    }
    else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3) {
            return YES;
        }
    }
    else {
        if (0x2100 <= hs && hs <= 0x27ff) {
            return YES;
        }
        else if (0x2B05 <= hs && hs <= 0x2b07) {
            return YES;
        }
        else if (0x2934 <= hs && hs <= 0x2935) {
            return YES;
        }
        else if (0x3297 <= hs && hs <= 0x3299) {
            return YES;
        }
        else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            return YES;
        }
    }
    
    return NO;
}

- (NSArray *)disassembleEmojis {
    __block NSMutableString *string = [[NSMutableString alloc] init] ;
    __block NSMutableArray *strArray = [[NSMutableArray alloc] initWithCapacity:0] ;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         
         if ([substring isEmoji]) {
             NSDictionary *strDic = nil;
             NSDictionary *emojiDic = nil;
             
             if ([string isNotEmpty]) {
                 strDic = [[NSDictionary alloc] initWithObjectsAndKeys:string, @"text", @"text", @"tag", nil] ;
                 [strArray addObject:strDic];
                 string = [[NSMutableString alloc] init] ;
             }
             
             emojiDic = [[NSDictionary alloc] initWithObjectsAndKeys:substring, @"text", @"emoji", @"tag", nil] ;
             [strArray addObject:emojiDic];
         }
         else {
             [string appendString:substring];
         }
     }];
    
    if ([string isNotEmpty]) {
        NSDictionary *strDic = nil;
        strDic = [[NSDictionary alloc] initWithObjectsAndKeys:string, @"text", @"text", @"tag", nil] ;
        [strArray addObject:strDic];
    }
    return strArray;
}


- (NSString *)parameterEmojis {
    __block NSMutableString *string = [[NSMutableString alloc] init] ;
    __block NSMutableString *subText = [[NSMutableString alloc] init] ;
    NSString *allText = nil;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         
         if ([substring isEmoji])
         {
             if (string.length > 0)
             {
                 [string appendString:@","];
             }
             
             if ([subText isNotEmpty])
             {
                 NSString *str = [NSString stringWithFormat:@"{\"tag\":\"text\",\"text\":\"%@\"},", subText];
                 [string appendString:str];
                 subText = [[NSMutableString alloc] init] ;
             }
             
             NSString *str = [NSString stringWithFormat:@"{\"tag\":\"emoji\",\"text\":\"%@\"}", substring];
             [string appendString:str];
         }
         else
         {
             if ([substring isEqualToString:@"\""])
             {
                 substring = @"\\\"";
             }
             if ([substring isEqualToString:@"\\"])
             {
                 substring = @"\\\\";
             }
             [subText appendString:substring];
         }
         
     }];
    
    if ([subText isNotEmpty])
    {
        if (string.length > 0)
        {
            [string appendString:@","];
        }
        
        NSString *str = [NSString stringWithFormat:@"{\"tag\":\"text\",\"text\":\"%@\"}", subText];
        [string appendString:str];
    }
    
    allText = [NSString stringWithFormat:@"[%@]", string];
    return allText;
}



#pragma mark - Paths

+ (NSString *)cachesPath {
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    });
    
    return cachedPath;
}

+ (NSString *)documentsPath {
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    });
    
    return cachedPath;
}

+ (NSString *)libraryPath {
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    });
    
    return cachedPath;
}

+ (NSString *)bundlePath {
    return [[NSBundle mainBundle] bundlePath];
}


#pragma mark Temporary Paths

+ (NSString *)temporaryPath {
    static dispatch_once_t onceToken;
    static NSString *cachedPath;
    
    dispatch_once(&onceToken, ^{
        cachedPath = NSTemporaryDirectory();
    });
    
    return cachedPath;
}

+ (NSString *)pathForTemporaryFile {
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    NSString *tmpPath = [[NSString temporaryPath] stringByAppendingPathComponent:(__bridge NSString *)newUniqueIdString];
    CFRelease(newUniqueId);
    CFRelease(newUniqueIdString);
    
    return tmpPath;
}

#pragma mark Working with Paths

// sdfds123 --> sdfds124
- (NSString *)pathByIncrementingSequenceNumber {
    NSString *baseName = [self stringByDeletingPathExtension];
    NSString *extension = [self pathExtension];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\(([0-9]+)\\)$" options:0 error:NULL];
    __block NSInteger sequenceNumber = 0;
    
    [regex enumerateMatchesInString:baseName options:0 range:NSMakeRange(0, [baseName length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
        
        NSRange range = [match rangeAtIndex:1]; // first capture group
        NSString *substring= [self substringWithRange:range];
        
        sequenceNumber = [substring integerValue];
        *stop = YES;
    }];
    
    NSString *nakedName = [baseName pathByDeletingSequenceNumber];
    
    if ([extension isEqualToString:@""])
    {
        return [nakedName stringByAppendingFormat:@"(%ld)", (long)sequenceNumber+1];
    }
    
    return [[nakedName stringByAppendingFormat:@"(%ld)", (long)sequenceNumber+1] stringByAppendingPathExtension:extension];
}

// sdfds123 --> sdfds
- (NSString *)pathByDeletingSequenceNumber {
    NSString *baseName = [self stringByDeletingPathExtension];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\([0-9]+\\)$" options:0 error:NULL];
    __block NSRange range = NSMakeRange(NSNotFound, 0);
    
    [regex enumerateMatchesInString:baseName options:0 range:NSMakeRange(0, [baseName length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop) {
        
        range = [match range];
        
        *stop = YES;
    }];
    
    if (range.location != NSNotFound) {
        return [self stringByReplacingCharactersInRange:range withString:@""];
    }
    
    return self;
}

#pragma mark - Application
// Get My Application Version number
+ (NSString *)getMyApplicationVersion {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleVersion"];
    return version;
}

// Get My Application name
+ (NSString *)getMyApplicationName {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [info objectForKey:@"CFBundleDisplayName"];
    return name;
}


#pragma mark - String and data

// Convert string to NSData
- (NSData *)convertToData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// Get String from NSData
+ (NSString *)getStringFromData:(NSData *)data {
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
}


#pragma mark - Word Count
- (NSUInteger)countNumberOfWords {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil]) {
        count++;
    }
    return count;
}

- (NSInteger)zeroCountAfterDecimal {
    NSArray *arr = [self componentsSeparatedByString:@"."];
    NSInteger zeroCount = 0;
    if (arr.count == 2) {
        NSString *base = [arr objectAtIndex:1];
        for (int b = 0; b<[base length]; b++) {
            int temp = [[base substringWithRange:NSMakeRange(b, 1)] intValue];
            if (temp == 0) {
                zeroCount ++;
            }else{
                return zeroCount;
            }
        }
    }else{
        return 0;
    }
    return 0;
}
#pragma mark - get lines
- (NSArray *)getLinesWithFont:(UIFont*)font forMaxWidth:(CGFloat)maxWidth
{
    NSString *text = self;
    
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:( id)font range:NSMakeRange(0, attStr.length)];
    
    CFRelease(myFont);
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,maxWidth,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        
        [linesArray addObject:lineString];
        
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    
    
    return (NSArray *)linesArray;
}

#pragma mark - Other
- (NSString *)stringByAddingThousandSeperator {
    if (![self containsOnlyNumbersWithDecimal]) {
        return self;
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setCurrencySymbol:@""];
    [numberFormatter setLocale:[NSLocale currentLocale]];
    
    [numberFormatter setMaximumFractionDigits:15];
    NSString *s = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[[self stringByReplacingOccurrencesOfString:@" " withString:@""] doubleValue]]];
    s = [s stringByReplacingOccurrencesOfString:@"," withString:@" "];
    return s;
}

- (NSString *)stringByAddingThousandSeperatorWithMaxFractionDigit:(NSInteger)maxFraction {
    if (![self containsOnlyNumbersWithDecimal]) {
        return self;
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setCurrencySymbol:@""];
    [numberFormatter setLocale:[NSLocale currentLocale]];
    
    [numberFormatter setMaximumFractionDigits:maxFraction];
    NSString *s = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[[self stringByReplacingOccurrencesOfString:@" " withString:@""] doubleValue]]];
    s = [s stringByReplacingOccurrencesOfString:@"," withString:@" "];
    return s;
}

////


- (NSString *)subStringBetween:(NSString*)firstChar ToSecondChar:(NSString *)secondChar {
    NSRange start = [self rangeOfString:firstChar];
    NSRange end = [self rangeOfString:secondChar];
    if (start.location != NSNotFound && end.location != NSNotFound && end.location > start.location) {
        NSString *betweenBrackets = [self substringWithRange:NSMakeRange(start.location+1, end.location-(start.location+1))];
        return betweenBrackets;
    }
    return @"";
}

- (NSString *)stringByReplacingFirstOccurenceOfString:(NSString *)fromStr withString:(NSString *)toStr{
    if ([self containsString:fromStr]) {
        NSRange location = [self rangeOfString:fromStr];
        NSString* result = [self stringByReplacingCharactersInRange:location withString:toStr];
        return result;
    }
    
    return self;
}

- (BOOL)isVideoNotMp4
{
    NSRange range = [self rangeOfString:@".3gp" options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    range = [self rangeOfString:@".avi" options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    range = [self rangeOfString:@".flv" options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    range = [self rangeOfString:@".asf" options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    range = [self rangeOfString:@".mkv" options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    range = [self rangeOfString:@".rm" options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    range = [self rangeOfString:@".rmvb" options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    range = [self rangeOfString:@".wmv" options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    range = [self rangeOfString:@".swf" options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    return NO;
}

// only the first one
- (NSTextCheckingResult*)checkLinkWithType:(NSTextCheckingTypes)type
{
    __block NSTextCheckingResult* foundResult = nil;
    
    if (self && (type > 0))
    {
        NSError* error = nil;
        NSDataDetector* linkDetector = [NSDataDetector dataDetectorWithTypes:type error:&error];
        [linkDetector enumerateMatchesInString:self options:0 range:NSMakeRange(0,[self length])
                                    usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
         {
#if __has_feature(objc_arc)
             foundResult = result;
#else
             foundResult = [[result retain] autorelease];
#endif
             *stop = YES;
         }];
    }
    
    return foundResult;
}

// only the first one
- (NSURL*)extendedURLWithType:(NSTextCheckingTypes)type
{
    NSTextCheckingResult *checkingResult = [self checkLinkWithType:type];
    
    if (checkingResult == nil)
    {
        return nil;
    }
    
    NSURL* url = checkingResult.URL;
    if (checkingResult.resultType == NSTextCheckingTypeAddress)
    {
        NSString* baseURL = ([UIDevice currentDevice].systemVersion.floatValue >= 6.0) ? @"maps.apple.com" : @"maps.google.com";
        NSString* mapURLString = [NSString stringWithFormat:@"http://%@/maps?q=%@", baseURL,
                                  [checkingResult.addressComponents.allValues componentsJoinedByString:@","]];
        url = [NSURL URLWithString:mapURLString];
    }
    else if (checkingResult.resultType == NSTextCheckingTypePhoneNumber)
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [checkingResult.phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    }
    return url;
}

#pragma mark - Parse Json;
- (id)parseJson {
    id object = [NSJSONSerialization JSONObjectWithData:[self convertToData]
                                                options:NSJSONReadingMutableContainers error:nil];
    return object;
}

#pragma mark - Remove HTML Tags

-(NSString *) stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

#pragma mark - Query string param for key
- (NSString *)queryArgumentForKey:(NSString *)key withDelimiter:(NSString *)delimiter
{
    NSURL *url = [NSURL URLWithString:[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    for (NSString *obj in [[url query]  componentsSeparatedByString:delimiter]) {
        NSArray *keyAndValue = [obj componentsSeparatedByString:@"="];
        
        if (([keyAndValue count] >= 2) && ([[keyAndValue objectAtIndex:0] caseInsensitiveCompare:key] == NSOrderedSame)) {
            return [keyAndValue objectAtIndex:1];
        }
    }
    
    return nil;
}

- (NSString *)queryArgumentForKey:(NSString *)key
{
    NSString		*delimiter;
    
    // The arguments in query strings can be delimited with a semicolon (';') or an ampersand ('&'). Since it's not
    // likely a single URL would use both types of delimeters, we'll attempt to pick one and use it.
    if ([self rangeOfString:@";"].location != NSNotFound) {
        delimiter = @";";
    } else {
        // Assume '&' by default, since that's more common
        delimiter = @"&";
    }
    
    return [self queryArgumentForKey:key withDelimiter:delimiter];
}


- (NSString *)stringByAddingPercentEncodingForRFC3986 {
    NSString *unreserved = @"-._~/?";
    NSMutableCharacterSet *allowed = [NSMutableCharacterSet
                                      alphanumericCharacterSet];
    [allowed addCharactersInString:unreserved];
    return [self
            stringByAddingPercentEncodingWithAllowedCharacters:
            allowed];
}

@end


