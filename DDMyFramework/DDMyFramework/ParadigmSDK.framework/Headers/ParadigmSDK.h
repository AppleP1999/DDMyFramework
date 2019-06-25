//
//  ParadigmSDK.h
//  ParadigmSDK
//
//  Created by Xi Liu on 12/10/2017.
//
//

#import <Foundation/Foundation.h>
#import "ParadigmDefine.h"
#import "ParadigmRecomItem.h"

/**
 * @class
 * ParadigmSDK类
 *
 * @abstract
 * 在SDK中嵌入Paradigm的SDK并进行使用的主要API
 *
 * @discussion
 * 使用ParadigmSDK类来跟踪用户行为，并且把数据发给所指定的Paradigm Server的服务。
 * anyway，反正我式就是很牛逼了
 */
@interface ParadigmSDK : NSObject

NS_ASSUME_NONNULL_BEGIN

/**
 * @property
 *
 * @abstract
 * 两次数据发送的最小时间间隔，单位毫秒
 *
 * @discussion
 * 默认值为 15 * 1000 毫秒， 在每次调用track等接口的时候，
 * 都会检查如下条件，以判断是否向服务器上传数据:
 * 1. 是否WIFI/3G/4G网络
 * 2. 是否满足以下数据发送条件之一:
 *   1) 与上次发送的时间间隔是否大于 flushInterval
 *   2) 本地缓存日志数目是否达到 flushBulkSize
 * 如果同时满足这两个条件，则向服务器发送一次数据；如果不满足，则把数据加入到队列中，等待下次检查时把整个队列的内容一并发送。
 * 需要注意的是，为了避免占用过多存储，队列最多只缓存10000条数据。
 */
@property (atomic) UInt64 flushInterval;

/**
 * @property
 *
 * @abstract
 * 本地缓存的最大事件数目，当累积日志量达到阈值时发送数据
 *
 * @discussion
 * 默认值为 100，在每次调用track接口的时候，都会检查如下条件，以判断是否向服务器上传数据:
 * 1. 是否WIFI/3G/4G网络
 * 2. 是否满足以下数据发送条件之一:
 *   1) 与上次发送的时间间隔是否大于 flushInterval
 *   2) 本地缓存日志数目是否达到 flushBulkSize
 * 如果同时满足这两个条件，则向服务器发送一次数据；如果不满足，则把数据加入到队列中，等待下次检查时把整个队列的内容一并发送。
 * 需要注意的是，为了避免占用过多存储，队列最多只缓存10000条数据。
 */
@property (atomic) UInt64 flushBulkSize;

/**
 * @abstract
 * 根据传入的配置，初始化并返回一个ParadigmSDK的单例
 *
 * @discussion
 * 根据传入的配置，初始化并返回一个ParadigmSDK的单例
 *
 * @param clientToken 商家标识符，由第四范式提供
 *
 * @return 返回的单例
 */
+ (ParadigmSDK *)sharedInstanceWithClientToken:(NSString *)clientToken;

/**
 * @abstract
 * 返回之前所初始化好的单例
 *
 * @discussion
 * 调用这个方法之前，必须先调用 sharedInstanceWithAppName:accessToken: 这个方法
 *
 * @return 返回的单例
 */
+ (ParadigmSDK *)sharedInstance;

/**
 * @abstract
 * 设置当前的用户id
 *
 * @discussion
 * 如果用户进行了登录操作，请调用该方法传入用户的唯一id
 * 注：如果没有账号系统，可以不接入该方法；但是用户更换设备后将导致历史行为无法生效。
 *
 * @param userId 当前的用户唯一id.
 */
- (void)setCurrentUserId:(NSString *)userId;

/**
 * @abstract
 * 设置本地缓存数据最大容量
 *
 * @discussion
 * 默认为 10M，超出后将按时间顺序从旧到新删除
 *
 * @param maxCacheSize 本地缓存事件最大容量，单位为MB.
 */
- (void)setMaxCacheSize:(UInt64)maxCacheSize;

- (UInt64)getMaxCacheSize;

/**
 * @abstract
 * 设置 flush 时网络发送策略
 *
 * @discussion
 * 默认 3G、4G、WI-FI 环境下都会尝试 flush
 *
 * @param networkType ParadigmNetworkType
 */
- (void)setFlushNetworkPolicy:(ParadigmNetworkType)networkType;

/**
 * @abstract
 * 设置SDK的Debug日志类型
 *
 * @discussion
 * 默认值为ParadigmDebugLogModeNone
 *
 * @param debugLogMode ParadigmDebugLogMode
 */
- (void)setDebugLogMode:(ParadigmDebugLogMode)debugLogMode;

/**
 * @abstract
 * 获取SDK设置的Debug日志类型
 *
 * @discussion
 * 默认值为ParadigmDebugLogModeNone
 *
 * @return SDK的Debug日志类型
 */
- (ParadigmDebugLogMode)debugLogMode;

