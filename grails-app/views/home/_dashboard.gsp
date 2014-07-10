<%
    def alertsUrl = createLink(controller: 'home', action: 'alerts')
%>
<div class="panel panel-default" ng-controller="AlertController as alertCtrl" ng-init="alertCtrl.initController('${alertsUrl}')">
    <div class="panel-heading">
        <div class="panel-title">
            <h3 class="panel-title">
                <span class="glyphicon glyphicon-bell"></span> <g:message code='myMoney.home.dashboard.alerts.heading'/> <span
                class="badge">{{alertCtrl.alerts.length}}</span>
            </h3>
        </div>
    </div>

    <div class="panel-body">
        <g:render template="alerts"/>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-heading">
        <div class="panel-title">
            <h3 class="panel-title">
                <span class="glyphicon glyphicon-stats"></span> <g:message code='myMoney.home.dashboard.metrics.heading'/>
            </h3>
        </div>
    </div>

    <div class="panel-body"></div>
</div>

<div class="panel panel-default">
    <div class="panel-heading">
        <div class="panel-title">
            <h3 class="panel-title">
                <span class="glyphicon glyphicon-dashboard"></span> <g:message code='myMoney.home.dashboard.visualizations.heading'/>
            </h3>
        </div>
    </div>

    <div class="panel-body"></div>
</div>