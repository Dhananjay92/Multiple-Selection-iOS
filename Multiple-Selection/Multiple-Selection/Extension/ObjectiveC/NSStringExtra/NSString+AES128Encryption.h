//
//  NSString+AES128Encryption.h
//  
//

//

#import <Foundation/Foundation.h>
#import "CommonCrypto/CommonCrypto.h"

@interface NSString (AES128Encryption)
- (NSString*) encrypt;
- (NSString*) decrypt;
@end
