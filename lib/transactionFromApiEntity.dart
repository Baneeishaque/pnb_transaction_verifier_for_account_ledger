class TransactionFromApiEntity {
  String id;
  String eventDateTime;
  String particulars;
  String amount;
  String insertionDateTime;
  String fromAccountName;
  String fromAccountFullName;
  String fromAccountId;
  String toAccountName;
  String toAccountFullName;
  String toAccountId;

  TransactionFromApiEntity(
      {this.id,
      this.eventDateTime,
      this.particulars,
      this.amount,
      this.insertionDateTime,
      this.fromAccountName,
      this.fromAccountFullName,
      this.fromAccountId,
      this.toAccountName,
      this.toAccountFullName,
      this.toAccountId});

  TransactionFromApiEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventDateTime = json['event_date_time'];
    particulars = json['particulars'];
    amount = json['amount'];
    insertionDateTime = json['insertion_date_time'];
    fromAccountName = json['from_account_name'];
    fromAccountFullName = json['from_account_full_name'];
    fromAccountId = json['from_account_id'];
    toAccountName = json['to_account_name'];
    toAccountFullName = json['to_account_full_name'];
    toAccountId = json['to_account_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_date_time'] = this.eventDateTime;
    data['particulars'] = this.particulars;
    data['amount'] = this.amount;
    data['insertion_date_time'] = this.insertionDateTime;
    data['from_account_name'] = this.fromAccountName;
    data['from_account_full_name'] = this.fromAccountFullName;
    data['from_account_id'] = this.fromAccountId;
    data['to_account_name'] = this.toAccountName;
    data['to_account_full_name'] = this.toAccountFullName;
    data['to_account_id'] = this.toAccountId;
    return data;
  }

  @override
  String toString() {
    return 'TransactionFromApiEntity{id: $id, eventDateTime: $eventDateTime, particulars: $particulars, amount: $amount, insertionDateTime: $insertionDateTime, fromAccountName: $fromAccountName, fromAccountFullName: $fromAccountFullName, fromAccountId: $fromAccountId, toAccountName: $toAccountName, toAccountFullName: $toAccountFullName, toAccountId: $toAccountId}';
  }
}
