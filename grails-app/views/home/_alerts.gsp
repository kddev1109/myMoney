<div class="form-group" ng-show="homeCtrl.alerts.length > 0">
    <div class="col-md-8 text-center">
        <div class="alert" role="alert">
            <strong>{{homeCtrl.currentAlert.heading}}</strong>
            <span ng-hide="homeCtrl.currentAlert.hasLink">{{homeCtrl.currentAlert.body}}</span>
            <span ng-show="homeCtrl.currentAlert.hasLink"><a href="{{homeCtrl.currentAlert.link}}" class="alert-link">{{homeCtrl.currentAlert.body}}</a></span>
        </div>
    </div>

    <div class="col-md-4 text-center" style="padding-top: 10px;">
        <span ng-repeat="action in homeCtrl.currentAlert.actions">
            <button type="button" ng-class="{ '{{action.actionClass}}' : '{{action.actionClass}}' !== null }"
                    ng-click="homeCtrl.processAlertAction(action.text, '${createLink(controller: 'home', action: 'dismissAlert')}')">{{action.text}}</button>
        </span>
    </div>
</div>

<div class="form-group" ng-show="homeCtrl.alerts.length > 0">
    <div class="col-md-6 text-left">
        <button type="button" class="btn btn-default" ng-click="homeCtrl.previousAlert()" ng-disabled="homeCtrl.previousAlertDisabled">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </button>
    </div>

    <div class="col-md-6 text-right">
        <button type="button" class="btn btn-default" ng-click="homeCtrl.nextAlert()" ng-disabled="homeCtrl.nextAlertDisabled">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </button>
    </div>
</div>

<div class="form-group" ng-show="homeCtrl.alerts.length === 0">
    <div class="col-md-12 text-center">
        <g:message code='myMoney.home.dashboard.alerts.noAlerts'/>
    </div>
</div>