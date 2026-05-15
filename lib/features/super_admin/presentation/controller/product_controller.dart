import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/super_admin/data/model/request_model/add_product_request_model.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/get_product_branch_list_response_model.dart';
import 'package:venu_ghee/features/super_admin/data/repositories/super_admin_repo.dart';

class ProductController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitValueController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxList<ProductModel> productList = <ProductModel>[].obs;
  final RxString selectedUnit = ''.obs;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString selectedImagePath = ''.obs;
  final Rx<Uint8List?> selectedImageBytes = Rx<Uint8List?>(null);

  final SuperAdminRepo _repository = SuperAdminRepo();

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
      final result = await _repository.getProductBranchList();
      productList.value = result.products ?? [];
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (picked != null) {
        selectedImagePath.value = picked.path;
        if (kIsWeb) {
          selectedImageBytes.value = await picked.readAsBytes();
          selectedImage.value = null;
        } else {
          selectedImage.value = File(picked.path);
          selectedImageBytes.value = null;
        }
      }
    } catch (e) {
      ErrorHandler.handleError('Image pick failed: $e');
    }
  }

  void setEditData(ProductModel product) {
    nameController.text = product.name ?? '';
    priceController.text = product.price?.toString() ?? '';
    unitValueController.text = product.weightVolume?.toString() ?? '';
    selectedUnit.value = (product.unitType ?? '').toUpperCase(); // ← bas aa
    selectedImage.value = null;
    selectedImagePath.value = '';
    selectedImageBytes.value = null;
  }

  Future<void> addProduct() async {
    try {
      isSubmitting.value = true;

      final request = AddProductRequestModel(
        name: nameController.text.trim(),
        price: double.tryParse(priceController.text.trim()),
        unitType: selectedUnit.value,
        weightVolume: double.tryParse(unitValueController.text.trim()),
        image: selectedImagePath.value.isNotEmpty
            ? selectedImagePath.value
            : null,
      );

      final result = await _repository.addProduct(
        request: request,
        imageBytes: kIsWeb ? selectedImageBytes.value : null,
      );

      if (result.status == 200 || result.status == 201) {
        _clearForm();
        Get.back();
        CommonSnackBar.success(result.message ?? 'Product added successfully!');
        fetchProducts();
      } else {
        ErrorHandler.handleError(result.message ?? 'Something went wrong');
      }
    } catch (e) {
      print("addProduct error: $e");
      ErrorHandler.handleError('$e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> updateProduct(String id) async {
    try {
      isSubmitting.value = true;

      final request = AddProductRequestModel(
        name: nameController.text.trim(),
        price: double.tryParse(priceController.text.trim()),
        unitType: selectedUnit.value,
        weightVolume: double.tryParse(unitValueController.text.trim()),
        image: selectedImagePath.value.isNotEmpty
            ? selectedImagePath.value
            : null,
      );

      final result = await _repository.updateProduct(
        id: id,
        request: request,
        imageBytes: kIsWeb ? selectedImageBytes.value : null,
      );

      if (result.status == 200 || result.status == 201) {
        _clearForm();
        Get.back();
        CommonSnackBar.success(
            result.message ?? 'Product updated successfully!');
        fetchProducts();
      } else {
        ErrorHandler.handleError(result.message ?? 'Something went wrong');
      }
    } catch (e) {
      print("updateProduct error: $e");
      ErrorHandler.handleError('$e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Delete Product'),
          content:
          const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text(
                'Delete',
                style: TextStyle(color: ColorConstants.redColor),
              ),
            ),
          ],
        ),
      );

      if (confirmed != true) return;

      isLoading.value = true;

      final result = await _repository.deleteProduct(id: id);

      if (result.status == 200 || result.status == 201) {
        CommonSnackBar.success(
            result.message ?? 'Product deleted successfully!');
        fetchProducts();
      } else {
        ErrorHandler.handleError(result.message ?? 'Something went wrong');
      }
    } catch (e) {
      print("deleteProduct error: $e");
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  void _clearForm() {
    nameController.clear();
    priceController.clear();
    unitValueController.clear();
    selectedUnit.value = '';
    selectedImage.value = null;
    selectedImagePath.value = '';
    selectedImageBytes.value = null;
  }
}