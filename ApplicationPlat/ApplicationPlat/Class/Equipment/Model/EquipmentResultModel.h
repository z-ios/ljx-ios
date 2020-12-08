//
//  EquipmentResultModel.h
//  ApplicationPlat
//
//  Created by ljxMac on 2020/9/18.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EquipmentResultModel : NSObject
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *descriptions;
@property(nonatomic, copy)NSString *web_icon_url;
@property(nonatomic, copy)NSString *phone_icon_url;
@property(nonatomic, copy)NSString *iId;
/** 拼音全拼（小写）如：@"wangpengfei" */
@property (nonatomic, copy) NSString *completeSpelling;
/** 拼音首字母（小写）如：@"wpf" */
@property (nonatomic, copy) NSString *initialString;
/**
 拼音全拼（小写）位置，如：@"0,0,0,0,1,1,1,1,2,2,2"
                        w a n g p e n g f e i
 */
@property (nonatomic, copy) NSString *pinyinLocationString;
/** 拼音首字母拼音（小写）数组字符串位置，如@"0,1,2" */
@property (nonatomic, copy) NSString *initialLocationString;
/** 高亮位置 */
@property (nonatomic, assign) NSInteger highlightLoaction;
/** 关键字范围 */
@property (nonatomic, assign) NSRange textRange;
/** 匹配类型 */
@property (nonatomic, assign) NSInteger matchType;

// 以下四个属性为多音字的适配，暂时只支持双多音字
/** 是否包含多音字 */
@property (nonatomic, assign) BOOL isContainPolyPhone;
/** 第二个多音字 拼音全拼（小写） */
@property (nonatomic, copy) NSString *polyPhoneCompleteSpelling;
/** 第二个多音字 拼音首字母（小写）*/
@property (nonatomic, copy) NSString *polyPhoneInitialString;
/** 第二个多音字 拼音全拼（小写）位置 */
@property (nonatomic, copy) NSString *polyPhonePinyinLocationString;
/** 第二个多音字 拼音首字母拼音（小写）数组字符串位置 */
// 可以忽略掉，因为即使是多音字，简拼的定位是一定一样的
//@property (nonatomic, copy) NSString *polyPhoneInitialLocationString;
@end

NS_ASSUME_NONNULL_END
