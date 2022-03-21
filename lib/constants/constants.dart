//Onboarding logos
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

// icons
const signInLogo = 'assets/icons/sign_in_logo.svg';
const internetLogo = 'assets/icons/internet_logo.svg';
const startUp = 'assets/icons/startup_logo.svg';
const blockImage = 'assets/images/block.png';
const flag = 'assets/icons/flag-ksa.svg';
const loading = 'assets/loading-dots.json';
const idCard = 'assets/icons/idCard.svg';
const carLeftSide = 'assets/images/car_left.svg';
const carRightSide = 'assets/images/car_right.svg';
const carFrontSide = 'assets/images/car_front.svg';
const carBackSide = 'assets/images/car_back.svg';
const paymentIcon = 'assets/icons/payment_icon.svg';
const visaCardIcon = 'assets/icons/cc-visa.svg';
const materCardIcon = 'assets/icons/cc-mastercard.svg';
const stcPayIcon = 'assets/icons/stc-pay.svg';
const congratsIcon = 'assets/icons/congreats_icon.svg';
const menuIcon = 'assets/icons/menu_icon.svg';
const notificationBellWithBuble = 'assets/icons/notification_bell.svg';
const notificationBell = 'assets/icons/notification.svg';
const truckIcon = 'assets/icons/truck.svg';
const packageRoundIcon = 'assets/icons/packages.svg';
const documentsBtn = 'assets/icons/documents_btn.svg';
const documentsIcon = 'assets/icons/documents.svg';
const foodIcon = 'assets/icons/food.svg';
const shopsIcon = 'assets/icons/shops.svg';
const giftsIcon = 'assets/icons/gift.svg';
const medicineIcons = 'assets/icons/Medicine.svg';
const othersIcon = 'assets/icons/Others.svg';
const panelBackGraound = 'assets/images/panel_backGround.svg';
const timeIcon = 'assets/icons/time_icon.svg';
const speedIcon = 'assets/icons/speed_icon.svg';
const ordersIcon = 'assets/icons/orders_icon.svg';
const homeSettingsIcon = 'assets/icons/home.svg';
const walletSettingsIcon = 'assets/icons/wallet.svg';
const historySettingsIcon = 'assets/icons/history.svg';
const notificationsSettingIcon = 'assets/icons/notification_settings.svg';
const settingsIcon = 'assets/icons/settings.svg';
const logoutIcon = 'assets/icons/logout.svg';
const helpIcon = 'assets/icons/help.svg';
const addPaymentIcon = 'assets/icons/add_payment.svg';
const mapIcon = 'assets/icons/map_icon.svg';
const locationArrow = 'assets/icons/location-arrow.svg';
const messageIcon = 'assets/icons/contact.svg';
const carIcon = 'assets/icons/car_icon.svg';
const moneyIcon = 'assets/icons/money_icon.svg';
const idCardPng = 'assets/images/id-card.png';
const car_drivingLicense = 'assets/images/driver-license.png';
const dataReview = 'assets/data-review.json';

//-------------------------------------------------------------

final f = DateFormat("dd-MM-yyyy  hh:mm a");
final f2 = DateFormat("yyyy-MM-dd");
final f3 = DateFormat("yyyy");
final timeStampFormat = DateFormat("yyyy-MM-dd hh:mm:ss");

final format2 = DateFormat("dd");
final format3 = DateFormat("EEEE");

//-------------------------------------------------------------------
//colors
final blue = HexColor('#14ACC1');
final darkBlue = HexColor('#242A37');
final purple = HexColor('#6648FF');
final orange = HexColor('#FF6D48');
final green = HexColor('#19CF92');
final lightGrey = HexColor('#AEB1BD');
final lightBlueGrey = HexColor('#EEEEFF');
final darkGrey = HexColor('#707070');
final grey = HexColor('#A7B2BB');
final darkgreen = HexColor('#09BB6D');
final red = HexColor('#F52D56');
final greyLighter = HexColor('#BEC2CE');
final yellow = HexColor('#FFD448');
final deepPurple = HexColor('#4252FF');

//------------------------------------------------------------
Route fadeRoute(Widget page, {Object? arguments}) {
  return PageRouteBuilder(
      settings: RouteSettings(
        arguments: arguments,
      ),
      pageBuilder: (context, animation, anotherAnimation) {
        return page;
      },
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
        return FadeTransition(
          opacity: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      });
}
//--------------------------------------------------------------------

Widget back({@required Color? color, required void Function()? onPressed}) {
  return Positioned(
    top: 40,
    left: 10,
    child: IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.arrow_back_rounded,
        color: color,
        size: 30,
      ),
    ),
  );
}
//-----------------------------------------------

Widget customButton(
    {required void Function()? onPressed,
    required String text,
    required double width}) {
  return InkWell(
    overlayColor: MaterialStateProperty.all(Colors.white),
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      height: 60.h,
      width: width,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20.sp,
        ),
      ),
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
  );
}

//-----------------------------------------------
