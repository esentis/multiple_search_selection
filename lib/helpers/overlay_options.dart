import 'package:multiple_search_selection/multiple_search_selection.dart';

/// Pass this to the [MultipleSearchSelection.overlay] widget to customize the overlay behavior.
class OverlayOptions {
  /// Whether to close the overlay when the searchfield focus is lost.
  final bool closeOnFocusLost;

  /// Programmatically close the overlay.
  static void Function()? closeOverlay;

  const OverlayOptions({
    this.closeOnFocusLost = true,
  });
}
