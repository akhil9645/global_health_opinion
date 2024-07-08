import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/views/change_password.dart';
import 'package:global_health_opinion_sample/views/forget_password.dart';
import 'package:global_health_opinion_sample/views/login_page.dart';
import 'package:global_health_opinion_sample/views/my_reviews.dart';
import 'package:global_health_opinion_sample/views/new_reviews.dart';
import 'package:global_health_opinion_sample/views/new_reviews/current_medications.dart';
import 'package:global_health_opinion_sample/views/new_reviews/medical_details.dart';
import 'package:global_health_opinion_sample/views/new_reviews/medical_records.dart';
import 'package:global_health_opinion_sample/views/new_reviews/patient_information.dart';
import 'package:global_health_opinion_sample/views/new_reviews/payments.dart';
import 'package:global_health_opinion_sample/views/new_reviews/upload_records.dart';
import 'package:global_health_opinion_sample/views/profile.dart';
import 'package:global_health_opinion_sample/views/register_page.dart';
import 'package:global_health_opinion_sample/views/splash_diologue.dart';
import 'package:global_health_opinion_sample/views/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.poppins().fontFamily),
      home: SplashScreen(),
      getPages: [
        GetPage(
          name: PageRouteName.splash,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: PageRouteName.login,
          page: () => LoginPage(),
        ),
        GetPage(
          name: PageRouteName.register,
          page: () => RegisterPage(),
        ),
        GetPage(
          name: PageRouteName.myreviews,
          page: () => MyReviews(),
        ),
        GetPage(
          name: PageRouteName.newreviews,
          page: () => NewReviews(),
        ),
        GetPage(
          name: PageRouteName.profile,
          page: () => Profile(),
        ),
        GetPage(
          name: PageRouteName.forgetPassword,
          page: () => ForgetPassword(),
        ),
        GetPage(
          name: PageRouteName.splashDiologue,
          page: () => SplashDiologue(),
        ),
        GetPage(
          name: PageRouteName.changePassword,
          page: () => ChangePassword(),
        ),
        GetPage(
          name: PageRouteName.patientinformation,
          page: () => PatientInformation(),
        ),
        GetPage(
          name: PageRouteName.medicaldetails,
          page: () => MedicalDetails(),
        ),
        GetPage(
          name: PageRouteName.uploadrecords,
          page: () => UploadRecords(),
        ),
        GetPage(
          name: PageRouteName.medicalrecords,
          page: () => MedicalRecords(),
        ),
        GetPage(
          name: PageRouteName.currentmedications,
          page: () => CurrentMedications(),
        ),
        GetPage(
          name: PageRouteName.payments,
          page: () => Payments(),
        )
      ],
    );
  }
}

class PageRouteName {
  static const splash = '/';
  static const login = '/login';
  static const myreviews = '/myreviews';
  static const newreviews = '/newreview';
  static const profile = '/profile';
  static const register = '/register';
  static const forgetPassword = '/forgetPassword';
  static const splashDiologue = '/splashscreendialogue';
  static const changePassword = '/changepassword';
  static const patientinformation = '/patientinformation';
  static const medicaldetails = '/medicaldetails';
  static const uploadrecords = '/uploadrecords';
  static const medicalrecords = '/medicalrecords';
  static const currentmedications = '/currentmedications';
  static const payments = '/payments';
}
