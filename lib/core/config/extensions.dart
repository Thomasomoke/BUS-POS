extension StringExtension on String {
  String toSentenceCase() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}
