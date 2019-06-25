
#import <Foundation/Foundation.h>

@interface FCDateItem : NSObject
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;
@end

@interface NSDate (FCExtension)
- (FCDateItem *)fc_timeIntervalSinceDate:(NSDate *)anotherDate;

- (BOOL)fc_isToday;
- (BOOL)fc_isYesterday;
- (BOOL)fc_isTomorrow;
- (BOOL)fc_isThisYear;
//获取今天周几
- (NSInteger)getNowWeekday;
@end
