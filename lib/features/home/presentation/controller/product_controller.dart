import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';

class AddProductModel {
  final String id;
  final String name;
  final String weight;
  final String image;
  final String price;

  AddProductModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.image,
    required this.price,
  });
}

class ProductController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitValueController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxList<AddProductModel> productList = <AddProductModel>[].obs;
  final RxString selectedUnit = ''.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    unitValueController.dispose();
    super.onClose();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));

      productList.value = [
        AddProductModel(id: '1', name: 'A2 Cow Pure Desi Ghee', weight: '500g', image: ImageConstants.productIcon, price: '500'),
        AddProductModel(id: '2', name: 'A2 Cow Pure Desi Ghee', weight: '500g', image: ImageConstants.productIcon, price: '500'),
        AddProductModel(id: '3', name: 'A2 Cow Pure Desi Ghee', weight: '500g', image: ImageConstants.productIcon, price: '500'),
        AddProductModel(id: '4', name: 'A2 Cow Pure Desi Ghee', weight: '500g', image: ImageConstants.productIcon, price: '500'),
      ];
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      ErrorHandler.handleError('$e');
    }
  }

  void setEditData(AddProductModel product) {
    nameController.text = product.name;
    priceController.text = product.price;
    unitValueController.text = product.weight.replaceAll(RegExp(r'[^0-9]'), '');
    selectedUnit.value = product.weight.replaceAll(RegExp(r'[0-9]'), '').trim().toUpperCase();
  }

  Future<void> addProduct() async {
    try {
      isSubmitting.value = true;
      await Future.delayed(const Duration(seconds: 1));

      _clearForm();
      Get.back();
      CommonSnackBar.success('Product added successfully!');
      fetchProducts();
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> updateProduct(String id) async {
    try {
      isSubmitting.value = true;
      await Future.delayed(const Duration(seconds: 1));

      _clearForm();
      Get.back();
      CommonSnackBar.success('Product updated successfully!');
      fetchProducts();
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      productList.removeWhere((p) => p.id == id);
      CommonSnackBar.success('Product deleted successfully!');
    } catch (e) {
      ErrorHandler.handleError('$e');
    }
  }

  void _clearForm() {
    nameController.clear();
    priceController.clear();
    unitValueController.clear();
    selectedUnit.value = '';
    selectedImage.value = null;
  }
}