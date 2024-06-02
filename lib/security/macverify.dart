import 'dart:io';

class MacVerify {
  Future<String> getMacAddress(String ip) async {
// Use the ping command to check if the device is reachable
    final ProcessResult pingResult = await Process.run(
      'ping',
      ['-c', '1', '-w', '1', ip],
    );
    if (pingResult.exitCode == 0) {
      // Use the netcfg command to get the MAC address of the device
      final ProcessResult netcfgResult = await Process.run(
        'netcfg',
        ['wlan0'],
      );
      if (netcfgResult.exitCode == 0) {
        final String output = netcfgResult.stdout;
        final List<String> lines = output.split('\n');
        for (final line in lines) {
          final List<String> parts = line.split(' ');
          if (parts.length >= 3 && parts[2] == ip) {
            return parts[3]; // Return the MAC address as a string
          }
        }
      }
    }
    return '';
  }
}
