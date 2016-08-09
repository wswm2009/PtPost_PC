//
//  YYHelper.h
//  YYHOOK
//
//  Created by hongyangyi on 15/7/1.
//
//


#import <Foundation/Foundation.h>

@interface YYHelper : NSObject



+(void)YYLog:(NSString*)str,...;

+(NSArray *)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath;
+(BOOL)isFileExistAtPath:(NSString*)fileFullPath;
@end

