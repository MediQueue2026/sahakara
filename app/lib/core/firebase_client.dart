import 'package:firebase_auth/firebase_auth.dart';

import '../dataconnect_generated/sahakara.dart';

FirebaseAuth get auth => FirebaseAuth.instance;
SahakaraConnector get db => SahakaraConnector.instance;
