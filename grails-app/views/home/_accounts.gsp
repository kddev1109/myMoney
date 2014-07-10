<r:require modules="easygrid-jqgrid-dev,export"/>

<div class="panel panel-default" ng-controller="BankAccountController as bankAccountCtrl">
    <div class="panel-heading">
        <div class="panel-title">
            <h3 class="panel-title">
                <span class="glyphicon glyphicon-usd"></span> <g:message code='myMoney.home.bankAccounts.bankAccounts.heading'/>
            </h3>
        </div>
    </div>

    <div class="panel-body">
        <div class="form-group">
            <div class="col-md-12 text-right">
                <a href="${createLink(controller: 'bankAccount', action: 'newBankAccount')}" class="btn btn-sm btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> <g:message code='myMoney.home.bankAccounts.actions.add'/>
                </a>
            </div>
        </div>
        <br>
        <hr>
        <div class="form-group">
            <div class="col-md-12 text-center">
                <grid:grid id='accountsList' name='accountsList'>
                    <grid:set width="960" caption="Accounts"/>
                </grid:grid>

                <grid:exportButton name='accountsList'/>
            </div>
        </div>
    </div>
</div>