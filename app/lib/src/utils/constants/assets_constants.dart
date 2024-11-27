class Asset {
  const Asset();
  
  static final _assets = {
    'images': {
      'flowers': {
        'loginHeader': 'assets/images/flowers/login_header_01.png',
        'registerHeader': 'assets/images/flowers/register_header_01.png',
        'peaceLily': 'assets/images/flowers/peace_lily_01.png',
      },
    },
  };

  static Map<String, dynamic> get images => _assets['images'] as Map<String, dynamic>;
  static Map<String, String> get flowers => images['flowers'] as Map<String, String>;
}
