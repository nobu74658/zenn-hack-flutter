import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';
part 'media.g.dart';

/// Media domain entity representing generated media files
@freezed
class Media with _$Media {
  const factory Media({
    /// Unique media identifier
    required String mediaId,

    /// Associated meaning identifier
    required String meaningId,

    /// List of media URLs
    required List<String> mediaUrls,
  }) = _Media;

  factory Media.fromJson(Map<String, Object?> json) => _$MediaFromJson(json);
}
