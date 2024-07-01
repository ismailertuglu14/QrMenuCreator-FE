// ignore_for_file: use_build_context_synchronously

part of '../view/category_view.dart';

abstract class CategoryViewModel extends State<CategoryView> {
  late final CategoryService _categoryService;
  late final CategoryProvider _categoryProvider;
  late final ImagePicker _picker;

  String? _selectedSection;

  @override
  void initState() {
    super.initState();

    _categoryProvider = CategoryProvider.instance;
    _categoryService = CategoryService(NetworkManager.instance.dio);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCategories();
    });
    _picker = ImagePicker();
  }

  Future<void> getCategories() async {
    try {
      _categoryProvider.changeLoading();

      GetCategoriesResponseModel response =
          await _categoryService.getCategories(
              requestModel: GetCategoriesRequestModel(menuId: widget.id ?? ""));
      if (response.isSuccess && response.errors.isEmpty) {
        _categoryProvider.setCategoryList = response.data;
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      _categoryProvider.changeLoading();
    }
  }

  Future<void> relocateCategory(
      {required String categoryId, required int newPosition}) async {
    try {
      RelocateCategoryResponseModel response =
          await _categoryService.relocateCategory(
              requestModel: RelocateCategoryRequestModel(
                  categoryId: categoryId, newPosition: newPosition));
      if (response.isSuccess && response.errors.isEmpty) {
        Fluttertoast.showToast(msg: "Category relocated");
      } else {
        Fluttertoast.showToast(msg: response.errors[0].message);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteCategory() async {
    try {
      _categoryProvider.changeLoading();
      DeleteCategoryResponseModel response =
          await _categoryService.deleteCategory(
              requestModel: DeleteCategoryRequestModel(
                  categoryId: _categoryProvider.selectedCategoryId ?? ""));
      if (response.isSuccess && response.errors.isEmpty) {
        _categoryProvider
            .removeCategory(_categoryProvider.selectedCategoryId ?? "");
      } else {
        Fluttertoast.showToast(msg: response.errors[0].message);
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      _categoryProvider.changeLoading();
    }
  }

  Future<void> createCategory() async {
    if (_categoryProvider.categoryController.text.isNotEmpty) {
      try {
        _categoryProvider.changeLoading();
        CreateCategoryResponseModel response =
            await _categoryService.createCategory(
                menuId: widget.id ?? "",
                name: _categoryProvider.categoryController.text,
                image: _categoryProvider.categoryImage as XFile);
        if (response.isSuccess && response.errors.isEmpty) {
          context.pop();
          _categoryProvider.addCategory(
            GetCategoriesData(
                id: response.data.id,
                name: response.data.name,
                image: response.data.image,
                productCount: 0),
          );
          _categoryProvider.categoryController.clear();
          _categoryProvider.setCategoryImage = null;
          _categoryProvider.setSelectedSuggestionIndex = null;
        } else {
          Fluttertoast.showToast(msg: response.errors[0].message);
        }
      } catch (e) {
        throw Exception(e);
      } finally {
        _categoryProvider.changeLoading();
      }
    } else {
      Fluttertoast.showToast(msg: "Please enter a section name");
    }
  }

  Future<void> uploadFile({required Object fileObject}) async {
    try {
      _categoryProvider.changeLoading();
      fileObject as XFile;

      _categoryProvider.setCategoryImage = fileObject;
    } catch (e) {
      throw Exception(e);
    } finally {
      _categoryProvider.changeLoading();
    }
  }
}
