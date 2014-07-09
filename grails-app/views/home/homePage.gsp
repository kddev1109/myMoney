<%@ page contentType="text/html;charset=UTF-8" %>
<html ng-app="myMoney">
<head>
    <meta name="layout" content="main"/>
</head>

<body>
<div class="container-fluid">
    <%
        def alertsUrl = createLink(controller: 'home', action: 'alerts')
    %>
    <form method="POST" id="homeForm" name="homeForm" class="form-horizontalr" autocomplete="off" novalidate
          ng-controller="HomeController as homeCtrl" ng-init="homeCtrl.initHome('${alertsUrl}', '${activeSubNav}')">
        <div class="row" style="max-width: 1600px; margin: 10px auto;">
            <div class="col-md-3 text-left">
                <div class="col-md-8 panel panel-default">
                    <div class="panel-body">
                        <ul class="nav nav-pills nav-stacked">
                            <li ng-class="{ 'active' : homeCtrl.isActiveSubNav('Dashboard') }" ng-click="mainCtrl.setActiveSubNav('Dashboard')">
                                <a href="${createLink(controller: 'home', action: 'index')}">
                                    <span class="glyphicon glyphicon-th-large"></span> <g:message code='myMoney.home.nav.dashboard'/>
                                </a>
                            </li>
                            <li ng-class="{ 'active' : homeCtrl.isActiveSubNav('Accounts') }" ng-click="mainCtrl.setActiveSubNav('Accounts')">
                                <a href="${createLink(controller: 'home', action: 'accounts')}">
                                    <span class="glyphicon glyphicon-usd"></span> <g:message code='myMoney.home.nav.accounts'/>
                                </a>
                            </li>
                            <li ng-class="{ 'active' : homeCtrl.isActiveSubNav('Cards') }" ng-click="mainCtrl.setActiveSubNav('Cards')">
                                <a href="#">
                                    <span class="glyphicon glyphicon-credit-card"></span> <g:message code='myMoney.home.nav.cards'/>
                                </a>
                            </li>
                            <li ng-class="{ 'active' : homeCtrl.isActiveSubNav('Transactions') }" ng-click="mainCtrl.setActiveSubNav('Transactions')">
                                <a href="#">
                                    <span class="glyphicon glyphicon-transfer"></span> <g:message code='myMoney.home.nav.transactions'/>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-md-9 text-left">
                <g:if test="${template}">
                    <g:render template="${template}"/>
                </g:if>
            </div>
        </div>
    </form>
</div>
</body>
</html>