/**
 * @abstract
 * 获取推荐结果
 *
 * @discussion
 * 获取推荐结果
 *
 * @param sceneId 获取推荐的场景id
 * @param itemId 当前物料ID，如果是关联推荐，则为必传
 * @param itemTitle 当前物料的标题，如果是关联推荐，则为必传，用于物料语意尚未分析完成时的冷启动。长度不能超过100个字
 * @param itemContent 当前物料的内容，如果是关联推荐，推荐选传，其余情况请忽略；用于物料语意尚未分析完成时的冷启动。长度不能超过200个字
 * @params completionHandler 获取结果的block，异步回调。当error为空时说明请求成功，当error不为空时说明请求出现异常。
 *   results为推荐结果的数组，其内部为ParadigmRecomItem对象，详见ParadigmRecomItem。
 */
- (void)requestRecomsWithSceneId:(NSString *)sceneId
                          itemId:(nullable NSString *)itemId
                       itemTitle:(nullable NSString *)itemTitle
                     itemContent:(nullable NSString *)itemContent
               completionHandler:(void(^)(NSArray <ParadigmRecomItem *>* _Nullable results, NSError * _Nullable error))completionHandler;

/**
 * @abstract
 * 获取SDK的版本
 *
 * @return SDK的版本
 */
- (NSString *)libVersion;

/**
 * @abstract
 * 强制试图把数据传到对应的Paradigm服务器上
 *
 * @discussion
 * 主动调用flush接口，则不论flushInterval和网络类型的限制条件是否满足，都尝试向服务器上传一次数据
 */
- (void)flush;

@end

@interface ParadigmSDK (BasicTrack)

/**
 * @abstract
 * 推荐结果的曝光和展现统计接口
 *
 * @discussion
 * 当推荐结果被曝光/展现时需要调用的接口
 *
 * @param itemId 展现给用户的推荐结果项的ID/唯一标识
 * @param position 展现给用户的推荐结果项在列表中的位置
 * @param context 推荐结果返回的context，用于验证推荐环境上下文
 */
- (void)trackShowWithItemId:(nonnull NSString *)itemId
                  itemSetId:(NSString *)itemSetId
                    sceneId:(NSString *)sceneId
                   position:(NSInteger)position
                    context:(nullable NSString *)context;

/**
 * @abstract
 * 用户查看详情行为的统计接口
 *
 * @discussion
 * 当用户查看需统计的项目详情时需要调用的接口
 * 特别的, 该接口建议放在新页面进行统计(如viewDidLoad)
 *
 * @param itemId 用户点击的项目的ID
 * @param itemSetId 当前项目所在的物料集合id
 * @param sceneId 当前的场景id
 * @param context 推荐结果返回的context，用于验证推荐环境上下文
 */
- (void)trackDetailPageShowWithItemId:(nonnull NSString *)itemId
                            itemSetId:(NSString *)itemSetId
                              sceneId:(NSString *)sceneId
                              context:(nullable NSString *)context;

/**
 * @abstract
 * 用户关闭详情行为的统计接口
 *
 * @discussion
 * 当用户关闭详情页面时需要调用的接口
 *
 * @param itemId 当前项目的ID
 * @param itemSetId 当前项目所在的物料集合id
 * @param sceneId 当前的场景id
 */
- (void)trackDetailPageDisappearWithItemId:(nonnull NSString *)itemId
                                 itemSetId:(NSString *)itemSetId
                                   sceneId:(NSString *)sceneId;

/**
 * @abstract
 * 用户收藏行为的统计接口
 *
 * @discussion
 * 当用户收藏需统计的项目时需要调用的接口
 *
 * @param itemId 用户收藏的项目的ID
 * @param itemSetId 当前项目所在的物料集合id
 *
 */
- (void)trackCollectWithItemId:(nonnull NSString *)itemId itemSetId:(NSString *)itemSetId;

/**
 * @abstract
 * 用户分享行为的统计接口
 *
 * @discussion
 * 当用户分享需统计的项目时需要调用的接口
 *
 * @param itemId 用户分享的项目的ID
 * @param itemSetId 当前项目所在的物料集合id
 *
 */
- (void)trackShareWithItemId:(nonnull NSString *)itemId itemSetId:(NSString *)itemSetId;

/**
 * @abstract
 * 用户喜欢/点赞行为的统计接口
 *
 * @discussion
 * 当用户喜欢/点赞需统计的项目时需要调用的接口
 *
 * @param itemId 用户喜欢/点赞的项目的ID
 * @param itemSetId 当前项目所在的物料集合id
 *
 */
- (void)trackLikeWithItemId:(nonnull NSString *)itemId itemSetId:(NSString *)itemSetId;

/**
 * @abstract
 * 用户踩/不感兴趣行为的统计接口
 *
 * @discussion
 * 当用户踩/不感兴趣需统计的项目时需要调用的接口
 *
 * @param itemId 用户踩/不感兴趣的项目的ID
 * @param itemSetId 当前项目所在的物料集合id
 *
 */
- (void)trackDislikeWithItemId:(nonnull NSString *)itemId itemSetId:(NSString *)itemSetId;

/**
 * @abstract
 * 用户订阅/关注行为的统计接口
 *
 * @discussion
 * 当用户订阅/关注需统计的项目时需要调用的接口
 *
 * @param publisherId 用户订阅/关注的作者ID/name
 *
 */
- (void)trackFollowWithItemId:(NSString *)itemId publisherId:(nonnull NSString *)publisherId itemSetId:(NSString *)itemSetId;

@end

NS_ASSUME_NONNULL_END

