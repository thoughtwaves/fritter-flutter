import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _remove;

  TransactionList(this.transactions, this._remove);
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No Transaction',
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * .05,
                    ),
                    Container(
                        height: constraints.maxHeight * .60,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ))
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text('\$${transactions[index].amount}'))),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: mediaQuery.size.width > 400
                        ? FlatButton.icon(
                            icon: Icon(
                              Icons.delete_forever,
                              color: Theme.of(context).errorColor,
                            ),
                            textColor: Theme.of(context).errorColor,
                            label: Text('Delete'),
                            onPressed: () => _remove(transactions[index].id),
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.delete_forever,
                              color: Theme.of(context).errorColor,
                            ),
                            onPressed: () => _remove(transactions[index].id),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
