class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String createdDate;
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdDate,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id']?.toString() ??
          json['id']?.toString() ??
          '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdDate: json['createdDate']?.toString() ??
          json['createdAt']?.toString() ??
          '',
    );
  }
}