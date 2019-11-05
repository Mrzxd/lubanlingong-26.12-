//
//  CalloutMapAnnotation.h
//  MapTest
//
//  Created by administrator on 16/5/12.
//  Copyright © 2016年 zte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CalloutMapAnnotation : NSObject<MKAnnotation>


@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;


@property(retain,nonatomic) NSDictionary *locationInfo;//callout吹出框要显示的各信息



- (id)initWithLatitude:(CLLocationDegrees)lat andLongitude:(CLLocationDegrees)lon;



@end