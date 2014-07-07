<div class="row" style="max-width: 800px; margin: 5px auto;">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><span class="glyphicon glyphicon-user"></span> <g:message code='myMoney.profile.individualUserInformation.heading'/></h3>
        </div>

        <div class="panel-body">
            <div class="form-group" ng-repeat="individualUserInformationProperty in profileCtrl.profileDetailsProperties.individualUserInformation">
                <div class="col-md-4 text-right">
                    <label class="property-label">{{individualUserInformationProperty.key}}</label>
                </div>

                <div class="col-md-6" ng-hide="profileCtrl.editMode.individualUserInformation">
                    {{individualUserInformationProperty.value}}
                </div>

                <div class="col-md-6"
                     ng-show="profileCtrl.editMode.individualUserInformation && individualUserInformationProperty.type === 'btn-group'">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" id="male" name="gender"
                                ng-click="profileCtrl.setGender('Male')" ng-class="{ 'active': profileCtrl.isMale() }">
                            <g:message code='myMoney.profile.individualUserInformation.gender.male'/>
                        </button>
                        <button type="button" class="btn btn-default" id="female" name="gender"
                                ng-click="profileCtrl.setGender('Female')" ng-class="{ 'active': profileCtrl.isFemale() }">
                            <g:message code='myMoney.profile.individualUserInformation.gender.female'/>
                        </button>
                    </div>
                </div>

                <div class="col-md-6"
                     ng-show="profileCtrl.editMode.individualUserInformation && individualUserInformationProperty.type !== 'btn-group' &&
                              individualUserInformation.required === 'true'">
                    <input type="{{individualUserInformationProperty.type}}" name="{{individualUserInformation.key}}" class="form-control"
                           ng-model="individualUserInformationProperty.value" required>
                </div>

                <div class="col-md-6"
                     ng-show="profileCtrl.editMode.individualUserInformation && individualUserInformationProperty.type !== 'btn-group' &&
                              individualUserInformation.required !== 'true'">
                    <input type="{{individualUserInformationProperty.type}}" name="{{individualUserInformation.key}}" class="form-control"
                           ng-model="individualUserInformationProperty.value">
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-12 text-center" ng-hide="profileCtrl.editMode.individualUserInformation">
                    <button type="button" class="btn btn-default" ng-click="profileCtrl.editIndividualUserInformation()">
                        <span class="glyphicon glyphicon-pencil"></span> <g:message code='myMoney.profile.individualUserInformation.actions.edit'/>
                    </button>
                </div>

                <div class="col-md-12 text-center" ng-show="profileCtrl.editMode.individualUserInformation">
                    <button type="button" class="btn btn-primary" ng-click="profileCtrl.saveIndividualUserInformation()">
                        <span class="glyphicon glyphicon-hdd"></span> <g:message code='myMoney.profile.individualUserInformation.actions.save'/>
                    </button>
                    <button type="button" class="btn btn-default" ng-click="profileCtrl.cancelIndividualUserInformation()">
                        <span class="glyphicon glyphicon-remove"></span> <g:message code='myMoney.profile.individualUserInformation.actions.cancel'/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>