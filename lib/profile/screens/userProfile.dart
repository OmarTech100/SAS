import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayan/Home/screens/home_page.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/service/database.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:kayan/widgets/loadingWidget.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({Key? key}) : super(key: key);
  @override
  _DriverProfileScreenState createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  File? _personalImage;
  bool _isLoading = false;

// take photo method
  Future<void> _takeImage() async {
    final _picker = ImagePicker();
    try {
      final personalImageFile =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

      setState(() {
        _personalImage = File(personalImageFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

// pick photo method
  Future<void> _pickImage() async {
    final _picker = ImagePicker();
    try {
      final personalImageFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      setState(() {
        _personalImage = File(personalImageFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  void _bottomSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _takeImage();
              },
              child: Text(LocaleKeys.pickFromCam.tr()),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage();
              },
              child: Text(LocaleKeys.pickPhoto.tr()),
            ),
          ],
        ),
      );
    }
    if (Platform.isAndroid) {
      showModalBottomSheet(
        context: context,
        builder: (context) => ListView(
          children: [
            GestureDetector(
              child: ListTile(
                leading: Icon(
                  Icons.camera_alt_rounded,
                ),
                title: Text(LocaleKeys.pickFromCam.tr()),
                onTap: () {
                  Navigator.of(context).pop();
                  _takeImage();
                },
              ),
            ),
            GestureDetector(
              child: ListTile(
                leading: Icon(
                  Icons.image,
                ),
                title: Text(LocaleKeys.pickPhoto.tr()),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage();
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  void _setLanguageToArabic() async {
    await Future.delayed(Duration(milliseconds: 400));
    Navigator.of(context).pushReplacement(fadeRoute(HomePage()));
    await context.setLocale(Locale('ar'));
  }

  void _setLanguageToEnglish() async {
    await Future.delayed(Duration(milliseconds: 400));
    Navigator.of(context).pushReplacement(fadeRoute(HomePage()));
    await context.setLocale(Locale('en'));
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<DatabaseServices>(context, listen: false);
    // final padding = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          LocaleKeys.profile.tr(),
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        actions: [],
        leading: IconButton(
            onPressed: () => _isLoading ? null : Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: blue,
              size: 30.w.h,
            )),
      ),
      backgroundColor: Colors.white,


      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 60.r,
                          backgroundImage: _personalImage != null
                              ? FileImage(_personalImage!)
                              : NetworkImage(_provider.driver!.personalPhoto!)
                                  as ImageProvider<Object>?,
                          backgroundColor: Colors.grey.shade100,
                        ),
                        SizedBox(height: 15.h),
                        InkWell(
                          child: Text(
                            LocaleKeys.editPhoto.tr(),
                            style: TextStyle(color: blue),
                          ),
                          onTap: () {
                            _bottomSheet(context);
                          },
                        ),
                        SizedBox(height: 40.h),
                        LayoutBuilder(
                          builder: (context, constrains) => Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 60.h,
                                child: TextFormField(
                                  enabled: false,
                                  initialValue: _provider.driver!.firstName,
                                  enableInteractiveSelection: true,
                                  // controller: _firstNameController,
                                  decoration: InputDecoration(
                                    labelText: LocaleKeys.firstName.tr(),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Container(
                                height: 60.h,
                                child: TextFormField(
                                  enabled: false,
                                  initialValue: _provider.driver!.lastName,
                                  enableInteractiveSelection: true,
                                  // controller: _lastNameController,
                                  decoration: InputDecoration(
                                    labelText: LocaleKeys.lastName.tr(),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Container(
                                height: 60.h,
                                child: TextFormField(
                                  enabled: false,
                                  initialValue:
                                      '00${_provider.driver!.mobileNumber!.substring(1, 13)}',
                                  enableInteractiveSelection: true,
                                  // controller: _mobileNumberController,
                                  decoration: InputDecoration(
                                    labelText: LocaleKeys.phoneNumber.tr(),
                                    // alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: blue,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: TextButton(
                                      onPressed: () async {
                                        context.locale == Locale('ar')
                                            ? _setLanguageToEnglish()
                                            : _setLanguageToArabic();
                                      },
                                      child: context.locale.languageCode == 'ar'
                                          ? Text(
                                              'English',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              'العربية',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 80.h),
                        customButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await _provider.updateDriverPhoto(
                                uid: _provider.driverId,
                                personalPhoto: _personalImage,
                              );
                              Navigator.of(context)
                                  .pushReplacement(fadeRoute(HomePage()));
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            text: LocaleKeys.save.tr(),
                            width: double.infinity)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          _isLoading
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black12,
                  child: Center(
                    child: LoadingWidget(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
