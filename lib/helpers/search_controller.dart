/// This is the controller for the [InfiniteGroupedList].
///
/// Use this controller to :
///
/// 1. Get the items in the list.
/// 2. Retry the last failed load more call.
/// 3. Refresh the list.
class MultipleSearchController<T> {
  /// Call this function to get the items in the list.
  late List<T> Function() getAllItems;

  late List<T> Function() getPickedItems;

  MultipleSearchController() {
    getAllItems = () => []; // initialize with an empty list by default
    getPickedItems = () => [];
  }
}
