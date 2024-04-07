class ServerResponse {
  dynamic data;

  ServerResponse({
    this.data,
  });

  ServerResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] ?? json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!;
    }
    return data;
  }
}
