// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsersWrapper {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Task>? data;
  Support? support;

  UsersWrapper(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.data,
      this.support});

  UsersWrapper.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <Task>[];
      json['data'].forEach((v) {
        data!.add(Task.fromJson(v));
      });
    }
    support =
        json['support'] != null ? Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (support != null) {
      data['support'] = support!.toJson();
    }
    return data;
  }
}

class Task {
  String? id;
  String? email;
  String? firstName;
  String? job;
  String? lastName;
  String? avatar;

  Task({
    this.id,
    this.email,
    this.firstName,
    this.job,
    this.lastName,
    this.avatar,
  });

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, firstName: $firstName, job: $job, lastName: $lastName, avatar: $avatar)';
  }

  Task copyWith({
    String? id,
    String? email,
    String? firstName,
    String? job,
    String? lastName,
    String? avatar,
  }) {
    return Task(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      job: job ?? this.job,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': firstName,
      'job': job,
      'last_name': lastName,
      'avatar': avatar,
    };
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      id: (map['id'] != null ? map['id'].toString() : ''),
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      job: map['job'] != null ? map['job'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['text'] = text;
    return data;
  }
}
