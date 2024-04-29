class CategoryModel {
  final String? categoryId;
  final String? categoryName;
  final String? categoryImage;
  final List<QuoteModel>? quoteList;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.quoteList,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map["category_id"],
      categoryName: map["category_name"],
      categoryImage: map["category_image"],
        quoteList: List.from(map['quotes'])
            .map((e) => QuoteModel.fromMap(e))
            .toList()
    );
  }
}

class QuoteModel {
  final String? quoteId;
  final String? quote;

  QuoteModel({required this.quoteId, required this.quote});

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      quoteId: map["quote_id"],
      quote: map["quote"],
    );
  }
}