extension Range on num {
  bool isBetween(num from, num to) => from < this && this < to;

  bool isInRange(num from, num to) => from <= this && this <= to;
}
