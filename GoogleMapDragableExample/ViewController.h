//
//  ViewController.h
//  GoogleMapDragableExample
//
//  Created by PASHA on 14/10/18.
//  Copyright © 2018 Pasha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate>
{
//  GMSMapView *mapViewGoogle;
  CLLocationManager *locationManager;
  GMSCameraPosition *camera;
  NSNumber *latitude;
  NSNumber *lng;
//  GMSMarker *markerMap;
  CLPlacemark *placeMark;
  
  NSString *locatedAt;
  NSString * SaveAddStr;
  
}

@property  NSNumber * latitudeNum;
@property   NSNumber * longitudeNum;
@property (weak, nonatomic) IBOutlet UIView *myCustomMapV;
@property GMSMapView * gmsMap;
@property GMSMarker * marker;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLbl;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLbl;
@property (weak, nonatomic) IBOutlet UILabel *locationLbl;

@end

