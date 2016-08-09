//
//  NSMutableData+MD5.m
//  DMNetworking
//
//  Created by zj-dt0094 on 16/4/5.
//  Copyright © 2016年 Vito. All rights reserved.
//

#import "NSData-MD5.h"

@implementation NSData (MD5)


- (NSString*)MD5String
{
    const char* original_str = (const char *)[self bytes];
    CC_LONG len=[self length] ;
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5(original_str, len, digist);
    NSMutableString* outPutStr = [NSMutableString string];
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        [outPutStr appendFormat:@"%02x",digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
    }
    
    return [outPutStr lowercaseString];
    
}

@end