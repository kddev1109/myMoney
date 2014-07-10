<div class="form-group" ng-show="alertCtrl.alerts.length > 0">
    <div class="col-md-8 text-center">
        <div class="alert" role="alert">
            <strong>{{alertCtrl.currentAlert.heading}}</strong>
            <span ng-hide="alertCtrl.currentAlert.hasLink">{{alertCtrl.currentAlert.body}}</span>
            <span ng-show="alertCtrl.currentAlert.hasLink"><a href="{{alertCtrl.currentAlert.link}}" class="alert-link">{{alertCtrl.currentAlert.body}}</a></span>
        </div>
    </div>

    <div class="col-md-4 text-center" style="padding-top: 10px;">
        <span ng-repeat="action in alertCtrl.currentAlert.actions">
            <button type="button" ng-class="{ '{{action.actionClass}}' : '{{action.actionClass}}' !== null }"
                    ng-click="alertCtrl.processAlertAction(action.text, '${createLink(controller: 'home', action: 'dismissAlert')}')">{{action.text}}</button>
        </span>
    </div>
</div>

<div class="form-group" ng-show="alertCtrl.alerts.length > 0">
    <div class="col-md-6 text-left">
        <button type="button" class="btn btn-default" ng-click="alertCtrl.previousAlert()" ng-disabled="alertCtrl.previousAlertDisabled">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </button>
    </div>

    <div class="col-md-6 text-right">
        <button type="button" class="btn btn-default" ng-click="alertCtrl.nextAlert()" ng-disabled="alertCtrl.nextAlertDisabled">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </button>
    </div>
</div>

<div class="form-group" ng-show="alertCtrl.alerts.length === 0">
    <div class="col-md-12 text-center">
        <g:message code='myMoney.home.dashboard.alerts.noAlerts'/>
    </div>
</div>