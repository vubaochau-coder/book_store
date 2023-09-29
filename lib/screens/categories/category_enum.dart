enum BookSortType { bestSale, descendingCost, ascendingCost }

class CategoryTheme {
  static String convertBookSortType(BookSortType type) {
    switch (type) {
      case BookSortType.bestSale:
        return "Bán chạy nhất";
      case BookSortType.ascendingCost:
        return "Giá tăng dần";
      case BookSortType.descendingCost:
        return "Giá giảm dần";
    }
  }
}
