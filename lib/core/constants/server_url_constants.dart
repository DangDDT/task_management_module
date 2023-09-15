class ServerUrlConstants {
  const ServerUrlConstants._();

  static const String getBankOffices = '/bank-offices';
  static const String getBankOfficeById = '/bank-offices/{id}';
  static const String getBankOfficeByRepEmail =
      '/bank-offices/bank-office-by-rep-email';
  static const String getBankOfficeByRepPhone =
      '/bank-offices/bank-office-by-rep-phone';
  static const String postBankOffice = '/bank-offices';
  static const String postBankOfficeRegistrationResponse =
      '/bank-offices/{id}/registration-response';
  static const String getBankOfficeByQuery = '/bank-offices/get-request-by';

  static const String postLoanRequest = '/loan-requests';
  static const String getLoanRequests = '/loan-requests';
  static const String getLoanRequest = '/loan-requests/{id}';

  static const String postLoanResponse = '/loan-requests/{id}/loan-response';

  static const String getDmBanks = '/categories/dm-banks';
  static const String getDmOfficeTypes = '/categories/dm-office-types';
  static const String getDmRegistrationStatuses =
      '/categories/dm-registration-statuses';
  static const String getDmResponseTypes = '/categories/dm-response-types';
  static const String getDmLoanTerm = '/categories/dm-loan-terms';
  static const String getDmLoanTermById = '/categories/dm-loan-terms/{id}';

  static const String getOverallStats =
      '/statistics/loan-requests/overall-stats-by-owners';
  static const String getOverallStat =
      '/statistics/loan-requests/overall-stats';
}
