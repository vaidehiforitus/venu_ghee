import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
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
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      ErrorHandler.handleError('$e');
    }
  }

  void setEditData(ProductModel product) {
    nameController.text = product.name ?? '';
    priceController.text = product.price?.toString() ?? '';

    unitValueController.text = product.weightVolume?.toString() ?? '';
    selectedUnit.value = product.unitType ?? '';
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