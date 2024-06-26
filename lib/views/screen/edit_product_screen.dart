import 'package:flutter/material.dart';
import 'package:uzum_market_admin_panel/models/product_model.dart';
import 'package:uzum_market_admin_panel/models/review_model.dart';
import 'package:uzum_market_admin_panel/service/http/review_http_service.dart';
import 'package:uzum_market_admin_panel/utils/extension/sized_box_extension.dart';
import 'package:uzum_market_admin_panel/utils/functions.dart';
import 'package:uzum_market_admin_panel/viewmodel/product_view_model.dart';
import 'package:uzum_market_admin_panel/views/widgets/custom_text_form_field.dart';
import 'package:uzum_market_admin_panel/views/widgets/user_reviews_container.dart';

class ManageProductScreen extends StatefulWidget {
  final Product product;
  final List<Review> productReviews;
  final Function() onProductEdited;

  const ManageProductScreen({
    super.key,
    required this.product,
    required this.productReviews,
    required this.onProductEdited,
  });

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProductViewModel _productViewModel = ProductViewModel();
  final ReviewHttpService _reviewHttpService = ReviewHttpService();

  String newSeller = '', newAboutProduct = '';
  int newPrice = 0, newCategory = 0, newLeftAmount = 0;
  List<String> newName = ['', ''];
  List<int> newSaleType = [];
  late List<String> newImages;
  late List<String> newBrieflyAboutProduct;
  bool canDeleteImage = true;
  bool canDeleteDescription = true;

  @override
  void initState() {
    super.initState();
    newImages = List<String>.from(widget.product.images);
    newBrieflyAboutProduct =
        List<String>.from(widget.product.brieflyAboutProduct);
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

  void onReviewDeleted(String id) {
    widget.productReviews.removeAt(
      widget.productReviews.indexWhere((element) => element.reviewId == id),
    );
    _reviewHttpService.deleteReview(id: id).then((_) => setState(() {}));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('Sharh ma\'lumotlar bazasidan muvaffaqiyatli o\'chirildi!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahsulotni tahrirlash'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, widget.productReviews);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    'Siz haqiqatdan ham ${widget.product.name}ni ma\'lumotlar bazasidan o\'chirmoqchimisiz?',
                    style: const TextStyle(fontSize: 18),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green)
                      ),
                      child: const Text(
                        'Yo\'q',
                        style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await _productViewModel
                            .deleteProduct(widget.product.id);
                        widget.onProductEdited();
                      },
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.red)
                      ),
                      child: const Text(
                        'Ha',
                        style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Column(
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
                      /// text field for product name
                      CustomTextFormField(
                        initialValue: widget.product.name.isNotEmpty
                            ? widget.product.name[0]
                            : '',
                        labelText: 'Mahsulot nomi (uz)',
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
                        initialValue: widget.product.name.length > 1
                            ? widget.product.name[1]
                            : '',
                        labelText: 'Mahsulot nomi (ru)',
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

                      /// text field for product price
                      CustomTextFormField(
                        initialValue: widget.product.price.toString(),
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
                      const SizedBox(
                        height: 20,
                        child: Divider(),
                      ),

                      /// text field for product images
                      for (int i = 0; i < newImages.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20.0, left: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${i + 1}-rasm'),
                                  if (i == 0 && !canDeleteImage)
                                    const Text(
                                      'Kamida 1 ta rasm bo\'lishi shart!',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
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
                              initialValue: newImages[i],
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
                      const SizedBox(
                        height: 50,
                        child: Divider(),
                      ),

                      /// text field for product category
                      CustomTextFormField(
                        initialValue: widget.product.category.toString(),
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

                      /// text field for product seller
                      CustomTextFormField(
                        initialValue: widget.product.seller,
                        labelText: 'Mahsulot sotuvchisi',
                        validator: (String? p0) {
                          return validator(p0, 'sotuvchisi nomi');
                        },
                        onSaved: (String? p0) {
                          newSeller = p0 ?? '';
                        },
                      ),
                      15.height(),

                      /// text field for product sale type
                      CustomTextFormField(
                        initialValue: widget.product.saleType.toString(),
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
                      const SizedBox(
                        height: 20,
                        child: Divider(),
                      ),

                      /// text field for product description
                      for (int i = 0; i < newBrieflyAboutProduct.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20.0, left: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${i + 1}-tavsif'),
                                  if (i == 0 && !canDeleteDescription)
                                    const Text(
                                      'Kamida 1 ta tavsif bo\'lishi shart!',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
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
                              initialValue: newBrieflyAboutProduct[i],
                              labelText: 'Mahsulot tavsifi ${i + 1}',
                              validator: (String? p0) {
                                if (p0 == null ||
                                    p0.trim().isEmpty ||
                                    p0 == '') {
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
                      const SizedBox(
                        height: 50,
                        child: Divider(),
                      ),

                      /// text field for product about
                      CustomTextFormField(
                        initialValue: widget.product.aboutProduct,
                        labelText: 'Mahsulot haqida',
                        validator: (String? p0) {
                          return validator(p0, 'haqida');
                        },
                        onSaved: (String? p0) {
                          newAboutProduct = p0 ?? '';
                        },
                      ),
                      15.height(),
                      CustomTextFormField(
                        initialValue: widget.product.leftProduct.toString(),
                        labelText: 'Mahsulot ombordagi soni',
                        validator: (String? p0) {
                          return intValidator(p0, 'ombordagi soni');
                        },
                        onSaved: (String? p0) {
                          if (p0 != null) {
                            newLeftAmount = int.parse(p0);
                          }
                        },
                      ),
                      10.height(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mahsulot sharhlari',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        widget.productReviews.isNotEmpty
                            ? "Mahsulot sharhlari"
                            : "Ushbu mahsulotga hali sharh qoldirilmagan",
                      ),
                    ],
                  ),
                ),
                if (widget.productReviews.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < widget.productReviews.length; i++)
                          UserReviewsContainer(
                            review: widget.productReviews[i],
                            index: i,
                            onReviewDeleted: onReviewDeleted,
                          ),
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
                _productViewModel.editProduct(
                  id: widget.product.id,
                  name: newName,
                  price: newPrice,
                  category: newCategory,
                  images: newImages,
                  seller: newSeller,
                  orderAmount: widget.product.orderAmount,
                  boughtAmountThisWeek: widget.product.boughtAmountThisWeek,
                  aboutProduct: newAboutProduct,
                  saleType: newSaleType,
                  brieflyAboutProduct: newBrieflyAboutProduct,
                  leftProduct: newLeftAmount,
                );

                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Mahsulot muvaffaqiyatli tahrirlandi!',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
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
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Center(
                child: Text(
                  'Saqlash',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
