//
//  wiNSString+MD5HexDigest.h
//
//
//  Created by qq on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NSString (Category)

#pragma mark - UUID
- (NSString*)uuid;

#pragma mark - Date
- (NSDate *)dateWithFormat:(NSString*)dateFormat;

#pragma mark - File

+ (NSString *)getCGFormattedFileSize:(long long)size;

- (NSString *) getFileName;
- (NSString *) getFilePath;
- (NSString *) getFullFileExtension;

#pragma mark - Validation
- (BOOL)isNotEmpty;
- (BOOL) isValidEmail;
- (BOOL) isValidPhoneNumber;
- (BOOL) isValidUrl;
- (BOOL) isValidPassword;
- (BOOL) isValid;
- (BOOL) isVerifyCode;
- (BOOL) isPureInt;
- (BOOL) isPureFloat;

- (BOOL) isBeginsWith:(NSString *)string;
- (BOOL) isEndssWith:(NSString *)string;

- (BOOL) isEqualIgnoreCase:(NSString*)str;

- (BOOL)isEmptyOrWhitespace;

- (BOOL) containsString:(NSString *)subString;
- (BOOL) containsOnlyLetters;
- (BOOL) containsOnlyNumbers;
- (BOOL) containsOnlyNumbersWithDecimal;
- (BOOL) containsOnlyNumbersAndLetters;
- (BOOL) containsOnlyNumbersWithDot;
- (BOOL) containsOnlyNumbersWithDotAndBracket;

#pragma mark - trim

- (NSString *) trimEnd;
- (NSString *) trimStart;
- (NSString *) trim;
- (NSString *) trimSpace;
- (NSString *) appendRandom:(NSInteger)ram;
- (NSString *)removeCharacterSet:(NSString *)strCharacterSet;

#pragma mark - Size From Text

- (CGSize) sizeForMaxWidth:(CGFloat)width withFont:(UIFont *)font;
- (CGSize) sizeForMaxWidth:(CGFloat)width withAttributes:(NSDictionary *)attributes;

- (CGSize)sizeForMaxHeight:(CGFloat)height withFont:(UIFont *)font;
- (CGSize)sizeForMaxHeight:(CGFloat)height withAttributes:(NSDictionary *)attributes;

#pragma mark - Emoji

- (BOOL) isAllEmojis;
- (BOOL) isAllEmojisAndSpace;
- (BOOL) isContainsEmojis;
- (BOOL) isEmoji;
- (NSArray *) disassembleEmojis;
- (NSString *) parameterEmojis;

#pragma mark - paths

+ (NSString *) cachesPath;
+ (NSString *) documentsPath;
+ (NSString *) libraryPath;
+ (NSString *) bundlePath;
+ (NSString *) temporaryPath;
+ (NSString *) pathForTemporaryFile;
- (NSString *) pathByIncrementingSequenceNumber;
- (NSString *) pathByDeletingSequenceNumber;


#pragma mark - Application
+ (NSString *)getMyApplicationVersion;
+ (NSString *)getMyApplicationName;


#pragma mark - String and data
- (NSData *) convertToData;
+ (NSString *) getStringFromData:(NSData *)data;

#pragma mark - get lines
- (NSArray *)getLinesWithFont:(UIFont*)font forMaxWidth:(CGFloat)maxWidth;

#pragma mark - Count
- (NSUInteger) countNumberOfWords;
- (NSInteger) zeroCountAfterDecimal;

#pragma mark - Other
- (NSString *) stringByAddingThousandSeperator;
- (NSString *) stringByAddingThousandSeperatorWithMaxFractionDigit:(NSInteger)maxFraction;
- (NSString *) stringByReplacingFirstOccurenceOfString:(NSString *)fromStr withString:(NSString *)toStr;

- (BOOL) isVideoNotMp4;
- (NSTextCheckingResult*) checkLinkWithType:(NSTextCheckingTypes)type;
- (NSURL*) extendedURLWithType:(NSTextCheckingTypes)type;

#pragma mark - parseJson
- (id)parseJson;

#pragma mark - Remove HTML Tags
-(NSString *) stringByStrippingHTML;


#pragma mark - Query string param for key
- (NSString *)queryArgumentForKey:(NSString *)key withDelimiter:(NSString *)delimiter;
- (NSString *)queryArgumentForKey:(NSString *)key;

- (NSString *)stringByAddingPercentEncodingForRFC3986;

@end
