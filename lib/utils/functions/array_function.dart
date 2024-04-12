bool compareArrays(List<dynamic> arr1, List<dynamic> arr2) {
  // Remove empty strings from arr1 and arr2
  arr1.removeWhere((element) => element == "");
  arr2.removeWhere((element) => element == "");

  // Sort both arrays
  arr1.sort();
  arr2.sort();

  // Compare the sorted arrays
  return arr1.toString() == arr2.toString();
}
