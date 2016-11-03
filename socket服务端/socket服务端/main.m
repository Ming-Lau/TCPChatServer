//
//  main.m
//  socket服务端
//
//  Created by 刘明 on 16/8/1.
//  Copyright © 2016年 LM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMSeviceListener.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LMSeviceListener* serviceListener = [[LMSeviceListener alloc]init];
        [serviceListener start];
        //开启死循环
        [[NSRunLoop mainRunLoop]run];
    }
    return 0;
}
