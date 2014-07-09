<r:require modules="easygrid-jqgrid-dev,export"/>

<div class="panel panel-default">
    <div class="panel-heading">
        <div class="panel-title">
            <h3 class="panel-title">
                <span class="glyphicon glyphicon-usd"></span> <g:message code='myMoney.home.accounts.accounts.heading'/>
            </h3>
        </div>
    </div>

    <div class="panel-body">
        <div class="form-group">
            <div class="col-md-12 text-right">
                <a href="${createLink(controller: 'account', action: 'newAccount')}" class="btn btn-sm btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> <g:message code='myMoney.home.accounts.actions.add'/>
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