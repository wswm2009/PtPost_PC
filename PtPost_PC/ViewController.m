//
//  ViewController.m
//  PtPost_PC
//
//  Created by zj-dt0094 on 16/4/21.
//  Copyright © 2016年 zj-dt0094. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "NSData-MD5.h"
#import "NSImage-extend.h"
#import "YYHelper.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}




-(void)showAlertBox:(NSString *) msgTitle inTxt:(NSString *)msgTxt
{
    NSAlert* msgBox = [[[NSAlert alloc] init] autorelease];
    [msgBox setMessageText: msgTxt];
    [msgBox addButtonWithTitle: msgTitle];
    [msgBox runModal];
}








-(void) SavePostHairMaskPic:(NSString *)fileDir arg2:(NSString *)fileName arg3:(void(^)(void)) completion
{
    
    @autoreleasepool {
        
        NSString *path=[NSString stringWithFormat:@"%@%@",fileDir,fileName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path]) {
            if (completion) {
                completion();
            }
        }
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSImage  *myImage=[[NSImage alloc]initWithContentsOfFile:path];
       // [myImage imageResize:NSSizeFromCGSize(CGSizeMake(321, 321))];
        NSBitmapImageRep* tmpRep = [[myImage representations] objectAtIndex:0];
        [tmpRep setSize:NSMakeSize(321, 321)];
        NSDictionary* imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
        NSData* imageData = [tmpRep representationUsingType:NSJPEGFileType properties:imageProps];
        [YYHelper YYLog:fileDir,[NSString stringWithFormat:@"%@  %d",fileName,[imageData length]],nil];

        [myImage release];
        myImage=nil;
        NSString *str= [imageData base64EncodedStringWithOptions:0];
        imageData=nil;
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        [dic setObject:@"1" forKeyedSubscript:@"type"];
        [dic setObject:str  forKeyedSubscript:@"photo_data"];
        NSMutableData *data2=[NSMutableData dataWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *str2=[NSString stringWithFormat:@"%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c",0x72, 0x44,0x7A, 0x6F,0x69,0x65,0x35, 0x65,0x33, 0x6F, 0x6E,0x67, 0x66, 0x7A,0x31,0x6C];
        [data2 appendData:[str2 dataUsingEncoding:NSUTF8StringEncoding]];
       NSString *strMD5Key=[data2 MD5String];
        [dic setObject:strMD5Key forKeyedSubscript:@"key"];
        

    
        // 设置请求格式
        manager.requestSerializer = [AFHTTPRequestSerializer serializer ];
        // 设置返回格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];

        [manager POST:@"http://tu.qq.com/cgi/doHairMask.php" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *result=  [dic2 objectForKey:@"photo_data"];
            if ([result isKindOfClass:[NSString class]])
            {
                NSData *photoData=[[NSData alloc]initWithBase64EncodedString:result options:0];
                NSString *DesDirPath = [NSString stringWithFormat:@"%@/Documents/DesPic/%@", NSHomeDirectory(),fileName];
                [photoData writeToFile:DesDirPath atomically:YES];
                [photoData release];
//                double deltaTime3 = [[NSDate date] timeIntervalSinceDate:tmpStartData];
//                [YYHelper YYLog:[NSString stringWithFormat:@"Post cost: %f",deltaTime3],nil];
            }
            if (completion) {
                completion();
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            if (completion) {
                completion();
            }
            
        }];
    }
}
-(void) LoopSavePostHairMaskPic: (NSMutableArray *)files arg2:(NSString *)fileDir
{
    
    
    
    if (files.count == 0) {
        //[self showAlertBox:@"确定" inTxt:[NSString stringWithFormat:@"%@_%@",@"成功POST",fileDir]];
        return;
    } else {
        [self SavePostHairMaskPic:fileDir arg2:[files lastObject] arg3:^(){
            [files removeLastObject];
            [self LoopSavePostHairMaskPic:files arg2:fileDir];
        } ];
    }
    
}
-(void) PostPic11
{
    
    NSFileManager *fileManager=[[[NSFileManager alloc] init]autorelease];
    NSString *homeStr=NSHomeDirectory();
    NSString* documentDir =[NSString stringWithFormat:@"%@/Documents/SrcPic/GroupSrc11/",homeStr];
    NSError *error = nil;
    NSMutableArray *fileList  = [[[fileManager contentsOfDirectoryAtPath:documentDir error:&error] mutableCopy]autorelease] ;
    [self LoopSavePostHairMaskPic:fileList arg2:documentDir ];
}
-(void) PostPic22
{
    
    NSFileManager *fileManager=[[[NSFileManager alloc] init]autorelease];
    NSString *homeStr=NSHomeDirectory();
    NSString* documentDir =[NSString stringWithFormat:@"%@/Documents/SrcPic/GroupSrc22/",homeStr];
    NSError *error = nil;
    NSMutableArray *fileList  = [[[fileManager contentsOfDirectoryAtPath:documentDir error:&error] mutableCopy]autorelease] ;
   [self LoopSavePostHairMaskPic:fileList arg2:documentDir ];
}
-(void) PostPic33
{
    
    NSFileManager *fileManager=[[[NSFileManager alloc] init]autorelease];
    NSString *homeStr=NSHomeDirectory();
    NSString* documentDir =[NSString stringWithFormat:@"%@/Documents/SrcPic/GroupSrc33/",homeStr];
    NSError *error = nil;
    NSMutableArray *fileList  = [[[fileManager contentsOfDirectoryAtPath:documentDir error:&error] mutableCopy]autorelease] ;
   [self LoopSavePostHairMaskPic:fileList arg2:documentDir ];
}
-(void) PostPic44
{
    
    NSFileManager *fileManager=[[[NSFileManager alloc] init]autorelease];
    NSString *homeStr=NSHomeDirectory();
    NSString* documentDir =[NSString stringWithFormat:@"%@/Documents/SrcPic/GroupSrc44/",homeStr];
    NSError *error = nil;
    NSMutableArray *fileList  = [[[fileManager contentsOfDirectoryAtPath:documentDir error:&error] mutableCopy]autorelease] ;
  [self LoopSavePostHairMaskPic:fileList arg2:documentDir] ;
}
-(void) PostPic55
{
    
    NSFileManager *fileManager=[[[NSFileManager alloc] init]autorelease];
    NSString *homeStr=NSHomeDirectory();
    NSString* documentDir =[NSString stringWithFormat:@"%@/Documents/SrcPic/GroupSrc55/",homeStr];
    NSError *error = nil;
    NSMutableArray *fileList  = [[[fileManager contentsOfDirectoryAtPath:documentDir error:&error] mutableCopy]autorelease] ;
    [self LoopSavePostHairMaskPic:fileList arg2:documentDir ];
}
-(void) PostPic66
{
    
    NSFileManager *fileManager=[[[NSFileManager alloc] init]autorelease];
    NSString *homeStr=NSHomeDirectory();
    NSString* documentDir =[NSString stringWithFormat:@"%@/Documents/SrcPic/GroupSrc66/",homeStr];
    NSError *error = nil;
    NSMutableArray *fileList  = [[[fileManager contentsOfDirectoryAtPath:documentDir error:&error] mutableCopy]autorelease] ;
   [self LoopSavePostHairMaskPic:fileList arg2:documentDir ];
}
-(void) PostPic77
{
    
    NSFileManager *fileManager=[[[NSFileManager alloc] init]autorelease];
    NSString *homeStr=NSHomeDirectory();
    NSString* documentDir =[NSString stringWithFormat:@"%@/Documents/SrcPic/GroupSrc77/",homeStr];
    NSError *error = nil;
    NSMutableArray *fileList  = [[[fileManager contentsOfDirectoryAtPath:documentDir error:&error] mutableCopy]autorelease] ;
   [self LoopSavePostHairMaskPic:fileList arg2:documentDir ];
}
-(void) PostPic88
{
    
    NSFileManager *fileManager=[[[NSFileManager alloc] init]autorelease];
    NSString *homeStr=NSHomeDirectory();
    NSString* documentDir =[NSString stringWithFormat:@"%@/Documents/SrcPic/GroupSrc88/",homeStr];
    NSError *error = nil;
    NSMutableArray *fileList  = [[[fileManager contentsOfDirectoryAtPath:documentDir error:&error] mutableCopy]autorelease] ;
    [self LoopSavePostHairMaskPic:fileList arg2:documentDir ];
}
-(void) PostPic99
{
    NSFileManager *fileManager=[[[NSFileManager alloc] init]autorelease];
    NSString *homeStr=NSHomeDirectory();
    NSString* documentDir =[NSString stringWithFormat:@"%@/Documents/SrcPic/GroupSrc99/",homeStr];
    NSError *error = nil;
    NSMutableArray *fileList  = [[[fileManager contentsOfDirectoryAtPath:documentDir error:&error] mutableCopy]autorelease] ;
    [self LoopSavePostHairMaskPic:fileList arg2:documentDir ];
}

