

#import <Foundation/Foundation.h>

//协议
@protocol NetWorkDataBackProtoco <NSObject>

@optional

-(void)DataCallBackForHomeVC:(NSArray *)array;

@end

//公开方法
@interface NetWork : NSObject

@property id<NetWorkDataBackProtoco>delegate;

-(void)getDataForHomeVC;

@end
