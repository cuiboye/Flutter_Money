class DownloadItems {
  static const documents = [
    // DownloadItem(
    //   name: 'Android Programming Cookbook',
    //   url:
    //       'http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf',
    // ),
    DownloadItem(
      name: 'Android Programming Cookbook',
      url:
      'https://image.59cdn.com/wajiucrmtestapk/wajiu_crm_test_update_481.apk',
    ),
    DownloadItem(
      name: 'iOS Programming Guide',
      url:
          'http://englishonlineclub.com/pdf/iOS%20Programming%20-%20The%20Big%20Nerd%20Ranch%20Guide%20(6th%20Edition)%20[EnglishOnlineClub.com].pdf',
    ),
  ];

  static const images = [
    DownloadItem(
      name: 'Arches National Park',
      url:
          'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg',
    ),
    DownloadItem(
      name: 'Canyonlands National Park',
      url:
          // 'https://upload.wikimedia.org/wikipedia/commons/7/78/Canyonlands_National_Park%E2%80%A6Needles_area_%286294480744%29.jpg',
          'http://wajiu-crm-cloud.oss-cn-beijing.aliyuncs.com/apptest/%E4%B8%89%E7%BB%84%E4%BA%A7%E5%93%81%E8%B5%84%E6%96%99/%E6%BE%B3%E5%A4%A7%E5%88%A9%E4%BA%9A%E2%80%94%E2%80%94%E9%82%B5%E6%B0%8F%E9%85%92%E5%BA%84/%E9%82%B5%E6%B0%8F%E5%A5%96%E6%A0%87%E4%BF%A1%E6%81%AF/2010%209N%20shiraz.pdf?Expires=1694748052&OSSAccessKeyId=STS.NTk7gLjYRBNbZvBoa6GvtjzQE&Signature=xxdrhw3YHB6iVEqwMmVy%2BBfPBSA%3D&security-token=CAISswN1q6Ft5B2yfSjIr5fefN34h4Zz9YyJWFDzi2FjS/lYhb/6pzz2IHlMfnJuAe4YsPgzmGlY5/kSlqpwSJwdk45SsAopvPpt6gqET9frWKbXhOV2jf/IMGyXDAGBna22Su7lTdTbV%2B6wYlTf7EFayqf7cjPQJj7CNoaS27pmdcgQVAu1ZiZdfoY0QDFvs8gHL3DcGO%2BwOxrx%2BArqAVFvpxB3hBEKi9e2ydbO7QHF3h%2BoiL0KrobwP92vdcwpN5N4TtvHIoUUG4PF1ClPkTgokI59kK1D/xreo9iZGCM/yh6aMu3SgIUNSQhiffoCBrJjpvrxnuEa3%2BvIjNbYxgpqN%2BNYWDi9PIe725nrFf%2BOPNQ0fqrSMHC3%2BbLpDJTutB4%2Ban82LR5Df8FbSkV9EhsxUDrXWODFtVnBeVWkULPXkvN0g4V8zVT1uNGQIh2ER7KE3WERIocgYlg0cFw0pTW8KvBcLF0QKwk9W%2BbJF9lJAUoA%2Bf%2Byj2r7TTZ9y3xbhfr6as7Nt7oXAYeFBcsei9FDPMoY7Td2Ew2nGu3%2BkCALfW5kXPNdyqyoMpu49bOVQFwfo0t1tJoagAGK01OA4PbZCX9WbW71OjbkJg0%2Bp2lPimRmLHPiWM2JaOyAQ1E5%2B5alsWhlFZY7YUAbB/ZpR6iUfaybkfxxiW3PuR6hCe0bkbJy1%2B9dsELZvmZR1twBBd8eEpnDOOAg1z/0JZ4ypmzLZz7riyprUQMHQp6qneG1xlI/kyIJhIc4OyAA',
    ),
    DownloadItem(
      name: 'Death Valley National Park',
      url:
          'https://upload.wikimedia.org/wikipedia/commons/b/b2/Sand_Dunes_in_Death_Valley_National_Park.jpg',
    ),
    DownloadItem(
      name: 'Gates of the Arctic National Park and Preserve',
      url:
          'https://upload.wikimedia.org/wikipedia/commons/e/e4/GatesofArctic.jpg',
    ),
  ];

  static const videos = [
    DownloadItem(
      name: 'Big Buck Bunny',
      url:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    ),
    DownloadItem(
      name: 'Elephant Dream',
      url:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    ),
  ];

  static const apks = [
    DownloadItem(
      name: 'Spitfire',
      url:
          'https://github.com/bartekpacia/spitfire/releases/download/v1.2.0/spitfire.apk',
    )
  ];
}

class DownloadItem {
  const DownloadItem({required this.name, required this.url});

  final String name;
  final String url;
}
