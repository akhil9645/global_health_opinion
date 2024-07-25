import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/views/auth_view/change_password.dart';
import 'package:global_health_opinion_sample/views/auth_view/forget_password.dart';
import 'package:global_health_opinion_sample/views/auth_view/login_page.dart';
import 'package:global_health_opinion_sample/views/my_reviews/my_reviews.dart';
import 'package:global_health_opinion_sample/views/new_reviews/new_reviews.dart';
import 'package:global_health_opinion_sample/views/new_reviews/new_review_fields_view/current_medications.dart';
import 'package:global_health_opinion_sample/views/new_reviews/new_review_fields_view/medical_details.dart';
import 'package:global_health_opinion_sample/views/new_reviews/new_review_fields_view/medical_records.dart';
import 'package:global_health_opinion_sample/views/new_reviews/new_review_fields_view/patient_information.dart';
import 'package:global_health_opinion_sample/views/payments_view/payments.dart';
import 'package:global_health_opinion_sample/views/new_reviews/new_review_fields_view/upload_records.dart';
import 'package:global_health_opinion_sample/views/profile_view/profile.dart';
import 'package:global_health_opinion_sample/views/auth_view/register_page.dart';
import 'package:global_health_opinion_sample/views/splash_view/splash_diologue.dart';
import 'package:global_health_opinion_sample/views/splash_view/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

late List<CameraDescription> cameras;
String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

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
