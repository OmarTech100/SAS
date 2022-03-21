import 'package:flutter/material.dart';
import 'package:kayan/constants/constants.dart';
import 'package:kayan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class DeliveryTypesProvider with ChangeNotifier {
  List<Map<String, dynamic>> types() {
    return [
      {
        LocaleKeys.shops.tr(): [
          '($LocaleKeys.shops.tr() ${LocaleKeys.ordersAvilable.tr()})',
          shopsIcon,
          documentsBtn,
        ],
      },
      {
        LocaleKeys.Food.tr(): [
          '(${LocaleKeys.Food.tr()}' '${LocaleKeys.ordersAvilable.tr()})',
          foodIcon,
          documentsBtn,
        ],
      },
      {
        LocaleKeys.packages.tr(): [
          '(${LocaleKeys.packages.tr()}' ' ${LocaleKeys.ordersAvilable.tr()})',
          packageRoundIcon,
          documentsBtn,
        ],
      },
      {
        LocaleKeys.documents.tr(): [
          '(${LocaleKeys.documents.tr()}' ' ${LocaleKeys.ordersAvilable.tr()})',
          documentsIcon,
          documentsBtn,
        ],
      },
      {
        LocaleKeys.gifts.tr(): [
          '(${LocaleKeys.gifts.tr()}' ' ${LocaleKeys.ordersAvilable.tr()})',
          giftsIcon,
          documentsBtn,
        ],
      },
      {
        LocaleKeys.Pharmecies.tr(): [
          '(${LocaleKeys.Pharmecies.tr()}' ' ${LocaleKeys.ordersAvilable.tr()}',
          medicineIcons,
          documentsBtn,
        ],
      },
      {
        LocaleKeys.others.tr(): [
          '(${LocaleKeys.others.tr()}' ' ${LocaleKeys.ordersAvilable.tr()}',
          othersIcon,
          documentsBtn,
        ],
      },
      {
        LocaleKeys.allTypes.tr(): [
          '(${LocaleKeys.allTypes.tr()}' ' ${LocaleKeys.ordersAvilable.tr()})',
          truckIcon,
          documentsBtn,
        ],
      },
    ];
  }

  List<Map<String, dynamic>> types2([String? order]) {
    return [
      {
        'Shops': [
          '($order ${LocaleKeys.ordersAvilable.tr()})',
          shopsIcon,
          documentsBtn,
        ],
      },
      {
        'Food': [
          '($order ${LocaleKeys.ordersAvilable.tr()})',
          foodIcon,
          documentsBtn,
        ],
      },
      {
        'Packages': [
          '($order ${LocaleKeys.ordersAvilable.tr()})',
          packageRoundIcon,
          documentsBtn,
        ],
      },
      {
        'Documents': [
          '($order ${LocaleKeys.ordersAvilable.tr()})',
          documentsIcon,
          documentsBtn,
        ],
      },
      {
        'Gifts': [
          '($order ${LocaleKeys.ordersAvilable.tr()})',
          giftsIcon,
          documentsBtn,
        ],
      },
      {
        'Pharmacies': [
          '($order ${LocaleKeys.ordersAvilable.tr()}',
          medicineIcons,
          documentsBtn,
        ],
      },
      {
        'Others': [
          '($order ${LocaleKeys.ordersAvilable.tr()}',
          othersIcon,
          documentsBtn,
        ],
      },
      {
        'All Types': [
          '($order ${LocaleKeys.ordersAvilable.tr()})',
          truckIcon,
          documentsBtn,
        ],
      },
    ];
  }
}

List<Map<String, dynamic>> types = [
  {
    '1': [
      LocaleKeys.shops.tr(),
      '(${LocaleKeys.ordersAvilable.tr()})',
      shopsIcon,
      documentsBtn,
    ],
  },
  {
    '2': [
      LocaleKeys.Food.tr(),
      '(${LocaleKeys.ordersAvilable.tr()})',
      foodIcon,
      documentsBtn,
    ],
  },
  {
    '3': [
      LocaleKeys.packages.tr(),
      '( ${LocaleKeys.ordersAvilable.tr()})',
      packageRoundIcon,
      documentsBtn,
    ],
  },
  {
    '4': [
      LocaleKeys.documents.tr(),
      '(${LocaleKeys.ordersAvilable.tr()})',
      documentsIcon,
      documentsBtn,
    ],
  },
  {
    '5': [
      LocaleKeys.gifts.tr(),
      '(${LocaleKeys.ordersAvilable.tr()})',
      giftsIcon,
      documentsBtn,
    ],
  },
  {
    '6': [
      LocaleKeys.Pharmecies.tr(),
      '(${LocaleKeys.ordersAvilable.tr()}',
      medicineIcons,
      documentsBtn,
    ],
  },
  {
    '7': [
      LocaleKeys.others.tr(),
      '(${LocaleKeys.ordersAvilable.tr()}',
      othersIcon,
      documentsBtn,
    ],
  },
  {
    '8': [
      LocaleKeys.allTypes.tr(),
      '(${LocaleKeys.ordersAvilable.tr()})',
      truckIcon,
      documentsBtn,
    ],
  },
];
