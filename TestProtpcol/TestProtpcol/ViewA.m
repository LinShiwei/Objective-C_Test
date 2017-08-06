//
//  ViewA.m
//  TestProtpcol
//
//  Created by Linsw on 2017/8/5.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "ViewA.h"

@interface ViewA(){
//    __strong NSString *_manualPro;
}
@property (strong,nonatomic) NSString *_manualPro;
@end



@implementation ViewA


@synthesize property = _property;

//**实例变量+基本数据类型变量=成员变量**,当成员变量是一个类的实例时，他就是实力变量
//成员变量就是@interface里 { }里面的变量，属性变量使用属性@property定义的变量；

//如果把属性以下划线开头，如：_manualPro,则默认关联的ivar就会是__manualPro，getter和setter则变成_manualPro,set_manualPro;
//当协议中已经用@property声明了属性，需要再类中用@synthesize 关联属性和成员变量,并且自动生成getter和setter
//@synthesize 等号右边的是只在类中使用的变量，对外的是等号左边的属性。
//@property 会自动生成成员变量并关联属性和成员变量

- (id)quickInit{
    
    return [self init];
    
}

- (id)init{
    self = [super init];
    if (self){
        self.property = @"aaa";
    }
    return self;
}

- (void)printProperty{
    NSLog(@"%@",_property);
    NSString *bb = self->_property;
    
    self->_property = @"aaa";
    //self->_property和_property一样不会调用setter,getter方法
}

- (void)protocolMethod{
    
}

- (void)setProperty:(NSString *)property{
    _property = property;
}

- (NSString *)property{
    return _property;
}



@end
