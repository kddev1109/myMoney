<div class="row" style="max-width: 800px; margin: 5px auto;">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><span class="glyphicon glyphicon-envelope"></span> <g:message code='myMoney.profile.contactInformation.heading'/></h3>
        </div>

        <div class="panel-body">
            <div class="form-group" ng-repeat="contactInformationProperty in profileCtrl.profileDetailsProperties.contactInformation">
                <div class="col-md-4 text-right">
                    <label class="property-label">{{contactInformationProperty.key}}</label>
                </div>

                <div class="col-md-6" ng-hide="profileCtrl.editMode.contactInformation">
                    {{contactInformationProperty.value}}
                </div>

                <div class="col-md-6"
                     ng-show="profileCtrl.editMode.contactInformation">
                    <input type="{{contactInformationProperty.type}}" name="{{contactInformation.key}}" class="form-control"
                           ng-model="contactInformationProperty.value">
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-12 text-center" ng-hide="profileCtrl.editMode.contactInformation">
                    <button type="button" class="btn btn-default" ng-click="profileCtrl.editContactInformation()">
                        <span class="glyphicon glyphicon-pencil"></span> <g:message code='myMoney.profile.contactInformation.actions.edit'/>
                    </button>
                </div>

                <div class="col-md-12 text-center" ng-show="profileCtrl.editMode.contactInformation">
                    <button type="button" class="btn btn-primary" ng-click="profileCtrl.saveContactInformation()">
                        <span class="glyphicon glyphicon-hdd"></span> <g:message code='myMoney.profile.contactInformation.actions.save'/>
                    </button>
                    <button type="button" class="btn btn-default" ng-click="profileCtrl.cancelContactInformation()">
                        <span class="glyphicon glyphicon-remove"></span> <g:message code='myMoney.profile.contactInformation.actions.cancel'/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>