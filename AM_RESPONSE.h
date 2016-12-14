//
//  AM_RESPONSE.h
//  ep-response
//
//  Created by 乐野 on 2016/12/9.
//  Copyright © 2016年 乐野. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>

@interface AM_RESPONSE : NSObject
+ (void) ep_amsponse_ofB: (NSArray<NSNumber *> *) b andA: (NSArray<NSNumber *> *) a order: (int) order am_result: (NSMutableArray<NSNumber *> *) am_reuslt length: (int) len;

+ (void) test_ep_amsponse_ofB: (NSArray<NSNumber *> *) b andA: (NSArray<NSNumber *> *) a order: (int) order am_result: (NSMutableArray<NSNumber *> *) am_reuslt length: (int) len;

+ (void) test_fft;
+ (void) test_dft;
@end

