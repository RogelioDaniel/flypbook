import '../models/idiom.dart';

class IdiomsController {
  List<Idiom> _idioms = [];
  int _currentIdiomIndex = 0;

  void loadIdioms() {
    // Simulating loading idioms from a data source
    _idioms = [
      Idiom(
        id: 1,
        phrase: 'A penny for your thoughts',
        meaning: 'Asking someone to share their thoughts or opinions.',
      ),
      Idiom(
        id: 2,
        phrase: 'Bite the bullet',
        meaning: 'To face a difficult or unpleasant situation with courage.',
      ),
      // Add more idioms here
    ];
  }

  Idiom? getCurrentIdiom() {
    if (_currentIdiomIndex < _idioms.length) {
      return _idioms[_currentIdiomIndex];
    }
    return null;
  }

  void showNextIdiom() {
    if (_currentIdiomIndex < _idioms.length - 1) {
      _currentIdiomIndex++;
    } else {
      _currentIdiomIndex = 0;
    }
  }
}
