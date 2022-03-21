import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayan/Home/screens/home_page.dart';
import 'package:kayan/VerifyPhoneNumber/screens/verify_phone_number_screen.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/deliveryTypes/providers/delivery_types_provider.dart';
import 'package:kayan/driverInformation/providers/paymemets_provider.dart';
import 'package:kayan/driverInformation/providers/vhicles_provider.dart';
import 'package:kayan/driverInformation/screens/congratulations_scree.dart';
import 'package:kayan/driverInformation/screens/driver_info_screen.dart';
import 'package:kayan/notifications/provider/notification_provider.dart';
import 'package:kayan/onBoarding/screens/on_boarding_screen.dart';
import 'package:kayan/service/database.dart';
import 'package:kayan/streams/ordersMangaer.dart';
import 'package:kayan/translations/codegen_loader.g.dart';
import 'package:kayan/wallet/wallet_provider.dart';
import 'package:kayan/widgets/loadingWidget.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    assetLoader: CodegenLoader(),
    path: 'assets/translations',
    supportedLocales: [
      Locale('en'),
      Locale('ar'),
    ],
    saveLocale: true,
    fallbackLocale: Locale('en'),
    child: MyApp(),
  ));
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _service = DatabaseServices();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseServices>(
            create: (context) => DatabaseServices()),
        ChangeNotifierProvider<VehiclesProvider>(
            create: (context) => VehiclesProvider()),
        ChangeNotifierProvider<PaymentProvider>(
            create: (context) => PaymentProvider()),
        ChangeNotifierProvider<WalletProvider>(
            create: (context) => WalletProvider()),
        ChangeNotifierProvider<DeliveryTypesProvider>(
            create: (context) => DeliveryTypesProvider()),
        ChangeNotifierProvider<NotificationProvider>(
            create: (context) => NotificationProvider()),
        ChangeNotifierProvider<OrderManager>(
            create: (context) => OrderManager()),
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: () => OverlaySupport.global(
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'SAS',
            theme: ThemeData(
                fontFamily: 'sky',
                primaryColor: Colors.white,
                secondaryHeaderColor: Colors.white,
                appBarTheme: AppBarTheme(
                    centerTitle: true,
                    color: Colors.white,
                    titleTextStyle: TextStyle(color: blue))),
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(
                      child: LoadingWidget(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: LoadingWidget(),
                    ),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.hasData == false ||
                    snapshot.requireData == null) {
                  if (initScreen == 0 || initScreen == null)
                    return OnBoardingScreen();

                  return VerifyPhoneScreen();
                } else {
                  return FutureBuilder<Map<String, dynamic>>(
                    future: _service.checkIfDataHasCompleted2(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Scaffold(
                          body: Center(child: LoadingWidget()),
                        );
                      } else if (!snapshot.hasData) {
                        return VerifyPhoneScreen();
                      } else {
                        if (snapshot.data!['hasCompletedRegForm'] == '0') {
                          return DriverInfoScreen();
                        } else if (snapshot.data!['hasCompletedRegForm'] ==
                                '1' &&
                            snapshot.data!['status'] == '0') {
                          return CongartsScreen();
                        } else if (snapshot.data!['hasCompletedRegForm'] ==
                                '1' &&
                            snapshot.data!['status'] == '1') {
                          return HomePage();
                        }
                      }
                      return VerifyPhoneScreen();
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
