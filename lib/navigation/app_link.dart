class AppLink {
  static const String homePath = '/home';
  static const String onboardingPath = '/onboarding';
  static const String loginPath = '/login';
  static const String profilePath = '/profile';
  static const String itemPath = '/item';

  static const String tabParam = 'tab';
  static const String idParam = 'id';

  String? url;

  int? currentTab;

  String? itemId;

  AppLink({
    this.url,
    this.currentTab,
    this.itemId,
  });

  static AppLink fromUrl(String? url) {
    url = Uri.decodeFull(url ?? '');

    final uri = Uri.parse(url);
    final params = uri.queryParameters;
    final currentTab = int.tryParse(params[AppLink.tabParam] ?? '');
    final itemId = params[AppLink.idParam];

    final link = AppLink(url: uri.path, currentTab: currentTab, itemId: itemId);

    return link;
  }

  String toUrl() {
    String addKeyValuePair({
      required String key,
      String? value,
    }) =>
        value == null ? '' : '$key=$value&';

    switch (url) {
      case loginPath:
        return loginPath;
      case onboardingPath:
        return onboardingPath;
      case profilePath:
        return profilePath;
      case itemPath:
        var url = itemPath;
        url += addKeyValuePair(key: idParam, value: itemId);
        return Uri.encodeFull(url);
      default:
        var url = homePath;
        url += addKeyValuePair(key: tabParam, value: currentTab.toString());
        return Uri.encodeFull(url);
    }
  }
}
