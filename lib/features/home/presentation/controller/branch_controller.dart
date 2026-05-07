import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/home/presentation/screens/branch/branch_add_product_screen.dart';
import 'package:venu_ghee/routes/app_routes.dart';

class BranchModel {
  final String id;
  final String name;
  final String ownerName;
  final String phone;
  final bool isActive;

  BranchModel({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.phone,
    required this.isActive,
  });
}

class BranchController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxBool isActive = true.obs;
  final RxList<BranchModel> branchList = <BranchModel>[].obs;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNoController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();



  final RxList<ProductModel> productList = <ProductModel>[].obs;
  final RxList<int> quantities = <int>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchBranches();
    fetchProducts();
  }

  @override
  void onClose() {
    nameController.dispose();
    ownerController.dispose();
    phoneController.dispose();
    addressController.dispose();
    stateController.dispose();
    zipController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    bankNameController.dispose();
    accountNoController.dispose();
    ifscController.dispose();
    super.onClose();
  }


  Future<void> fetchBranches() async {
    try {
      isLoading.value = true;

      // TODO: API call
      await Future.delayed(const Duration(seconds: 1));

      // Demo data
      branchList.value = [
        BranchModel(id: '1', name: 'Venu Ghee (Katargam)', ownerName: 'Chaman Bhai', phone: '+91 12345 69854', isActive: true),
        BranchModel(id: '2', name: 'Venu Ghee (Katargam)', ownerName: 'Chaman Bhai', phone: '+91 12345 69854', isActive: false),
        BranchModel(id: '3', name: 'Venu Ghee (Katargam)', ownerName: 'Chaman Bhai', phone: '+91 12345 69854', isActive: true),
        BranchModel(id: '4', name: 'Venu Ghee (Katargam)', ownerName: 'Chaman Bhai', phone: '+91 12345 69854', isActive: false),
        BranchModel(id: '5', name: 'Venu Ghee (Katargam)', ownerName: 'Chaman Bhai', phone: '+91 12345 69854', isActive: true),
      ];
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  void setEditData(BranchModel branch) {
    nameController.text = branch.name;
    ownerController.text = branch.ownerName;
    phoneController.text = branch.phone;
    isActive.value = branch.isActive;
  }

  Future<void> addBranch() async {
    try {
      isSubmitting.value = true;

      // TODO: API call
      await Future.delayed(const Duration(seconds: 1));

      _clearForm();
      Get.back();
      CommonSnackBar.success('Branch added successfully!');
      fetchBranches();
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> updateBranch(String id) async {
    try {
      isSubmitting.value = true;

      // TODO: API call
      await Future.delayed(const Duration(seconds: 1));

      _clearForm();
      Get.back();
      CommonSnackBar.success('Branch updated successfully!');
      fetchBranches();
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isSubmitting.value = false;
    }
  }


  // Fetch Products
  Future<void> fetchProducts() async {
    try {
      // TODO: API call
      productList.value = [
        ProductModel(id: '1', name: 'A2 Cow Pure Desi Ghee', weight: '1 kg.', image: ImageConstants.dashboardIcon),
        ProductModel(id: '2', name: 'Buffalo Pure Desi Ghee', weight: '1 kg.', image: ImageConstants.dashboardIcon),
        ProductModel(id: '3', name: 'A2 Cow Pure Desi Ghee', weight: '1 kg.', image: ImageConstants.dashboardIcon),
        ProductModel(id: '4', name: 'Buffalo Pure Desi Ghee', weight: '1 kg.', image: ImageConstants.dashboardIcon),
      ];
      quantities.value = List.filled(productList.length, 1);
    } catch (e) {
      ErrorHandler.handleError('$e');
    }
  }

// Increment Qty
  void incrementQty(int index) {
    quantities[index]++;
  }

// Decrement Qty
  void decrementQty(int index) {
    if (quantities[index] > 0) {
      quantities[index]--;
    }
  }

// Save Branch with Products
  Future<void> saveBranchWithProducts() async {
    try {
      isSubmitting.value = true;

      // TODO: API call
      await Future.delayed(const Duration(seconds: 1));

      _clearForm();
      Get.offAllNamed(AppRoutes.bottomNavigationBarWidget);
      CommonSnackBar.success('Branch added successfully!');
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isSubmitting.value = false;
    }
  }
  void _clearForm() {
    nameController.clear();
    ownerController.clear();
    phoneController.clear();
    isActive.value = true;
  }
}