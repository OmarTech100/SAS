import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/driverInformation/providers/paymemets_provider.dart';
import 'package:kayan/driverInformation/screens/addNewCard_screen.dart';
import 'package:kayan/driverInformation/widgets/add_new_card_widget.dart';
import 'package:kayan/driverInformation/widgets/credit_cards.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<PaymentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          LocaleKeys.paymentMethod.tr(),
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: blue,
            size: 30.h.w,
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: AddNewCardWidget(),
                    onTap: () {
                      Navigator.of(context).push(fadeRoute(AddNewCardScreen()));
                    },
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    LocaleKeys.creditCards1.tr(),
                    style: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(14.w.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: _provider.paymentAdded
                        ? Column(
                            children: [
                              CreditCards(
                                assetName: _provider.svgName,
                                child1: Text(
                                  _provider.paymentNumber,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                ),
                                child2: Text(
                                  _provider.paymentMethod,
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.grey),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Divider(),
                              SizedBox(height: 10.h),
                            ],
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  paymentIcon,
                                  height: 100.h,
                                  // color: Colors.black12,
                                ),
                                // SizedBox(height: 10),
                              ],
                            ),
                            heightFactor: 2.h,
                          ),
                  ),
                  SizedBox(
                    height: 150.h,
                  ),
                  customButton(
                      onPressed: () {},
                      text: LocaleKeys.apply.tr(),
                      width: double.infinity)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
