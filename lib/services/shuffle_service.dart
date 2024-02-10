import 'dart:math';

class ShuffleService {
  Random _random = Random();

  void seed(int seed) {
    // Only seed the random number generator the seed is not 0
    if (seed == 0) {
      return;
    }
    _random = Random(seed);
  }

  List<T> shuffle<T>(List<T> array) {
    // Creates a copy of the array to avoid modifying the original array
    List<T> shuffledArray = List<T>.from(array);

    for (int i = shuffledArray.length - 1; i > 0; i--) {
      int n = _random.nextInt(i + 1);
      T temp = shuffledArray[i];
      shuffledArray[i] = shuffledArray[n];
      shuffledArray[n] = temp;
    }

    return shuffledArray;
  }
}
