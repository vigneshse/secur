import 'dart:math';

import 'package:flutter/cupertino.dart';

class SecureGenerator extends StatelessWidget {
  static const String upperCaseCharset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  static const String lowerCaseCharset = "abcdefghijklmnopqrstuvwxyz";
  static const String numCharset = "0123456789";
  static const String splCharset = "\$#^@&%_.~!*";
  static const int secureLength = 8;
  static const charSet = [upperCaseCharset, lowerCaseCharset, numCharset, splCharset];
  static Random random = Random();

  const SecureGenerator({Key? key}) : super(key: key);

  static String generateRandomSecure(bool includeSplChar) {
    StringBuffer secure = StringBuffer();
    int secureIdx = 0;
    while(secureIdx < secureLength){
      int randCharSet = random.nextInt(3);
      int charIdx = random.nextInt(charSet.elementAt(randCharSet).length);
      secure.write(String.fromCharCode(charSet.elementAt(randCharSet).codeUnitAt(charIdx)));
      secureIdx++;
    }
    if(includeSplChar) {
      saltSplCharSet(splCharset, secure);
    }
    return secure.toString();
  }

  static void saltSplCharSet(String splCharset, StringBuffer secure){
    int charIdx = random.nextInt(splCharset.length);
    secure.write(String.fromCharCode(splCharset.codeUnitAt(charIdx)));
  }

  static String saltSecret(String key){
    StringBuffer salt = StringBuffer();
    for(int i = 0 ; i < key.length; i++){
      salt.write(key.codeUnitAt(i));
    }
    return salt.toString();
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}