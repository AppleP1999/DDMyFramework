//
//  ParadigmDefine.h
//  ParadigmSDK
//
//  Created by JiangShiju on 2017/11/22.
//  Copyright © 2017年 Xi Liu. All rights reserved.
//

#ifndef ParadigmDefine_h
#define ParadigmDefine_h

/**
 * @abstract
 * 网络类型
 *
 * @discussion
 *   ParadigmNetworkTypeNONE - NULL
 *   ParadigmNetworkType2G - 2G
 *   ParadigmNetworkType3G - 3G
 *   ParadigmNetworkType4G - 4G
 *   ParadigmNetworkTypeWIFI - WIFI
 *   ParadigmNetworkTypeALL - ALL
 */
typedef NS_OPTIONS(NSInteger, ParadigmNetworkType) {
    ParadigmNetworkTypeNONE      = 0,
    ParadigmNetworkType2G       = 1 << 0,
    ParadigmNetworkType3G       = 1 << 1,
    ParadigmNetworkType4G       = 1 << 2,
    ParadigmNetworkTypeWIFI     = 1 << 3,
    ParadigmNetworkTypeALL      = 0xFF,
};


/**
 * @abstract
 * Debug日志类型
 *
 * @discussion
 *   ParadigmDebugLogModeNone - 不输出SDK Debug日志
 *   ParadigmDebugLogModeNormal - 正常输出SDK Debug日志
 *
 */
typedef enum : NSUInteger {
    ParadigmDebugLogModeNone       = 0 ,
    ParadigmDebugLogModeNormal     = 1 ,     
} ParadigmDebugLogMode;

typedef enum : NSUInteger {
    ParadigmErrorCodeNono                = 0 ,
    /* Local Error */
    ParadigmErrorCodeConfigureError      = 20000 ,
    ParadigmErrorCodeParseError          = 20001 ,
} ParadigmErrorCode;

#endif /* ParadigmDefine_h */