-(IBAction)SendPost:(id)sender{
    BOOL isDir = FALSE;
    NSFileManager *fileManager=[[[NSFileManager alloc] init]autorelease];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *myDirectory1= [documentsDirectory stringByAppendingPathComponent:@"DesPic"];
    NSString *myDirectory2= [documentsDirectory stringByAppendingPathComponent:@"SrcPic/GroupSrc11"];
    NSString *myDirectory3= [documentsDirectory stringByAppendingPathComponent:@"SrcPic/GroupSrc22"];
    NSString *myDirectory4= [documentsDirectory stringByAppendingPathComponent:@"SrcPic/GroupSrc33"];
    NSString *myDirectory5= [documentsDirectory stringByAppendingPathComponent:@"SrcPic/GroupSrc44"];
    NSString *myDirectory6= [documentsDirectory stringByAppendingPathComponent:@"SrcPic/GroupSrc55"];
    NSString *myDirectory7= [documentsDirectory stringByAppendingPathComponent:@"SrcPic/GroupSrc66"];
    NSString *myDirectory8= [documentsDirectory stringByAppendingPathComponent:@"SrcPic/GroupSrc77"];
    NSString *myDirectory9= [documentsDirectory stringByAppendingPathComponent:@"SrcPic/GroupSrc88"];
    NSString *myDirectory10= [documentsDirectory stringByAppendingPathComponent:@"SrcPic/GroupSrc99"];
    BOOL isDirExist1 =[fileManage fileExistsAtPath:myDirectory1 isDirectory:&isDir];
    BOOL isDirExist2 =[fileManage fileExistsAtPath:myDirectory2 isDirectory:&isDir];
    BOOL isDirExist3 =[fileManage fileExistsAtPath:myDirectory3 isDirectory:&isDir];
    BOOL isDirExist4 =[fileManage fileExistsAtPath:myDirectory4 isDirectory:&isDir];
    BOOL isDirExist5 =[fileManage fileExistsAtPath:myDirectory5 isDirectory:&isDir];
    BOOL isDirExist6 =[fileManage fileExistsAtPath:myDirectory6 isDirectory:&isDir];
    BOOL isDirExist7 =[fileManage fileExistsAtPath:myDirectory7 isDirectory:&isDir];
    BOOL isDirExist8 =[fileManage fileExistsAtPath:myDirectory8 isDirectory:&isDir];
    BOOL isDirExist9 =[fileManage fileExistsAtPath:myDirectory9 isDirectory:&isDir];
    BOOL isDirExist10 =[fileManage fileExistsAtPath:myDirectory10 isDirectory:&isDir];

    
    
    if(!(isDirExist1&& isDir && isDirExist2&&isDirExist3&&isDirExist4&&isDirExist5&&isDirExist6&&isDirExist8&&isDirExist9&&isDirExist10))
        
    {
        [self showAlertBox:@"确定" inTxt:@"请先创建相应的目录并且放入待处理图片"];
        return;
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self PostPic11];
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self PostPic22];
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self PostPic33];
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self PostPic44];
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self PostPic55];
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self PostPic66];
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self PostPic77];
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self PostPic88];
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self PostPic99];
        });
        
        [self showAlertBox:@"确定" inTxt:@"已经开始处理....请查看Documents目录下的DesPic目录下是否在产生Mask"];

    }
    
    
}
@end
