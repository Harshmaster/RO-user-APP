// import 'package:permission_handler/permission_handler.dart';
// import 'package:location_permissions/location_permissions.dart';
// class PermissionsService {

//   final PermissionHandler _permissionHandler = PermissionHandler();


  
//     Future<bool> requestLocationPermission() async {
//     return _requestPermission(PermissionGroup.locationWhenInUse);
//       }

//   Future<bool> requestContactsPermission({Function onPermissionDenied}) async {



//     var granted = await _requestPermission(PermissionGroup.contacts);
//     if (!granted) {
//       onPermissionDenied();
//     }
//     return granted;
//   }



// }