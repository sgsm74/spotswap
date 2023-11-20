import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

String generateRandomString(int length) {
  const charset =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(
    List.generate(
      length,
      (index) => charset.codeUnitAt(random.nextInt(charset.length)),
    ),
  );
}

String calculateSHA256(String input) {
  // Convert the input string to bytes
  List<int> bytes = utf8.encode(input);

  // Compute the SHA-256 hash
  Digest digest = sha256.convert(bytes);

  // Convert the hash to a hex string
  String hashedString = digest.toString();

  return hashedString;
}

String base64encode(Uint8List input) {
  String base64String = base64UrlEncode(input);

  // Remove padding characters '='
  base64String = base64String.replaceAll('=', '');

  // Replace characters '+' and '/' as per the base64url specification
  base64String = base64String.replaceAll('+', '-').replaceAll('/', '_');

  return base64String;
}
