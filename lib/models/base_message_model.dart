class BaseMessageModel {
  final String action;

  const BaseMessageModel({required this.action});

  factory BaseMessageModel.fromJson(Map<String, dynamic> json) =>
      BaseMessageModel(action: json['action']);
}