
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
#pragma mark - 时间格式转换 显示 年.月.日

+ (NSString *)timeFormatConversionWithPoint:(NSString *)dateTime;

#pragma mark - 日期比较

+ (int)compareDate:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

#pragma mark - 时间格式转换 显示 月-日 时-分

+ (NSString *)timeFormatConversionWithAllButYear:(NSString *)dateTime;

#pragma mark - 拆解时间字符串，返回 年月日 时分秒

/**
 *  拆解时间字符串，返回 年月日 时分秒
 *
 *  @param dataTimeString 要拆解的时间字符串
 *  @param block          <#block description#>
 */
+ (void)timeFormatConversionWithDateTimeString:(NSString *)dataTimeString withBlock:(void(^)(int year,int month,int days,int hour,int minute,int second))block;

#pragma mark - 时间格式转换  当天显示为时:分 超过当天的显示为 月-日

+ (NSString *)timeFormatConversion:(NSString *)dateTime;

#pragma mark - 时间格式转换  当天显示为时:分 超过当天的显示为 年-月-日

+ (NSString *)timeFormatConversionDate:(NSString *)dateTime;

#pragma mark - 时间格式转换 当天显示为时:分 超过今天则显示 几天前，几个月前，几年前

+ (NSString *)timeFormatConversionBefore:(NSString *)dateTime;

#pragma mark - 获取当前时间

/*!
 * 获取当前时间
 */
+ (NSString *)getCurrentTime;

#pragma mark - 转换时间方法

+ (NSString *)changeOriginTimeMethodWithOriginTime:(NSString *)originTimeStr;

/**
 *  计算两个日期的时间差
 *
 *  @param date        格式为@"yyyy-MM-dd HH:mm:ss"的字符串
 *  @param anotherDate 格式为@"yyyy-MM-dd HH:mm:ss"的字符串
 *
 *  @return 时间差（单位秒）
 */
+ (long)timeDistanceWithDate:(NSString *)date anotherDate:(NSString *)anotherDate;

/**
 *  根据时间差返回天/时/分/秒时间数组
 *
 *  @param timeDistance 时间差（单位秒）
 *
 *  @return 返回天，时，分，秒的数组，如@[@“05”,@“10”,@“30”,@“50”],代表05天10时30分50秒
 */
+ (NSArray *)timeArrayWithTimeDistance:(long)timeDistance;

/**
 *  根据时间差返回时/分/秒数组
 *
 *  @param timeDistance 时间差（单位秒）
 *
 *  @return 返回时，分，秒的数组，如@[@“10”,@“30”,@“50”],代表10时30分50秒
 */
+ (NSArray *)secTimeArrayWithTimeDistance:(long)timeDistance;

/**
 *  将字符串转为NSDate
 *
 *  @param dateString
 *  @param datetype  1-格式为@"yyyy-MM-dd HH:mm:ss"的字符串 0--格式为@"yyyy-MM-dd"的字符串
 *  @return NSDate对象
 */
+ (NSDate *)dateWithDateString:(NSString *)dateString datetype:(NSInteger)datetype;

#pragma mark - 时间格式转换 显示 年-月-日

+ (NSString *)timeFormatConversionWithYearMonthDay:(NSString *)dateTime;

/**
 *  倒计时
 *
 *  @param endTimeString     结束时间
 *  @param withTimeDistance  服务器与当前时间的间距值
 *  @param format            0，返回类型，默认是返回：有年返年，有天返天，有小时返小时，最后是返回分和秒。1，否则是返回，天、小时、分、秒，例如：6天6时6分6秒，2返回：小时、分、秒，例如：6时6分6秒
 *
 *  @return <#return value description#>
 */
+ (NSString *)countDownMethodWithEndTime:(NSString *)endTimeString withTimeDistance:(NSTimeInterval)timeDistance withBlackTimeFormat:(NSInteger)format;

/**
 获取距今n天以后的日期
 
 @param n 距离的天数
 @return <#return value description#>
 */
+ (NSDate *)getFutureTimeAfterNow:(NSInteger)n;
@end
