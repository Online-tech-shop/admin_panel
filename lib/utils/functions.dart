import 'dart:convert';

String? intValidator(String? p0, String validatorText) {
  if (p0 == null || p0.trim().isEmpty || !(int.tryParse(p0) != null)) {
    return validatorText;
  }
  return null;
}

List<int>? checkList(String str) {
  try {
    var decoded = jsonDecode(str);
    return List<int>.from(decoded);
  } catch (e) {
    return null;
  }
}

String? validator(String? value, String validatorText) {
  if (value == null || value.trim().isEmpty) {
    return 'Mahsulot ${validatorText}ni kiriting.';
  }
  return null;
}
