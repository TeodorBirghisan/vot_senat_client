class FormValidators {
  static String? notEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }

    return null;
  }
}
