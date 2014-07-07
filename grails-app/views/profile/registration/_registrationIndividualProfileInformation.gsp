<div class="row" style="max-width: 800px; margin: 5px auto;" ng-show="registrationCtrl.isIndividualProfileType()">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><g:message code='myMoney.registration.profile.heading'/></h3>
        </div>

        <div class="panel-body">
            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label for="firstName" class="control-label"><g:message code='myMoney.registration.profile.individual.firstName'/></label>
                </div>

                <div class="col-md-6">
                    <input type="text" id="firstName" name="firstName" class="form-control" ng-required="registrationCtrl.isIndividualProfileType()"
                           ng-model="registrationCtrl.profileDetails.firstName"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label for="lastName" class="control-label"><g:message code='myMoney.registration.profile.individual.lastName'/></label>
                </div>

                <div class="col-md-6">
                    <input type="text" id="lastName" name="lastName" class="form-control" ng-model="registrationCtrl.profileDetails.lastName"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label class="control-label"><g:message code='myMoney.registration.profile.individual.gender'/></label>
                </div>

                <div class="col-md-6">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" id="male" name="gender"
                                ng-click="registrationCtrl.setGender('Male')" ng-class="{ 'active': registrationCtrl.isMale() }">
                            <g:message code='myMoney.registration.profile.individual.gender.male'/>
                        </button>
                        <button type="button" class="btn btn-default" id="female" name="gender"
                                ng-click="registrationCtrl.setGender('Female')" ng-class="{ 'active': registrationCtrl.isFemale() }">
                            <g:message code='myMoney.registration.profile.individual.gender.female'/>
                        </button>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label for="dateOfBirth" class="control-label"><g:message code='myMoney.registration.profile.individual.dateOfBirth'/></label>
                </div>

                <div class="col-md-3">
                    <input type="date" id="dateOfBirth" name="dateOfBirth" class="form-control"
                           ng-model="registrationCtrl.profileDetails.dateOfBirth"/>
                </div>
            </div>
        </div>
    </div>
</div>