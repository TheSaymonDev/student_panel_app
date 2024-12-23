import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  static final InternetConnection _connectivity = InternetConnection();

  /// Check if the device has internet access
  static Future<bool> isConnected() async {
    try {
      // Checks for active internet connection
      bool result = await _connectivity.hasInternetAccess;
      return result;
    } catch (e) {
      print("Error checking internet connection: $e");
      return false;
    }
  }
}
