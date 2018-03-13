//
//  LYTendMath.h
//  HBPay
//
//  Created by Shangen Zhang on 2018/2/27.
//

#ifndef LYTendMath_h
#define LYTendMath_h
#define LYTendMath_EXTERN extern

#include <stdio.h>


/**
 刻度值取整修复函数

 @param max_value 最大的数值
 @param s_count 要均分的等分数
 @param mo_scale 允许超出最刻度值得多少范围  如刻度为 10 超出范围为 3 设置0.2则刻度将会+1 变成11 如果设置为0.4 将不会改变
 @param unit_times 1 - 10 的
 @param multiple 刻度的 科学计数 底数为10 的 multiple 次方
 @return 刻度取整双精度值  （return == unit_times * pow(10,multiple)）
 */
LYTendMath_EXTERN double ly_fixDoubleValueToInterValue(double max_value,
                                     int s_count,
                                     double mo_scale,
                                     int *unit_times,
                                     int *multiple);


#endif /* LYTendMath_h */
