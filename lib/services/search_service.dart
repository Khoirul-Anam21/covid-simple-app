
///[searchValue] untuk input pencarian
///[data] untuk dataset
bool searchCountry(String searchValue, String data) {
    List<String> searchValueChars = searchValue.split('');
    List<String> dataChars = data.split('');
    int searchIterator = 0;
    for (int dataIterator = 0;
        dataIterator < dataChars.length;
        dataIterator++) {
      if (dataChars[dataIterator] == searchValueChars[searchIterator]) {
        searchIterator++;
      } else {
        searchIterator = 0;
      }

      if (searchIterator == searchValueChars.length) {
        return true;
      }
    }
    return false;
  }
