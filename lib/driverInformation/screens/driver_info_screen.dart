import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayan/VerifyPhoneNumber/screens/verify_phone_number_screen.dart';
import 'package:kayan/constants/cars.dart';
import 'package:kayan/constants/cities.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/constants/nationalities.dart';
import 'package:kayan/constants/vehicles_colors.dart';
import 'package:kayan/driverInformation/screens/congratulations_scree.dart';
import 'package:kayan/driverInformation/widgets/add_vehicle_widget.dart';
import 'package:kayan/driverInformation/widgets/next_button.dart';
import 'package:kayan/driverInformation/widgets/personal_info.dart';
import 'package:kayan/driverInformation/widgets/top_bar.dart';
import 'package:kayan/driverInformation/widgets/uploadDocs_widget.dart';
import 'package:kayan/models/driver/bank.dart';
import 'package:kayan/models/driver/car.dart';
import 'package:kayan/models/driver/driver.dart';
import 'package:kayan/models/driver/driverLocation.dart';
import 'package:kayan/service/database.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:kayan/widgets/loadingWidget.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverInfoScreen extends StatefulWidget {
  const DriverInfoScreen({Key? key}) : super(key: key);

  @override
  _DriverInfoScreenState createState() => _DriverInfoScreenState();
}

class _DriverInfoScreenState extends State<DriverInfoScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _additionalNumberController = TextEditingController();
  final fixedExtentScrollController = FixedExtentScrollController();
  final _pageController = PageController();
  final _idNumberController = TextEditingController();
  int _index = 0;
  String _gender = 'male';
  bool malePicked = true;
  bool femalePicked = false;
  File? _personalImage;
  File? _imageFront;
  File? _imageback;
  File? _imageLeft;
  File? _imageRight;
  File? _idCardImage;
  File? _drivingLicenseImage;
  File? _carRegImage;
  String _pickedCity = LocaleKeys.abha.tr();
  String _pickedNationality = LocaleKeys.afghan.tr();

  String _pickedDate = f2.format(DateTime.now());
  bool _isLoading = false;
  //-----------------------------
  final _plateCharController = TextEditingController();
  final _plateNoController = TextEditingController();
  String _pickedColor = LocaleKeys.black.tr();
  String _pickedType = LocaleKeys.sedan.tr();
  String _pickedYear = f3.format(DateTime.now());
  List<String> pageName = [
    LocaleKeys.completeYourInfo.tr(),
    LocaleKeys.addNewCar.tr(),
    LocaleKeys.uploadDocuments.tr()
  ];

  bool validateUserInfo() {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _personalImage == null ||
        _phoneNumberController.text.isEmpty ||
        _idNumberController.text.isEmpty ||
        _pickedNationality.isEmpty ||
        _pickedCity.isEmpty ||
        _pickedDate.isEmpty ||
        _pickedType.isEmpty ||
        _pickedYear.isEmpty ||
        _plateCharController.text.isEmpty ||
        _plateNoController.text.isEmpty ||
        _pickedColor.isEmpty ||
        _imageLeft == null ||
        _imageRight == null ||
        _imageback == null ||
        _imageFront == null ||
        _idCardImage == null ||
        _drivingLicenseImage == null ||
        _carRegImage == null) {
      return false;
    }
    return true;
  }

  //take photo method
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

  Future<void> _tackImageFronSide() async {
    final _picker = ImagePicker();
    try {
      final imageFrontFile =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

      setState(() {
        _imageFront = File(imageFrontFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  // pick photo method
  Future<void> _pickImageFrontSide() async {
    final _pickerFront = ImagePicker();

    try {
      final imageFrontFile = await _pickerFront.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      setState(() {
        _imageFront = File(imageFrontFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _tackImageBackSide() async {
    final _picker = ImagePicker();
    try {
      final imageBackFile =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

      setState(() {
        _imageback = File(imageBackFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  // pick photo method
  Future<void> _pickImageBackSide() async {
    final _pickerFront = ImagePicker();

    try {
      final imageBackFile = await _pickerFront.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      setState(() {
        _imageback = File(imageBackFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _tackImageLeftSide() async {
    final _picker = ImagePicker();
    try {
      final imageLeftFile =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

      setState(() {
        _imageLeft = File(imageLeftFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  // pick photo method
  Future<void> _pickImageLeftSide() async {
    final _pickerFront = ImagePicker();

    try {
      final imageLeftFile = await _pickerFront.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      setState(() {
        _imageLeft = File(imageLeftFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _tackeRightImageSide() async {
    final _picker = ImagePicker();
    try {
      final imageRightFile =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

      setState(() {
        _imageRight = File(imageRightFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  // pick photo method
  Future<void> _pickImageRightSide() async {
    final _pickerFront = ImagePicker();

    try {
      final imageRightFile = await _pickerFront.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      setState(() {
        _imageRight = File(imageRightFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _pickIdCardImage() async {
    final _picker = ImagePicker();

    try {
      final idCardImage = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      setState(() {
        _idCardImage = File(idCardImage!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _takeIdCardImage() async {
    final _picker = ImagePicker();

    try {
      final idCardImage =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

      setState(() {
        _idCardImage = File(idCardImage!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _pickDrivingLicenseImage() async {
    final _picker = ImagePicker();

    try {
      final drivingLicenseImage = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      setState(() {
        _drivingLicenseImage = File(drivingLicenseImage!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _takeDrivingLicenseImage() async {
    final _picker = ImagePicker();

    try {
      final drivingLicenseImage =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

      setState(() {
        _drivingLicenseImage = File(drivingLicenseImage!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _pickCarRegImage() async {
    final _picker = ImagePicker();

    try {
      final carRegImage = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      setState(() {
        _carRegImage = File(carRegImage!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _takeCarRegImage() async {
    final _picker = ImagePicker();

    try {
      final carRegImage =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

      setState(() {
        _carRegImage = File(carRegImage!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  // building the bottomsheet for personal driver photo
  void bottomSheet(BuildContext context) {
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

  // building the bottomsheet for driver car frontSide photo
  void frontCarBottomSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _tackImageFronSide();
              },
              child: Text(LocaleKeys.pickFromCam.tr()),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImageFrontSide();
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
                  _tackImageFronSide();
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
                  _pickImageFrontSide();
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  // building the bottomsheet for driver car BackSide photo
  void backCarBottomSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _tackImageBackSide();
              },
              child: Text(LocaleKeys.pickFromCam.tr()),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImageBackSide();
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
                  _tackImageBackSide();
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
                  _pickImageBackSide();
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  // building the bottomsheet for driver car LeftSide photo
  void leftCarBottomSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _tackImageLeftSide();
              },
              child: Text(LocaleKeys.pickFromCam.tr()),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImageLeftSide();
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
                  _tackImageLeftSide();
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
                  _pickImageLeftSide();
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  // building the bottomsheet for driver car RightSide photo
  void rightCarBottomSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _tackeRightImageSide();
              },
              child: Text(LocaleKeys.pickFromCam.tr()),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImageRightSide();
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
                  _tackeRightImageSide();
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
                  _pickImageRightSide();
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  void idCardBottomSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _takeIdCardImage();
              },
              child: Text(LocaleKeys.pickFromCam.tr()),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickIdCardImage();
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
                  _takeIdCardImage();
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
                  _pickIdCardImage();
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  void drivingLicenseBottomSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _takeDrivingLicenseImage();
              },
              child: Text(LocaleKeys.pickFromCam.tr()),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickDrivingLicenseImage();
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
                  _takeDrivingLicenseImage();
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
                  _pickDrivingLicenseImage();
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  void carRegBottomSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _takeCarRegImage();
              },
              child: Text(LocaleKeys.pickFromCam.tr()),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickCarRegImage();
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
                  _takeCarRegImage();
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
                  _pickCarRegImage();
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  // cupertino picker
  void buildPicker(
      {required BuildContext context,
      required String title,
      required List<dynamic> list,
      required void Function(dynamic i) onSelectedItemChanged}) {
    if (Platform.isIOS)
      showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
                cancelButton: TextButton(
                    clipBehavior: Clip.none,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      LocaleKeys.ok.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                title: Text(title),
                actions: [
                  Container(
                    height: 120.h,
                    child: CupertinoPicker.builder(
                      scrollController: fixedExtentScrollController,
                      childCount: list.length,
                      itemExtent: 40.h,
                      onSelectedItemChanged: onSelectedItemChanged,
                      itemBuilder: (context, index) {
                        return Center(child: Text(list[index].toString()));
                      },
                    ),
                  )
                ],
              ));
    if (Platform.isAndroid)
      showMaterialScrollPicker(
          context: context,
          title: title,
          items: list,
          selectedItem: list[5],
          onChanged: onSelectedItemChanged);
  }

  // date picker
  void buildDatePciker({
    required void Function(DateTime) onDateTimeChanged,
    required BuildContext context,
  }) {
    if (Platform.isIOS)
      showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
          height: 300.h,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(LocaleKeys.ok.tr()),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(LocaleKeys.Cancel.tr()),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: CupertinoDatePicker(
                    onDateTimeChanged: onDateTimeChanged,
                    initialDateTime: DateTime.now(),
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    minimumYear: 1900,
                    maximumYear: 2021),
              ),
            ],
          ),
        ),
      );
  }

  void buildMaterialYearPciker({
    required BuildContext context,
  }) {
    showDatePicker(
            initialDatePickerMode: DatePickerMode.year,
            locale: context.locale,
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((date) {
      setState(() {
        _pickedYear = f3.format(date!);
      });
    });
  }

  void buildMaterialDatePciker({
    required BuildContext context,
  }) {
    showDatePicker(
            locale: context.locale,
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((date) {
      setState(() {
        _pickedDate = f2.format(date!);
      });
    });
  }

  List<String> carList() {
    List<String>? cars;
    if (context.locale.languageCode == 'en') {
      setState(() {
        cars = carsEn;
      });
    } else {
      cars = carsAr;
    }
    return cars!;
  }

  List<int> yearList() {
    List<int>? year;

    int year1 = 2021;
    List<int> yearss = [];
    for (int i = 0; i < 100; i++) {
      yearss.add(year1 - i);
    }

    setState(() {
      year = yearss;
    });
    if (context.locale.languageCode == 'ar') {
      setState(() {
        year = yearss;
      });
    }
    return year!;
  }

  List<String> nationalitiesList() {
    List<String>? nationalities;
    if (context.locale.languageCode == 'en') {
      setState(() {
        nationalities = nationalitiesEn;
      });
    } else {
      nationalities = nationalitiesAr;
    }
    return nationalities!;
  }

  List<String> citylist() {
    List<String>? cities;
    if (context.locale.languageCode == 'en') {
      setState(() {
        cities = citiesEn;
      });
    } else {
      cities = citiesAr;
    }
    return cities!;
  }

  List<String> colorList() {
    List<String>? colors;
    if (context.locale.languageCode == 'en') {
      setState(() {
        colors = vehicleColorEn;
      });
    } else {
      colors = vehicleColorAr;
    }
    return colors!;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _additionalNumberController.dispose();
    _pageController.dispose();
    _plateCharController.dispose();
    _plateNoController.dispose();
    fixedExtentScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    final _provider = Provider.of<DatabaseServices>(context);
    List<Widget> pages = [
      SingleChildScrollView(
        child: PersonalInfoWidget(
            firstNameController: _firstNameController,
            lastNameController: _lastNameController,
            phoneNumberController: _phoneNumberController,
            additionalPhonenNumberController: _additionalNumberController,
            idNumberController: _idNumberController,
            pickedCity: _pickedCity,
            pickedDate: _pickedDate,
            pickedNationality: _pickedNationality,
            image: _personalImage,
            bottomSheet: () {
              FocusScope.of(context).requestFocus(FocusNode());
              bottomSheet(context);
            },
            gender: _gender,
            femalePicked: femalePicked,
            malePicked: malePicked,
            nationalityCupertinoPicker: () => buildPicker(
                context: context,
                title: LocaleKeys.nationality.tr(),
                list: nationalitiesList(),
                onSelectedItemChanged: (dynamic i) {
                  Platform.isIOS
                      ? setState(
                          () => _pickedNationality = nationalitiesList()[i])
                      : setState(() => _pickedNationality = i);
                }),
            cityCupertinoPicker: () => buildPicker(
                context: context,
                title: LocaleKeys.city.tr(),
                list: citylist(),
                onSelectedItemChanged: (dynamic i) {
                  Platform.isIOS
                      ? setState(() => _pickedCity = citylist()[i])
                      : setState(() => _pickedCity = i);
                }),
            buildDatePicker: () => Platform.isIOS
                ? buildDatePciker(
                    context: context,
                    onDateTimeChanged: (date) {
                      setState(() {
                        _pickedDate = f2.format(date);
                      });
                    })
                : buildMaterialDatePciker(context: context)),
      ),
      SingleChildScrollView(
        child: AddVehicleWidget(
          plateNoController: _plateNoController,
          plateCharController: _plateCharController,
          vehicleTypePicker: () => buildPicker(
              context: context,
              title: LocaleKeys.carType.tr(),
              list: carList(),
              onSelectedItemChanged: (dynamic i) {
                Platform.isIOS
                    ? setState(() => _pickedType = carList()[i])
                    : setState(() => _pickedType = i);
              }),
          vehicleColorPicker: () => buildPicker(
              context: context,
              title: LocaleKeys.color.tr(),
              list: colorList(),
              onSelectedItemChanged: (dynamic i) {
                Platform.isIOS
                    ? setState(() => _pickedColor = colorList()[i])
                    : setState(() => _pickedColor = i);
              }),
          pickedColor: _pickedColor,
          pickedType: _pickedType,
          pickedDate: _pickedYear,
          vehicleDatePicker: () => buildPicker(
              context: context,
              title: LocaleKeys.year.tr(),
              list: yearList(),
              onSelectedItemChanged: (dynamic i) {
                Platform.isIOS
                    ? setState(() => _pickedYear = yearList()[i].toString())
                    : setState(() => _pickedYear = i.toString());
              }),
          imageBack: _imageback,
          imageFront: _imageFront,
          imageRight: _imageRight,
          imageLeft: _imageLeft,
          imageBackPickerFunction: () => backCarBottomSheet(context),
          imageFrontPickerFunction: () => frontCarBottomSheet(context),
          imageLeftPickerFunction: () => leftCarBottomSheet(
            context,
          ),
          imageRightPickerFunction: () => rightCarBottomSheet(
            context,
          ),
        ),
      ),
      UploadDocsWidget(
        idCardPic: _idCardImage,
        drivingLicensesPic: _drivingLicenseImage,
        carRegPic: _carRegImage,
        idCardFunction: () => idCardBottomSheet(context),
        drivingLicensesFunction: () => drivingLicenseBottomSheet(context),
        carRegFunction: () => carRegBottomSheet(context),
      )
    ];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Top Bar
                TopBar(
                  text: pageName[_index],
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          if (Platform.isIOS)
                            return CupertinoAlertDialog(
                              title: Text(LocaleKeys.cancelRegTitle.tr()),
                              insetAnimationCurve: Curves.easeIn,
                              insetAnimationDuration:
                                  Duration(milliseconds: 600),
                              content: Text(LocaleKeys.cancelReg.tr()),
                              actions: [
                                TextButton(
                                  child: Text(LocaleKeys.ok.tr()),
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacement(
                                          fadeRoute(VerifyPhoneScreen())),
                                ),
                                TextButton(
                                  child: Text(LocaleKeys.Cancel.tr()),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            );
                          return AlertDialog(
                            title: Text(LocaleKeys.cancelRegTitle.tr()),
                            content: Text(LocaleKeys.cancelReg.tr()),
                            actions: [
                              TextButton(
                                child: Text(LocaleKeys.ok.tr()),
                                onPressed: () => Navigator.of(context)
                                    .pushReplacement(
                                        fadeRoute(VerifyPhoneScreen())),
                              ),
                              TextButton(
                                child: Text(LocaleKeys.Cancel.tr()),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          );
                        });
                  },
                ),
                // Pageview
                Expanded(
                  flex: 10,
                  child: PageView(
                    allowImplicitScrolling: false,
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int i) {
                      setState(() {
                        _index = i;
                      });
                    },
                    children: pages,
                  ),
                ),
                // Next / Prev Button
                Row(
                  children: [
                    NextOrSubmitButton(
                        text: LocaleKeys.previous.tr(),
                        onPressed: () {
                          _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                        }),
                    NextOrSubmitButton(
                        text: _index < 2
                            ? LocaleKeys.next.tr()
                            : LocaleKeys.submit.tr(),
                        onPressed: () async {
                          if (_index < 2) {
                            setState(() {});
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease);
                          } else if (validateUserInfo()) {
                            setState(() {
                              _isLoading = true;
                            });
                            await _provider.uploadDriverPictures(
                                personalImage: _personalImage!,
                                carFrontImage: _imageFront!,
                                carBackImage: _imageback!,
                                carLeftImage: _imageLeft!,
                                carRightImage: _imageRight!,
                                idCardImage: _idCardImage!,
                                driverLicenseImage: _drivingLicenseImage!,
                                carRegImage: _carRegImage!,
                                firstName: _firstNameController.text.trim(),
                                lastName: _lastNameController.text.trim());
                            await _provider.postDriver(
                              Driver(
                                firstName: _firstNameController.text.trim(),
                                lastName: _lastNameController.text.trim(),
                                mobileNumber: FirebaseAuth
                                    .instance.currentUser!.phoneNumber!,
                                additionalMobileNumber:
                                    _additionalNumberController.text.trim(),
                                dateOfBirth: _pickedDate,
                                idNumber: _idNumberController.text.trim(),
                                nationality: _pickedNationality,
                                stcPayPhoneNumber: _phoneNumberController.text,
                                gender: _gender,
                                drivingLicencePicture:
                                    _provider.drivingLicenseImage!,
                                personalPhoto: _provider.personalImage!,
                                idCardImage: _provider.idCardImage!,
                                carRegImage: _provider.carRegImage!,
                                city: _pickedCity,
                                status: 0.toString(),
                                registerDate:
                                    timeStampFormat.format(DateTime.now()),
                                totalDistance: 0.0.toString(),
                                totalEarned: 0.0.toString(),
                                totalJobs: 0.toString(),
                                hasCompletedRegForm: 1.toString(),
                                car: Car(
                                  type: _pickedType,
                                  licensePlateNumbers:
                                      _plateNoController.text.trim(),
                                  licensePlateLitters:
                                      _plateCharController.text.trim(),
                                  color: _pickedColor,
                                  carFrontSidePic: _provider.carFrontImage!,
                                  carBackSidePic: _provider.carBackImage!,
                                  carRightSidePic: _provider.carRightImage!,
                                  carLeftSidePic: _provider.carLeftImage!,
                                ),
                                bank: Bank(
                                  accountHolderName: "000000",
                                  bankName: "000000",
                                  ibanNumber: "00000000000",
                                ),
                                driverLocation: DriverLocation(
                                  latitude: "21.4878745",
                                  longitude: "30.73465745",
                                ),
                              ),
                            );

                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.of(context)
                                .pushReplacement(fadeRoute(CongartsScreen()));
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  if (Platform.isIOS)
                                    return CupertinoAlertDialog(
                                      title: Text('Mandatory fields'),
                                      content: Text(
                                          'Please provide all information'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok')),
                                      ],
                                    );
                                  return AlertDialog(
                                    title: Text('Mandatory fields'),
                                    content:
                                        Text('Please provide all information'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Ok')),
                                    ],
                                  );
                                });
                          }
                        }),
                  ],
                )
              ],
            )),
            _isLoading
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black38,
                    child: LoadingWidget(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
