import "dart:io";

class IpVerify {
  Future<InternetAddress> getNetWorkIP() async {
    return InternetAddress.anyIPv4;
  }
}
