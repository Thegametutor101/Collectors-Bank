import 'package:collectors_bank/utils/helpers/helper_functions.dart';

class ImageUris {
  final String small;
  final String normal;
  final String large;
  final String png;
  final String art_crop;
  final String border_crop;

  ImageUris(
      {required this.small,
      required this.normal,
      required this.large,
      required this.png,
      required this.art_crop,
      required this.border_crop});

  static ImageUris fromJson(Map<String, Object?>? json) {
    return ImageUris(
        small: CollectorsBankHelperFunctions.checkIfStringNull(json?["small"]),
        normal:
            CollectorsBankHelperFunctions.checkIfStringNull(json?["normal"]),
        large: CollectorsBankHelperFunctions.checkIfStringNull(json?["large"]),
        png: CollectorsBankHelperFunctions.checkIfStringNull(json?["png"]),
        art_crop:
            CollectorsBankHelperFunctions.checkIfStringNull(json?["art_crop"]),
        border_crop: CollectorsBankHelperFunctions.checkIfStringNull(
            json?["border_crop"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "small": small,
      "normal": normal,
      "large": large,
      "png": png,
      "art_crop": art_crop,
      "border_crop": border_crop
    };
  }
}
