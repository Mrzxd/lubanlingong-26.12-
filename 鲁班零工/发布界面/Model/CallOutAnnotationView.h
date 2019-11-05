//
//  CallOutAnnotationView.h
//  MapTest
//
//  Created by administrator on 16/5/12.
//  Copyright © 2016年 zte. All rights reserved.
//

#import <MapKit/MapKit.h>
//#import "BusPointCell.h"

@interface CallOutAnnotationView : MKAnnotationView


@property(nonatomic,retain) UIView *contentView;

//添加一个UIView
//@property(nonatomic,retain) BusPointCell *busInfoView;//在创建calloutView Annotation时，把contentView add的 subview赋值给businfoView


@end
