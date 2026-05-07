import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/home/presentation/controller/product_controller.dart';

class AddProductScreen extends StatelessWidget {
  final AddProductModel? product;

  AddProductScreen({super.key, this.product});

  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    if (product != null) controller.setEditData(product!);

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(ImageConstants.bgImage, fit: BoxFit.cover),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: TextWidget(
                    text: product != null ? 'Edit Product' : 'Add Product',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.redColor,
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkWhiteColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: ColorConstants.borderWhiteColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: controller.pickImage,
                            child: Obx(
                                  () => Container(
                                height: 140.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorConstants.transparentColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: ColorConstants.redColor.withOpacity(0.4),
                                    style: BorderStyle.solid,
                                    width: 1.5,
                                  ),
                                ),
                                child: controller.selectedImage.value != null
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.file(
                                    controller.selectedImage.value!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      size: 36.sp,
                                      color: ColorConstants.redColor,
                                    ),
                                    10.0.height,
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Click to upload',
                                            style: TextStyle(
                                              color: ColorConstants.redColor,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' or drag and drop',
                                            style: TextStyle(
                                              color: ColorConstants.lightTextColor,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          20.0.height,

                          TextWidget(
                            text: 'Product Name',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.nameController,
                            hintText: 'Product Name',
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          16.0.height,

                          TextWidget(
                            text: 'Price',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.priceController,
                            hintText: '00.00',
                            keyboardType: TextInputType.number,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 13.h,
                              ),
                              child: TextWidget(
                                text: '₹',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.textColor,
                              ),
                            ),
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          16.0.height,

                          TextWidget(
                            text: 'Unit',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,

                          Obx(
                                () => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: ColorConstants.primaryColor,
                                border: Border.all(
                                  color: ColorConstants.borderColor,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.selectedUnit.value.isEmpty
                                      ? null
                                      : controller.selectedUnit.value,
                                  hint: TextWidget(
                                    text: 'Select Unit',
                                    fontSize: 13.sp,
                                    color: ColorConstants.lightTextColor,
                                  ),
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: ColorConstants.lightTextColor,
                                  ),
                                  items: ['KG', 'G', 'L', 'ML', 'PCS']
                                      .map(
                                        (unit) => DropdownMenuItem(
                                      value: unit,
                                      child: TextWidget(
                                        text: unit,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  )
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      controller.selectedUnit.value = val;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          10.0.height,

                          TextFormFieldWidget(
                            controller: controller.unitValueController,
                            hintText: '500',
                            keyboardType: TextInputType.number,
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 13.h,
                              ),
                              child: Obx(
                                    () => TextWidget(
                                  text: controller.selectedUnit.value.isEmpty
                                      ? 'KG'
                                      : controller.selectedUnit.value,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.lightTextColor,
                                ),
                              ),
                            ),
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          24.0.height,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PrimaryButton(
                                title: 'Cancel',
                                height: 44.h,
                                width: 100.w,
                                buttonColor: Colors.transparent,
                                titleColor: ColorConstants.textColor,
                                customRadius: 30.r,
                                border: BorderSide(
                                  color: ColorConstants.borderColor,
                                ),
                                onPressed: () => Get.back(),
                              ),
                              16.0.width,
                              Obx(
                                    () => PrimaryButton(
                                  isLoading: controller.isSubmitting.value,
                                  title: 'Save',
                                  height: 44.h,
                                  width: 100.w,
                                  buttonColor: ColorConstants.redColor,
                                  titleColor: ColorConstants.primaryColor,
                                  customRadius: 30.r,
                                  onPressed: () {
                                    if (product != null) {
                                      controller.updateProduct(product!.id);
                                    } else {
                                      controller.addProduct();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          10.0.height,
                        ],
                      ),
                    ),
                  ),
                ),
                16.0.height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}