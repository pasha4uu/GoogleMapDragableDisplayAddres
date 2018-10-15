//
//  ViewController.m
//  GoogleMapDragableExample
//
//  Created by PASHA on 14/10/18.
//  Copyright © 2018 Pasha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Create a GMSCameraPosition that tells the map to display the
  // coordinate -33.86,151.20 at zoom level 6.
  
  locationManager = [[CLLocationManager alloc] init];
  
  locationManager.distanceFilter = kCLDistanceFilterNone;
  locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
  locationManager.delegate =self;
  [locationManager startUpdatingLocation];
  [locationManager requestAlwaysAuthorization];
  [locationManager requestWhenInUseAuthorization];
  
  
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude
                                                          longitude:locationManager.location.coordinate.longitude
                                                               zoom:6];
 self.gmsMap = [GMSMapView mapWithFrame :CGRectMake(0, 00, 300, 200)  camera:camera];
  self.gmsMap.myLocationEnabled = YES;
  self.gmsMap.delegate = self;
  [self.myCustomMapV addSubview:self.gmsMap];
  
  // Creates a marker in the center of the map.
  self.marker = [[GMSMarker alloc] init];
  self.marker.position = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
  self.marker.title = @"Sydney";
  self.marker.snippet = @"Australia";
  self.marker.map = self.gmsMap;
 // [self.myCustomMapV setSelectedMarker:self.marker];
  [self.marker setDraggable:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
  
  self.latitudeNum= [NSNumber numberWithFloat:locationManager.location.coordinate.latitude];
  self.longitudeNum= [NSNumber numberWithFloat:locationManager.location.coordinate.longitude];
  
  NSLog(@"lat : %@  , long  :%@ ",self.latitudeNum,self.longitudeNum);
  camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude
                                       longitude:locationManager.location.coordinate.longitude
                                            zoom:20.0];
  
  self.marker.position =CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
  [self.gmsMap animateToCameraPosition:camera];
  CLGeocoder *ceo = [[CLGeocoder alloc]init];
  CLLocation *loc = [[CLLocation alloc]initWithLatitude:self.marker.position.latitude longitude:self.marker.position.longitude]; //insert your coordinates
  
  //  CLLocation *loc = [[CLLocation alloc]initWithLatitude:17.444600 longitude:78.392250];
  
  self.latitudeLbl.text = [NSString stringWithFormat:@"latitude : %f",self.marker.position.latitude];
  self.longitudeLbl.text = [NSString stringWithFormat:@"latitude : %f",self.marker.position.longitude];
  [ceo reverseGeocodeLocation:loc
            completionHandler:^(NSArray *placemarks, NSError *error) {
              self->placeMark= [placemarks objectAtIndex:0];
              
              if (self->placeMark)
              {
                NSString *address = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@", self->placeMark.name,
                                     self->placeMark.locality,
                                     self->placeMark.subLocality,
                                     self->placeMark.administrativeArea,
                                     self->placeMark.postalCode,
                                     self->placeMark.country
                                     ];
                //  NSLog(@"Postal Address :%@", placemarka.ISOcountryCode);
                NSLog(@"my Address :%@", address);
                self.locationLbl.text = address;
              }
              
            }
   
   ];
  //...
}
- (void) mapView:(GMSMapView *)mapView didBeginDraggingMarker:(GMSMarker *)marker
{
  NSLog(@"1 New location of marker: Lat: %f, Long: %f", marker.position.latitude, marker.position.longitude);
  self.latitudeLbl.text = [NSString stringWithFormat:@"latitude : %f",self.marker.position.latitude];
  self.longitudeLbl.text = [NSString stringWithFormat:@"latitude : %f",self.marker.position.longitude];
}

- (void) mapView:(GMSMapView *)mapView didEndDraggingMarker:(GMSMarker *)marker
{
   self.latitudeLbl.text = [NSString stringWithFormat:@"latitude : %f",self.marker.position.latitude];
  self.longitudeLbl.text = [NSString stringWithFormat:@"latitude : %f",self.marker.position.longitude];
  CLGeocoder *ceo = [[CLGeocoder alloc]init];
  CLLocation *loc = [[CLLocation alloc]initWithLatitude:marker.position.latitude longitude:marker.position.longitude]; //insert your coordinates
  
  //  CLLocation *loc = [[CLLocation alloc]initWithLatitude:17.444600 longitude:78.392250];
  [ceo reverseGeocodeLocation:loc
            completionHandler:^(NSArray *placemarks, NSError *error) {
              self->placeMark= [placemarks objectAtIndex:0];
              
              if (self->placeMark)
              {
                NSString *address = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@", self->placeMark.name,
                  self->placeMark.locality,
                  self->placeMark.subLocality,
                  self->placeMark.administrativeArea,
                  self->placeMark.postalCode,
                  self->placeMark.country
                                     ];
                //  NSLog(@"Postal Address :%@", placemarka.ISOcountryCode);
                NSLog(@"my Address :%@", address);
                self.locationLbl.text = address;
              }
              
            }
   
   ];
  
}
- (void) mapView:(GMSMapView *)mapView didDragMarker:(GMSMarker *)marker
{
   self.latitudeLbl.text = [NSString stringWithFormat:@"latitude : %f",self.marker.position.latitude];
  self.longitudeLbl.text = [NSString stringWithFormat:@"latitude : %f",self.marker.position.longitude];
  
}

@end
