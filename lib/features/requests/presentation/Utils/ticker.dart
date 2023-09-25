class Ticker {
  const Ticker();
  Stream tick() {
    return Stream.periodic(
      const Duration(minutes: 1),
      (computationCount) {},
    );
  }
}
