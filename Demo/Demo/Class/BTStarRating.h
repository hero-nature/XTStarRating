//
//  BTStarRating.h
//  star
//
//  Created by Tongtong Xu on 15/3/24.
//  Copyright (c) 2015年 xxx Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface BTStarRating : UIControl
/*!
 *  @author Tongtong Xu, 15-03-24 22:03:41
 *
 *  @brief  正常状态时的星星图片
 */
@property (nonatomic, strong) IBInspectable UIImage *starImage;
/*!
 *  @author Tongtong Xu, 15-03-24 22:03:00
 *
 *  @brief  高亮时的星星图片
 */
@property (nonatomic, strong) IBInspectable UIImage *starHighlightedImage;
/*!
 *  @author Tongtong Xu, 15-03-24 22:03:20
 *
 *  @brief  展示的星星数
 */
@property (nonatomic) IBInspectable NSInteger maxRating;
/*!
 *  @author Tongtong Xu, 15-03-24 22:03:31
 *
 *  @brief  水平间距
 */
@property (nonatomic) IBInspectable CGFloat horizontalMargin;
/*!
 *  @author Tongtong Xu, 15-03-24 22:03:49
 *
 *  @brief  当前的分数
 */
@property (nonatomic) IBInspectable float rating;
/*!
 *  @author Tongtong Xu, 15-03-24 22:03:03
 *
 *  @brief  是否可以编辑
 */
@property (nonatomic) IBInspectable BOOL editable;
/*!
 *  @author Tongtong Xu, 15-03-24 22:03:16
 *
 *  @brief  编辑后最终的分数
 */
@property (nonatomic, copy) void (^returnBlock)(float rating);
@end
