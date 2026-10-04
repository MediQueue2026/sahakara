import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../dataconnect_generated/sahakara.dart';

FirebaseAuth get auth => FirebaseAuth.instance;
SahakaraConnector get db => SahakaraConnector.instance;
FirebaseStorage get storage => FirebaseStorage.instance;
