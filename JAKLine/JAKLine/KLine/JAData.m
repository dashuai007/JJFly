//
//  JAData.m
//  JAKLine
//
//  Created by xiazhongchong on 30/11/2017.
//  Copyright © 2017 JJFly. All rights reserved.
//

#import "JAData.h"

@implementation JAData

- (void)dataAdd:(id<JADataDelegate>)delegate {
    self.delegate = delegate;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"txt"];
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (dict) {
            NSMutableArray *datas = [NSMutableArray new];
            NSArray *dataArray = dict[@"ResultData"];
            [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [datas addObject:[self returnHQDataArrayFromDataString:obj]];
            }];
            if ([self.delegate respondsToSelector:@selector(dataKLine:)]) {
                [self.delegate dataKLine:datas];
            }
        }
        
    }
}

- (NSMutableArray *)returnHQDataArrayFromDataString:(NSDictionary *)dict{
    if([[dict class] isSubclassOfClass:[NSDictionary class]]){
        if (dict == nil) {
            return nil;
        }
        NSMutableArray *dataArray = [NSMutableArray new];//加载的数据
        NSMutableString *dataString = [[NSMutableString alloc] initWithString:dict[@"d"]];
        while (1) {
            if ([dataString rangeOfString:@","].location != NSNotFound) {
                NSRange range = [dataString rangeOfString:@","];
                [dataArray addObject:[dataString substringWithRange:NSMakeRange(0, range.location)]];
                [dataString setString:[dataString substringFromIndex:range.location+1]];
                
            }else{
                if (dataString.length > 0) {
                    [dataArray addObject:dataString];
                }
                break;
            }
            
        }
        return dataArray;
    }
    
    return nil;
}

@end
