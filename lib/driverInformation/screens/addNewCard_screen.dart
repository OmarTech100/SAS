import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/driverInformation/providers/paymemets_provider.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({Key? key}) : super(key: key);

  @override
  _AddNewCardScreenState createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _holderNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvcController = TextEditingController();
//-------------------------------------------------------

  void _validateInfo() {
    final valid = _formKey.currentState!.validate();

    if (!valid) {
      return;
    } else {
      _formKey.currentState!.save();
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _holderNameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<PaymentProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            LocaleKeys.addNewCard.tr(),
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
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.cardHolderName.tr(),
                                style: _textStyle()),
                            SizedBox(height: 10.h),
                            TextFormField(
                              validator: (val) {
                                if (val!.isEmpty || val.length < 5) {
                                  return 'please enter a valid name';
                                }
                                return null;
                              },
                              controller: _holderNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Enter your name in the card',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                              ),
                              keyboardType: TextInputType.name,
                            ),
                            SizedBox(height: 20.h),
                            Text(LocaleKeys.cardNumber.tr(),
                                style: _textStyle()),
                            SizedBox(height: 10.h),
                            TextFormField(
                              validator: (val) {
                                if (val!.isEmpty || val.length < 16) {
                                  return 'please enter a vlaid card number';
                                }
                                return null;
                              },
                              controller: _cardNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: '**** **** **** ****',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(LocaleKeys.expiry.tr(),
                                        style: _textStyle()),
                                    SizedBox(height: 10.h),
                                    Container(
                                      height: 60.h,
                                      width: 150.w,
                                      child: TextFormField(
                                        validator: (val) {
                                          if (val!.isEmpty || val.length < 4) {
                                            return 'please enter a valid expiry date Ex. 12/21';
                                          }
                                          return null;
                                        },
                                        controller: _expiryDateController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          hintText: 'MM/YY',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(LocaleKeys.cvc.tr(),
                                        style: _textStyle()),
                                    SizedBox(height: 10.h),
                                    Container(
                                      height: 60.h,
                                      width: 150.w,
                                      child: TextFormField(
                                        validator: (val) {
                                          if (val!.isEmpty || val.length < 3) {
                                            return 'please enter a validi CVC number';
                                          }
                                          return null;
                                        },
                                        controller: _cvcController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          hintText: '123',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150.h,
                      ),
                      customButton(
                          onPressed: () {
                            _validateInfo();
                            _provider.setPyment(visaCardIcon,
                                _cardNumberController.text, 'VISA');
                          },
                          text: LocaleKeys.save.tr(),
                          width: double.infinity)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle _textStyle() {
  return TextStyle(
      color: Colors.grey, fontSize: 16.sp, fontWeight: FontWeight.bold);
}
