abstract class INavigateServices {
   Future<void> navigateToPage({String path, Object data});
  Future<void> navigateToPageClear({String path, Object data});
}