//
//  LogisticsStateMessageHandle.m
//  Wuyoda
//
//  Created by 赵祥 on 2022/7/13.
//

#import "LogisticsStateMessageHandle.h"

@implementation LogisticsStateMessageHandle

+ (NSString *)getStateMessage:(NSString *)code{
    if ([code isEqualToString:@"1"]) {
        return @"快件揽收";
    }else if ([code isEqualToString:@"101"]){
        return @"已经下快件单";
    }else if ([code isEqualToString:@"102"]){
        return @"待快递公司揽收";
    }else if ([code isEqualToString:@"103"]){
        return @"快递公司已经揽收";
    }else if ([code isEqualToString:@"0"]){
        return @"快件在途中";
    }else if ([code isEqualToString:@"1001"]){
        return @"快件到达收件人城市";
    }else if ([code isEqualToString:@"1002"]){
        return @"快件处于运输过程中";
    }else if ([code isEqualToString:@"1003"]){
        return @"快件发往到新的收件地址";
    }else if ([code isEqualToString:@"5"]){
        return @"快件正在派件";
    }else if ([code isEqualToString:@"501"]){
        return @"快件已经投递到快递柜或者快递驿站";
    }else if ([code isEqualToString:@"3"]){
        return @"快件已签收";
    }else if ([code isEqualToString:@"301"]){
        return @"收件人正常签收";
    }else if ([code isEqualToString:@"302"]){
        return @"快件显示派件异常，但后续正常签收";
    }else if ([code isEqualToString:@"303"]){
        return @"快件已被代签";
    }else if ([code isEqualToString:@"304"]){
        return @"快件已由快递柜或者驿站签收";
    }else if ([code isEqualToString:@"6"]){
        return @"快件正处于返回发货人的途中";
    }else if ([code isEqualToString:@"4"]){
        return @"此快件单已退签";
    }else if ([code isEqualToString:@"401"]){
        return @"此快件单已撤销";
    }else if ([code isEqualToString:@"14"]){
        return @"收件人拒签快件";
    }else if ([code isEqualToString:@"7"]){
        return @"快件转给其他快递公司邮寄";
    }else if ([code isEqualToString:@"2"]){
        return @"快件存在疑难";
    }else if ([code isEqualToString:@"201"]){
        return @"快件长时间派件后未签收";
    }else if ([code isEqualToString:@"202"]){
        return @"快件长时间没有派件或签收";
    }else if ([code isEqualToString:@"203"]){
        return @"收件人发起拒收快递,待发货方确认";
    }else if ([code isEqualToString:@"204"]){
        return @"快件派件时遇到异常情况";
    }else if ([code isEqualToString:@"205"]){
        return @"快件在快递柜或者驿站长时间未取";
    }else if ([code isEqualToString:@"206"]){
        return @"无法联系到收件人";
    }else if ([code isEqualToString:@"207"]){
        return @"超出快递公司的服务区范围";
    }else if ([code isEqualToString:@"208"]){
        return @"快件滞留在网点，没有派送";
    }else if ([code isEqualToString:@"209"]){
        return @"快件破损";
    }else if ([code isEqualToString:@"8"]){
        return @"快件清关";
    }else if ([code isEqualToString:@"10"]){
        return @"快件等待清关";
    }else if ([code isEqualToString:@"11"]){
        return @"快件正在清关流程中";
    }else if ([code isEqualToString:@"12"]){
        return @"快件已完成清关流程";
    }else if ([code isEqualToString:@"13"]){
        return @"货物在清关过程中出现异常";
    }else if ([code isEqualToString:@"14"]){
        return @"收件人拒签快件";
    }else{
        return code;
    }
}

@end
