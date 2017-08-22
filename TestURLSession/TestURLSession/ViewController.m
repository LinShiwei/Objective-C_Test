//
//  ViewController.m
//  TestURLSession
//
//  Created by Lin,Shiwei on 2017/8/21.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic,strong) NSURLSession* session;
@property (nonatomic,assign) BOOL isStart;
@property (nonatomic,strong) NSURLSessionDownloadTask *task;
@property (nonatomic,strong) NSData *resumeData;
@end

@implementation ViewController
- (IBAction)btnTap:(id)sender {
        if (_task) {
            [sender setTitle:@"start" forState:UIControlStateNormal];
            [self pauseDownload];

            
        }else{
            [sender setTitle:@"pause" forState:UIControlStateNormal];
            if (_resumeData) {
                [self resumeDownload];
            }else{
                [self startDownload];
            }
        }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isStart = false;
    NSLog(@"%@",NSHomeDirectory());
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSURLSession *)session{
    if (_session) {
        return _session;
    }else{
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        return _session;
    }
}


- (void)startDownload{
    NSURL* url = [NSURL URLWithString:@"http://dlsw.baidu.com/sw-search-sp/soft/9d/25765/sogou_mac_32c_V3.2.0.1437101586.dmg"];

    _task = [self.session downloadTaskWithURL:url];
    [_task resume];
}

- (void)pauseDownload{
    __weak typeof(self) weakself = self;
    [_task cancelByProducingResumeData:^(NSData *data){
        weakself.resumeData = data;
        weakself.task = nil;
    }];
}

- (void)resumeDownload{
        _task = [self.session downloadTaskWithResumeData:_resumeData];
        [_task resume];
        _resumeData = nil;
    
    
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    self.progressView.progress = (double)totalBytesWritten/totalBytesExpectedToWrite;
    

}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    // 将临时文件剪切或者复制Caches文件夹
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // AtPath : 剪切前的文件路径
    // ToPath : 剪切后的文件路径
    [mgr moveItemAtPath:location.path toPath:file error:nil];
    
    // 提示下载完成
    [[[UIAlertView alloc] initWithTitle:@"下载完成" message:downloadTask.response.suggestedFilename delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil] show];
    
}
@end
