import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzum_market_admin_panel/utils/extension/sized_box_extension.dart';
import 'package:uzum_market_admin_panel/viewmodel/product_view_model.dart';
import 'package:uzum_market_admin_panel/views/widgets/custom_text_form_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProductViewModel _productViewModel = ProductViewModel();
  String newSeller = '', newAboutProduct = '';
  int newPrice = 0, newCategory = 0;
  List<String> newName = ['', ''];
  List<int> newSaleType = [];
  List<String> newImages = [''];
  List<String> newBrieflyAboutProduct = [''];
  bool canDeleteImage = true;
  bool canDeleteDescription = true;
  int leftProduct = 0;

  @override
  void initState() {
    super.initState();
  }

  String? validator(String? value, String validatorText) {
    if (value == null || value.trim().isEmpty) {
      return 'Mahsulot ${validatorText}ni kiriting.';
    }
    return null;
  }

  String? intValidator(String? p0, String validatorText) {
    if (p0 == null || p0.trim().isEmpty || !(int.tryParse(p0) != null)) {
      return validatorText;
    }
    return null;
  }

  void deleteImage(int index) {
    canDeleteImage = true;
    if (newImages.length > 1) {
      newImages.removeAt(index);
    } else {
      canDeleteImage = false;
    }
    setState(() {});
  }

  void addImage() {
    newImages.add('');
    setState(() {});
  }

  void deleteBrieflyAboutProduct(int index) {
    canDeleteDescription = true;
    if (newBrieflyAboutProduct.length > 1) {
      newBrieflyAboutProduct.removeAt(index);
    } else {
      canDeleteDescription = false;
    }
    setState(() {});
  }

  void addBrieflyAboutProduct() {
    newBrieflyAboutProduct.add('');
    setState(() {});
  }

  List<int>? checkList(String str) {
    try {
      var decoded = jsonDecode(str);
      return List<int>.from(decoded);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const PageScrollPhysics(),
            children: [
              20.height(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Product name fields
                    CustomTextFormField(
                      initialValue: '',
                      labelText: 'Mahsulot nomi(uz)',
                      validator: (String? p0) {
                        return validator(p0, 'nomi');
                      },
                      onSaved: (String? p0) {
                        if (newName.isNotEmpty) {
                          newName[0] = p0 ?? '';
                        }
                      },
                    ),
                    15.height(),
                    CustomTextFormField(
                      initialValue: '',
                      labelText: 'Mahsulot nomi(ru)',
                      validator: (String? p0) {
                        return validator(p0, 'nomi');
                      },
                      onSaved: (String? p0) {
                        if (newName.length > 1) {
                          newName[1] = p0 ?? '';
                        }
                      },
                    ),
                    15.height(),

                    // Product price field
                    CustomTextFormField(
                      initialValue: '',
                      labelText: 'Mahsulot narxi',
                      validator: (String? p0) {
                        return intValidator(p0, 'Mahsulot narxini kiriting');
                      },
                      onSaved: (String? p0) {
                        if (p0 != null) {
                          newPrice = int.parse(p0);
                        }
                      },
                    ),
                    15.height(),
                    SizedBox(
                      height: 20.h,
                      child: const Divider(),
                    ),

                    // Product images fields
                    for (int i = 0; i < newImages.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: 20.0.w, left: 20.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${i + 1}-rasm'),
                                if (i == 0 && !canDeleteImage)
                                  Text(
                                    'Kamida 1 ta rasm bo\'lishi shart!',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                Row(
                                  children: [
                                    if (i == 0)
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () => addImage(),
                                      ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => deleteImage(i),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CustomTextFormField(
                            initialValue: '',
                            labelText: 'Mahsulot rasmi ${i + 1}',
                            validator: (String? p0) {
                              return validator(p0, 'rasmi');
                            },
                            onSaved: (String? newValue) {
                              if (i < newImages.length) {
                                newImages[i] = newValue ?? '';
                              }
                            },
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 50.h,
                      child: const Divider(),
                    ),

                    // Product category field
                    CustomTextFormField(
                      initialValue: '',
                      labelText: 'Mahsulot kategoriyasi',
                      validator: (String? p0) {
                        return intValidator(
                            p0, 'Mahsulot kategoriyasini kiriting');
                      },
                      onSaved: (String? p0) {
                        if (p0 != null) {
                          newCategory = int.parse(p0);
                        }
                      },
                    ),
                    15.height(),

                    // Product seller field
                    CustomTextFormField(
                      initialValue: '',
                      labelText: 'Mahsulot sotuvchisi',
                      validator: (String? p0) {
                        return validator(p0, 'sotuvchisi nomi');
                      },
                      onSaved: (String? p0) {
                        newSeller = p0 ?? '';
                      },
                    ),
                    15.height(),

                    // Product sale type field
                    CustomTextFormField(
                      initialValue: '',
                      labelText:
                          'Mahsulot aksiyasi\n(vergul bilan ajratgan holda, 0-5 son oralig\'ida)',
                      validator: (String? p0) {
                        if (p0 == null ||
                            p0.trim().isEmpty ||
                            checkList(p0) == null) {
                          return 'List ko\'rinishida kiriting!';
                        }
                        return null;
                      },
                      onSaved: (String? p0) {
                        if (p0 != null) {
                          newSaleType = checkList(p0)!;
                        }
                      },
                    ),
                    15.height(),
                    SizedBox(
                      height: 20.h,
                      child: const Divider(),
                    ),

                    // Product description fields
                    for (int i = 0; i < newBrieflyAboutProduct.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: 20.0.w, left: 20.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${i + 1}-tavsif'),
                                if (i == 0 && !canDeleteDescription)
                                  Text(
                                    'Kamida 1 ta tavsif bo\'lishi shart!',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                Row(
                                  children: [
                                    if (i == 0)
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () =>
                                            addBrieflyAboutProduct(),
                                      ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () =>
                                          deleteBrieflyAboutProduct(i),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CustomTextFormField(
                            initialValue: '',
                            labelText: 'Mahsulot tavsifi ${i + 1}',
                            validator: (String? p0) {
                              if (p0 == null || p0.trim().isEmpty || p0 == '') {
                                return 'Mahsulot tavfisini kirting';
                              }
                              return null;
                            },
                            onSaved: (String? newValue) {
                              if (i < newBrieflyAboutProduct.length) {
                                newBrieflyAboutProduct[i] = newValue ?? '';
                              }
                            },
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 50.h,
                      child: const Divider(),
                    ),

                    // Product about field
                    CustomTextFormField(
                      initialValue: '',
                      labelText: 'Mahsulot haqida',
                      validator: (String? p0) {
                        return validator(p0, 'haqida');
                      },
                      onSaved: (String? p0) {
                        newAboutProduct = p0 ?? '';
                      },
                    ),
                    20.height(),
                    CustomTextFormField(
                      initialValue: '',
                      labelText: 'Mahsulot ombordagi soni',
                      validator: (String? p0) {
                        return intValidator(p0, 'ombordagi soni');
                      },
                      onSaved: (String? p0) {
                        if (p0 != null) {
                          leftProduct = int.parse(p0);
                        }else{
                          leftProduct = 0;
                        }
                      },
                    ),
                    20.height(),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              _productViewModel.addNewProduct(
                name: newName,
                price: newPrice,
                category: newCategory,
                images: newImages,
                seller: newSeller,
                leftProduct: leftProduct,
                aboutProduct: newAboutProduct,
                saleType: newSaleType,
                brieflyAboutProduct: newBrieflyAboutProduct,
              );
              debugPrint('object');
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Mahsulot muvaffaqiyatli qo\'shildi!',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Yaxshi.'),
                    )
                  ],
                ),
              );
            }
          },
          child: Container(
            width: double.infinity,
            height: 50.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Text(
                'Saqlash',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
