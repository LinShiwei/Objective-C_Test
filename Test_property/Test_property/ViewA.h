//
//  ViewA.h
//  Test_property
//
//  Created by Lin,Shiwei on 2017/8/12.
//  Copyright © 2017年 Lin,Shiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewA : UIView{
    NSString *_bar;
    NSString *_gaa;//@synthesize aag = _gaa;
    NSString *buzz;
    
}
@property (nonatomic,copy) NSString* str;
@property (nonatomic,copy) NSString* _foo;
//@property (nonatomic,copy) N
@property (nonatomic,copy) NSString* aag;

@end
