<%@ page import="grails.converters.JSON" %>
<div class="container-fluid">
    <div class="row" style="max-width: 1200px; margin: 0 auto;">
        <form method="POST" id="newAccountForm" name="newAccountForm" class="form-horizontal" novalidate
              ng-controller="BankAccountController as bankAccountCtrl" ng-init="bankAccountCtrl.initController('${accountTypes as JSON}')">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <span class="glyphicon glyphicon-usd"></span> <g:message code='myMoney.account.newBankAccount.heading'/>
                    </h3>
                </div>

                <div class="panel-body">
                    <div class="form-group">
                        <div class="col-md-5 text-right">
                            <label for="accountNumber" class="control-label">
                                <g:message code='myMoney.account.newBankAccount.accountNumber'/>
                            </label>
                        </div>

                        <div class="col-md-4 text-left">
                            <input type="text" id="accountNumber" name="accountNumber" class="form-control text-right"
                                   ng-model="bankAccountCtrl.accountDetails.accountNumber" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-5 text-right">
                            <label for="dateOpened" class="control-label">
                                <g:message code='myMoney.account.newBankAccount.dateOpened'/>
                            </label>
                        </div>

                        <div class="col-md-3 text-left">
                            <input type="date" id="dateOpened" name="dateOpened" class="form-control"
                                   ng-model="bankAccountCtrl.accountDetails.dateOpened">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-5 text-right">
                            <label for="accountType" class="control-label">
                                <g:message code='myMoney.account.newBankAccount.accountType'/>
                            </label>
                        </div>

                        <div class="col-md-3 text-left">
                            <select id="accountType" name="accountType" class="form-control"
                                    ng-model="bankAccountCtrl.accountDetails.accountType" required>
                                <option ng-selected="true"><g:message code='myMoney.account.newBankAccount.accountType.selectAccountType'/></option>
                                <option ng-repeat="accountType in bankAccountCtrl.accountTypes" value="accountType.id">{{accountType.name}}</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-5 text-right">
                            <label for="accountCurrency" class="control-label">
                                <g:message code='myMoney.account.newBankAccount.currency'/>
                            </label>
                        </div>

                        <div class="col-md-3 text-left">
                            <select id="accountCurrency" name="accountCurrency" class="form-control bfh-currencies"
                                    data-currency="USD" ng-model="bankAccountCtrl.accountDetails.accountCurrency" required>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-5 text-right">
                            <label for="accountBalance" class="control-label">
                                <g:message code='myMoney.account.newBankAccount.accountBalance'/>
                            </label>
                        </div>

                        <div class="col-md-3 text-left">
                            <input type="number" step="any" id="accountBalance" name="accountBalance" class="form-control text-right"
                                   ng-model="bankAccountCtrl.accountDetails.accountBalance" required>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>