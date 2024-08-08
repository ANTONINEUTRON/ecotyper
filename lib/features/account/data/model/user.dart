import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ecotyper/features/account/data/model/user_meta.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  @JsonSerializable(anyMap: true, explicitToJson: true)
  factory User({
    required String id,
    required String email,
    required String name,
    @Default(false) bool isVerified,
    @Default("") String displayPics,
    UserMeta? userMeta,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
