enum SearchType { REQUEST, HELP }

class AppState {
  bool loggedIn = false;
  SearchType searchType = SearchType.HELP;
}