import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/driverInformation/screens/add_payment_screen.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:kayan/wallet/wallet_provider.dart';
import 'package:kayan/wallet/widgets/balance_box.dart';
import 'package:kayan/wallet/widgets/cash_box.dart';
import 'package:kayan/wallet/widgets/discount_box.dart';
import 'package:kayan/wallet/widgets/money_widget.dart';
import 'package:kayan/wallet/widgets/payment_method.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          LocaleKeys.myWallet.tr(),
          style: TextStyle(
              fontSize: 22.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30.w.h,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              //TODO
            },
            icon: Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 30.w.h,
            ),
          ),
        ],
      ),
      key: _scaffoldKey,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            height: 300.h,
            child: SvgPicture.asset(panelBackGraound, fit: BoxFit.cover),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 120.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CashBox(
                      borderColor: walletProvider.cashBoxSelected
                          ? Colors.transparent
                          : Colors.white,
                      boxColor: walletProvider.cashBoxSelected
                          ? Colors.white
                          : Colors.transparent,
                      fontColor:
                          walletProvider.cashBoxSelected ? blue : Colors.white,
                      onPressed: () {
                        walletProvider.inCashBoxSelect();
                      },
                    ),
                    BalanceBox(
                      borderColor: walletProvider.balanceBoxSelected
                          ? Colors.transparent
                          : Colors.white,
                      boxColor: walletProvider.balanceBoxSelected
                          ? Colors.white
                          : Colors.transparent,
                      fontColor: walletProvider.balanceBoxSelected
                          ? blue
                          : Colors.white,
                      onPressed: () {
                        walletProvider.inBalanceBoxSelect();
                      },
                    ),
                    DiscountBox(
                      borderColor: walletProvider.discountBoxSelected
                          ? Colors.transparent
                          : Colors.white,
                      boxColor: walletProvider.discountBoxSelected
                          ? Colors.white
                          : Colors.transparent,
                      fontColor: walletProvider.discountBoxSelected
                          ? blue
                          : Colors.white,
                      onPressed: () {
                        walletProvider.inDiscountBoxSelect();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              MoneyWidget(
                money: '0.0',
              ),
              SizedBox(height: 130.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      LocaleKeys.paymentHistory.tr(),
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.only(top: 10.h),
                      height: 300.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          // borderRadius: BorderRadius.circular(10.r),
                          // border: Border.all(color: Colors.grey.shade200),
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          // ListTile(
                          //   leading: CircleAvatar(
                          //     radius: 30.r,
                          //     backgroundImage:
                          //         AssetImage('assets/images/man.jpeg'),
                          //   ),
                          //   title: Text(
                          //     'Omar Alshaieb',
                          //     style: TextStyle(fontSize: 20.sp),
                          //   ),
                          //   subtitle: Text(
                          //     '#874587',
                          //     style: TextStyle(fontSize: 15.sp),
                          //   ),
                          //   trailing: Text(
                          //     '${LocaleKeys.sar.tr()} 60.00',
                          //     style: TextStyle(fontSize: 18.sp),
                          //   ),
                          // ),
                          // // Divider(indent: 8.h),
                          Icon(
                            Icons.history,
                            size: 100.h.w,
                            color: blue.withOpacity(.3),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 260.h,
            child: PaymentMethodWidgeet(
              onTap: () {
                Navigator.of(context).push(fadeRoute(AddPaymentMethodScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
