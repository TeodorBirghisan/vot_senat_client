class FormFieldData {
  final String label;
  final String hintText;
  final String dataKey;
  final String? Function(String? value) validator;

  FormFieldData({
    required this.label,
    required this.hintText,
    required this.validator,
    required this.dataKey,
  });
}
