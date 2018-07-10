import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:googleapis/drive/v3.dart' as drive;
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_sign_in/google_sign_in.dart'
    show GoogleSignIn, GoogleSignInAccount;
import 'package:watering_map/io/github/edt/restricted/restricted_resources.dart';

// Obtain the client email / secret from the Google Developers Console by
// creating new OAuth credentials of application type
// "Installed application / Other".
//final identifier = new auth.ClientId(GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET);
final scopes = [drive.DriveApi.DriveScope];

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: scopes,
);

GoogleSignInAccount _currAccount;

Future<Null> authenticateSession() async {
//  auth.clientViaUserConsent(identifier, scopes, userPrompt).then((client) {
//  drive.DriveApi api = new drive.DriveApi(client);
//    api.files.list().then((list) {
//      for (drive.File f in list.items) {
//        print(f.originalFilename);
//      }
//    });
//  });

  try {
    _googleSignIn.signIn().then((account) {
      _currAccount = account;
      print(account);
    });
//    final authHeaders = await _currAccount.authHeaders;
//    final httpClient = new http.Client();
//
//    final api = drive.DriveApi(httpClient);
//
//    await api.files.list().then((list){
//      for(drive.File f in list.files) print(f.originalFilename);
//    });
  } catch (error) {
    print(error);
  }
}

Future<Null> deauthenticateSession() async {
  _googleSignIn.signOut();
}

//void userPrompt(String url) {
//  launch(url);
//  Navigator.push(
//      _context, MaterialPageRoute(builder: (context) => Login(url: url)));
//}
//
//class Login extends StatelessWidget {
//  final url;
//
//  Login({this.url});
//
//  @override
//  Widget build(BuildContext context) {
//    WebviewScaffold scaffold = new WebviewScaffold(
//      url: this.url,
//      appBar: new AppBar(
//        title: new Text("Login to google drive"),
//      ),
//    );
//    return scaffold;
//  }
//}
