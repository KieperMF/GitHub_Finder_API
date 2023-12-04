class Profile{
  String login;
  String avatar;
  String name;
  String location;
  int repos;
  int followers;
  int following;
  String date;
  String bio;

  Profile({
    required this.avatar,
    required this.date,
    required this.followers,
    required this.following,
    required this.location,
    required this.login,
    required this.name,
    required this.repos,
    required this.bio
  });

  factory Profile.fromJson(Map<String, dynamic> json){
    return Profile(
    avatar: json['avatar_url'], 
    date: json['created_at'], 
    followers: json['followers'], 
    following: json['following'], 
    location: json['location'], 
    login: json['login'], 
    name: json['name'], 
    repos: json['public_repos'],
    bio: json['bio']
    );
    
  }
}