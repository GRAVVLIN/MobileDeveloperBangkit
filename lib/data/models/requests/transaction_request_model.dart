class TransactionRequestModel {
  final String type;
  final String category;
  final String? subCategory;
  final int amount;
  final String? note;
  final int? saving;

  TransactionRequestModel({
    required this.type,
    required this.category,
    this.subCategory,
    required this.amount,
    this.note,
    this.saving,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "category": category,
        "subCategory": subCategory,
        "amount": amount,
        "note": note,
        "saving": saving,
      };
} 