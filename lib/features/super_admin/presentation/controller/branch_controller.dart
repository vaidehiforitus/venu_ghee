import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/super_admin/data/model/request_model/add_new_branch_request_model.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/get_branch_details_response_model.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/get_product_branch_list_response_model.dart';
import 'package:venu_ghee/features/super_admin/data/repositories/super_admin_repo.dart';
import 'package:venu_ghee/routes/app_routes.dart';

class BranchController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNoController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxBool isActive = true.obs;

  final RxList<Branches> branchList = <Branches>[].obs;

  final RxList<ProductModel> productList = <ProductModel>[].obs;
  final RxList<int> quantities = <int>[].obs;

  // Store selected branch image path
  final RxString selectedImagePath = ''.obs;

  final SuperAdminRepo _repository = SuperAdminRepo();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

  // ─── FETCH ───────────────────────────────────────────────────────────────────

  Future<void> fetchBranches() async {
    try {
      isLoading.value = true;
      final result = await _repository.getBranchDetails();
      branchList.value = result;
    } catch (e) {
      print("errorr---$e");
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── SET EDIT DATA ────────────────────────────────────────────────────────────

  void setEditData(Branches branch) {
    nameController.text = branch.branchName ?? '';   // name → branchName
    ownerController.text = branch.ownerName ?? '';
    phoneController.text = branch.mobileNumber ?? ''; // number → mobileNumber
    emailController.text = branch.email ?? '';
    addressController.text = branch.address ?? '';   // location → address
    bankNameController.text = branch.bankName ?? '';
    accountNoController.text = branch.accountNumber ?? '';
    ifscController.text = branch.ifscCode ?? '';
    isActive.value = branch.isOpen ?? true;
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
      }
    } catch (e) {
      ErrorHandler.handleError('Image pick failed: $e');
    }
  }

// Validation method add karo:
  bool validateBranchForm() {
    if (selectedImagePath.value.isEmpty) {
      CommonSnackBar.error('Please upload a branch image');
      return false;
    }
    return formKey.currentState?.validate() ?? false;
  }
  Future<void> addBranch() async {
    try {
      isSubmitting.value = true;

      final request = AddNewBranchRequestModel(
        image: selectedImagePath.value.isNotEmpty ? selectedImagePath.value : null,
        branchName: nameController.text.trim(),
        address: addressController.text.trim(),
        state: stateController.text.trim(),
        zipCode: int.tryParse(zipController.text.trim()),
        mobileNumber: phoneController.text.trim(),
        ownerName: ownerController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        accountNumber: accountNoController.text.trim(),
        ifscCode: ifscController.text.trim(),
        bankName: bankNameController.text.trim(),
        // initialStocks are added in saveBranchWithProducts()
      );

      final result = await _repository.addNewBranch(request: request);

      if (result.status == 200 || result.status == 201) {
        _clearForm();
        Get.back();
        CommonSnackBar.success(result.message ?? 'Branch added successfully!');
        fetchBranches();
      } else {
        ErrorHandler.handleError(result.message ?? 'Something went wrong');
      }
    } catch (e) {
      print("DDDDerrorr---$e");
      ErrorHandler.handleError('$e');
    } finally {
      isSubmitting.value = false;
    }
  }

  // ─── EDIT BRANCH ──────────────────────────────────────────────────────────────

  Future<void> updateBranch(int? id) async {
    if (id == null) {
      ErrorHandler.handleError('Branch ID is missing');
      return;
    }
    try {
      isSubmitting.value = true;

      final result = await _repository.editBranch(id: id.toString());

      if (result.status == 200 || result.status == 201) {
        _clearForm();
        Get.back();
        CommonSnackBar.success(result.message ?? 'Branch updated successfully!');
        fetchBranches();
      } else {
        ErrorHandler.handleError(result.message ?? 'Something went wrong');
      }
    } catch (e) {
      print("updateerrorr---$e");

      ErrorHandler.handleError('$e');
    } finally {
      isSubmitting.value = false;
    }
  }

  // ─── DELETE BRANCH ────────────────────────────────────────────────────────────

  Future<void> deleteBranch(int? id) async {
    if (id == null) {
      ErrorHandler.handleError('Branch ID is missing');
      return;
    }
    try {
      // Show confirmation dialog first
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Delete Branch'),
          content: const Text('Are you sure you want to delete this branch?'),
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

      final result = await _repository.deleteBranch(id: id.toString());

      if (result.status == 200 || result.status == 201) {
        CommonSnackBar.success(result.message ?? 'Branch deleted successfully!');
        fetchBranches();
      } else {
        ErrorHandler.handleError(result.message ?? 'Something went wrong');
      }
    } catch (e) {
      print("deleeterrorr---$e");

      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── PRODUCTS ─────────────────────────────────────────────────────────────────

  Future<void> fetchProducts() async {
    try {
      final result = await _repository.getProductBranchList();

      productList.value = (result.products ?? []).map((e) => ProductModel(
        id: e.id,                          // int? — direct use
        name: e.name,
        price: e.price,
        unitType: e.unitType,
        weightVolume: e.weightVolume,
        image: e.image,
      )).toList();

      quantities.value = List.filled(productList.length, 1);
    } catch (e) {
      print("producterrorr---$e");

      ErrorHandler.handleError('$e');
    }
  }

  void incrementQty(int index) => quantities[index]++;

  void decrementQty(int index) {
    if (quantities[index] > 0) quantities[index]--;
  }

  // ─── SAVE BRANCH WITH PRODUCTS ────────────────────────────────────────────────

  Future<void> saveBranchWithProducts() async {
    try {
      isSubmitting.value = true;

      // Build initial stocks from product list + quantities
      final stocks = productList.asMap().entries.map((entry) {
        return InitialStocks(
          productId: entry.value.id,
          quantity: quantities[entry.key],
        );
      }).toList();

      final request = AddNewBranchRequestModel(
        image: selectedImagePath.value.isNotEmpty ? selectedImagePath.value : null,
        branchName: nameController.text.trim(),
        address: addressController.text.trim(),
        state: stateController.text.trim(),
        zipCode: int.tryParse(zipController.text.trim()),
        mobileNumber: phoneController.text.trim(),
        ownerName: ownerController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        accountNumber: accountNoController.text.trim(),
        ifscCode: ifscController.text.trim(),
        bankName: bankNameController.text.trim(),
        initialStocks: stocks,
      );

      final result = await _repository.addNewBranch(request: request);

      if (result.status == 200 || result.status == 201) {
        _clearForm();
        Get.offAllNamed(AppRoutes.bottomNavigationBarWidget);
        CommonSnackBar.success(result.message ?? 'Branch added successfully!');
      } else {
        ErrorHandler.handleError(result.message ?? 'Something went wrong');
      }
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isSubmitting.value = false;
    }
  }

  // ─── HELPERS ──────────────────────────────────────────────────────────────────

  void _clearForm() {
    nameController.clear();
    ownerController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    stateController.clear();
    zipController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    bankNameController.clear();
    accountNoController.clear();
    ifscController.clear();
    selectedImagePath.value = '';
    isActive.value = true;
  }
}