List<String> getPriceRanges(double minPrice,double maxPrice) {
  List<String> ranges = [];
  double step = (maxPrice - minPrice) / 5;
  for (int i = 1; i <= 5; i++) {
    double price = minPrice + (step * i);
    ranges.add('KES ${price.toInt()}');
  }
  return ranges;
}
