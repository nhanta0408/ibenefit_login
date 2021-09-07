class Data {
  String? deviceCode;
  String? userId;
  String? agent;
  String? id;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.deviceCode,
      this.userId,
      this.agent,
      this.id,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    deviceCode = json['device_code'] ?? "";
    userId = json['user_id'] ?? "";
    agent = json['agent'] ?? "";
    id = json['id'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    createdAt = json['created_at'] ?? "";
  }
}
