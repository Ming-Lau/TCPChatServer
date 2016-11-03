//
//  LMSeviceListener.m
//  socket服务端
//
//  Created by 刘明 on 16/8/1.
//  Copyright © 2016年 LM. All rights reserved.
//

#import "LMSeviceListener.h"
#import "GCDAsyncSocket.h"
@interface LMSeviceListener()<GCDAsyncSocketDelegate>
@property(nonatomic,strong)GCDAsyncSocket* serverSocket;
@property(nonatomic,strong)NSMutableArray* clientSockets;
@end
@implementation LMSeviceListener
-(NSMutableArray *)clientSockets
{
    if (_clientSockets == nil) {
        _clientSockets = [NSMutableArray array];
    }
    return _clientSockets;
}
-(void)start{
    //1.创建一个socket对象
    GCDAsyncSocket * serverSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    //2.绑定端口并开始监听
    NSError * error = nil;
    [serverSocket acceptOnPort:5200 error:&error];
    self.serverSocket = serverSocket;
    if (!error) {
        NSLog(@"服务开启成功");
    }else{
        NSLog(@"服务开启失败");
    }
}
#pragma mark 有客户端链接到服务器调用的代理方法
-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    [self.clientSockets addObject:newSocket];
    [newSocket readDataWithTimeout:-1 tag:0];
    NSLog(@"有%lu个客户端链接",(unsigned long)self.clientSockets.count);
}
#pragma mark 客户端上传数据调用的代理方法
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    for (GCDAsyncSocket* socket in self.clientSockets) {
//        if (sock != socket) {
//           [socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
//        }
//    }
    [sock writeData:data withTimeout:-1 tag:0];
    NSLog(@"%@",data);
    [sock readDataWithTimeout:-1 tag:0];
}
@end
