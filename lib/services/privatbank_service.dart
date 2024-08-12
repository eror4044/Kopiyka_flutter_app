class PrivateBankService {
  final String apiKey;
  final String baseUrl = 'https://api.privatbank.ua/p24api/';

  PrivateBankService(this.apiKey);

  Future fetchTransactions() async {}
}
