
class myUser{

  String name, post, address;

  myUser({
    required this.name,
    required this.post,
    required this.address
  });

  Map<String, dynamic> toJson () => {
    'name': name,
    'post': post,
    'address': address
  };

  static myUser fromJson(Map<String, dynamic> data) => 
    myUser(
      address: data['address'],
      name: data['name'],
      post: data['post'],
    );
}