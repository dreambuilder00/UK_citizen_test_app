List<String> getSelectedAnswers(List<bool> states) {
  List<String> selectedAnswers = [];
  for (int i = 0; i < states.length; i++) {
    if (states[i]) {
      selectedAnswers.add(String.fromCharCode(65 + i));
    }
  }
  return selectedAnswers;
}
