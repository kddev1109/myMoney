<div class="row" style="max-width: 800px; margin: 5px auto;">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><g:message code='myMoney.registration.account.heading'/></h3>
        </div>

        <div class="panel-body">
            <div class="form-group">
                <div class="col-md-12 text-right">
                    <input type="submit" name="register" class="btn btn-primary" value="${message(code: 'myMoney.registration.actions.register')}"
                           ng-disabled="registrationForm.$invalid || registrationCtrl.checkIfFormIsInvalid()"/>
                    <a href="${createLink(controller: 'home', action: 'index')}" class="btn btn-default"><g:message
                        code='myMoney.registration.actions.cancel'/></a>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label class="control-label"><g:message code='myMoney.registration.account.profileType'/></label>
                </div>

                <div class="col-md-6">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" id="individualProfileType" name="profileType"
                                ng-model="registrationCtrl.profileDetails.profileType"
                                ng-click="registrationCtrl.setProfileType('Individual')" ng-class="{ 'active' : registrationCtrl.isIndividualProfileType() }">
                            <g:message code='myMoney.registration.account.profileType.individual'/>
                        </button>
                        <button type="button" class="btn btn-default" id="familyProfileType" name="profileType"
                                ng-model="registrationCtrl.profileDetails.profileType"
                                ng-click="registrationCtrl.setProfileType('Family')" ng-class="{ 'active' : registrationCtrl.isFamilyProfileType() }">
                            <g:message code='myMoney.registration.account.profileType.family'/>
                        </button>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label for="username" class="control-label"><g:message code='myMoney.registration.account.username'/></label>
                </div>

                <div class="col-md-4">
                    <input type="text" id="username" name="username" class="form-control" required ng-model="registrationCtrl.profileDetails.username"/>
                </div>

                <div class="col-md-2">
                    <button type="button" class="btn btn-default"
                            ng-click="registrationCtrl.checkUsernameAvailability('${createLink(controller: 'profile', action: 'checkUsernameAvailability')}')"
                            ng-disabled="registrationCtrl.doNotDisplayCheckUsernameAvailability()">
                        <g:message code='myMoney.registration.account.username.checkAvailability'/> <span class="glyphicon glyphicon-search"></span>
                    </button>
                </div>
            </div>

            <div class="form-group" ng-hide="registrationCtrl.doNotDisplayUsernameUnavailable()">
                <div class="col-md-12 text-danger text-center">
                    <g:message code='myMoney.registration.account.username.checkAvailability.usernameIsUnavailable'/> <span class="glyphicon glyphicon-thumbs-down"></span>
                </div>
            </div>

            <div class="form-group" ng-show="registrationCtrl.displayUsernameAvailable()">
                <div class="col-md-12 text-success text-center">
                    <g:message code='myMoney.registration.account.username.checkAvailability.usernameIsAvailable'/> <span class="glyphicon glyphicon-thumbs-up"></span>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label for="password" class="control-label"><g:message code='myMoney.registration.account.password'/></label>
                </div>

                <div class="col-md-4">
                    <input type="password" id="password" name="password" class="form-control" required ng-model="registrationCtrl.profileDetails.password"
                           ng-change="registrationCtrl.checkPasswords()"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label for="confirmPassword" class="control-label"><g:message code='myMoney.registration.account.confirmPassword'/></label>
                </div>

                <div class="col-md-4">
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required
                           ng-model="registrationCtrl.profileDetails.confirmPassword" ng-change="registrationCtrl.checkPasswords()"/>
                </div>
            </div>

            <div class="form-group" ng-show="registrationCtrl.isFormInvalid.passwordMatchCheck">
                <div class="col-md-12 text-danger text-center">
                    <span class="glyphicon glyphicon-remove"></span> <g:message code='myMoney.registration.account.passwordsDoNotMatch'/>
                </div>
            </div>

            <div class="form-group" ng-show="!registrationCtrl.isFormInvalid.passwordMatchCheck && !registrationCtrl.arePasswordsBlank()">
                <div class="col-md-12 text-success text-center">
                    <span class="glyphicon glyphicon-ok"></span> <g:message code='myMoney.registration.account.passwordsMatch'/>
                </div>
            </div>
        </div>
    </div>
</div>