class TransactionFromCsvEntity {
  DateTime transactionDate;
  double withDrawAmount, depositAmount, balanceAmount;
  String narration;

  TransactionFromCsvEntity(this.transactionDate, this.withDrawAmount,
      this.depositAmount, this.balanceAmount, this.narration);

  @override
  String toString() {
    return 'TransactionModal{transactionDate: $transactionDate, withDrawAmount: $withDrawAmount, depositAmount: $depositAmount, balanceAmount: $balanceAmount, narration: $narration}';
  }
}
