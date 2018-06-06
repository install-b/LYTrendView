//
//  LYTendMath.c
//  HBPay
//
//  Created by Shangen Zhang on 2018/2/27.
//

#include "LYTendMath.h"
#include <math.h>

// 刻度值取整
double ly_fixDoubleValueToInterValue(double max_value,
                                     int s_count,
                                     double mo_scale,
                                     int *unit_times,
                                     int *multiple) {
    
    double avg = (max_value / s_count);
    int tempB = avg > 1 ? (int)avg : 1;
    double rezult = avg;
    int multi = 0;
    do {
        rezult /= 10.0f;
        if (rezult <= multi ? 10.0f : 1.0f) {
            tempB = ((int)(rezult * 10) % 10 > (avg * mo_scale)) ? tempB + 1 : tempB;
            
            if (multiple) {
                *multiple  = multi;
            }
            if (unit_times) {
                *unit_times = tempB;
            }
            
            return  tempB * pow(10, multi);
        }
        tempB = rezult;
        multi += 1;
    } while (1);
    
    return tempB;
}

