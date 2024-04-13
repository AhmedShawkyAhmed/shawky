import 'package:shawky/core/database/firebase_database.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/money/accounts/data/models/account_model.dart';

class AccountsDatabase {
  static const _accountCollection = "accounts";
  static final _firestore = FirebaseDatabase.firestore;

  static Future<List<AccountModel>> getAccounts() async {
    List<AccountModel> accounts = [];
    await _firestore.collection(_accountCollection).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          accounts.add(
            AccountModel(
              id: docSnapshot.id,
              name: docSnapshot.data()["name"],
              amount: docSnapshot.data()["amount"],
              rate: docSnapshot.data()["rate"],
              accountType: AccountTypes.values
                  .where(
                      (element) => element.name == docSnapshot.data()["type"])
                  .first,
              currency: Currency.values
                  .where((element) =>
                      element.name == docSnapshot.data()["currency"])
                  .first,
              updatedAt: docSnapshot.data()["updatedAt"],
            ),
          );
        }
      },
      onError: (e) => printError("Error completing: $e"),
    );
    return accounts;
  }

  static Future<void> addAccount(AccountModel accountModel) async {
    _firestore
        .collection(_accountCollection)
        .add(accountModel.toFirestore())
        .then(
          (documentSnapshot) =>
              printSuccess("Added Data with ID: ${documentSnapshot.id}"),
          onError: (e) => printError("Error Deleting Account $e"),
        );
  }

  static Future<void> updateAccount(AccountModel accountModel) async {
    final docRef = _firestore
        .collection(_accountCollection)
        .withConverter(
          fromFirestore: AccountModel.fromFirestore,
          toFirestore: (AccountModel accountModel, options) =>
              accountModel.toFirestore(),
        )
        .doc(accountModel.id);
    await docRef.set(accountModel);
  }

  static Future<void> deleteAccount(String accountId) async {
    _firestore.collection(_accountCollection).doc(accountId).delete().then(
          (doc) => printSuccess("Account Deleted Successfully"),
          onError: (e) => printError("Error Deleting Account $e"),
        );
  }
}
