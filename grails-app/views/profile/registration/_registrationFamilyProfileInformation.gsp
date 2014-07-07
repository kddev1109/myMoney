<div class="row" style="max-width: 800px; margin: 5px auto;" ng-show="registrationCtrl.isFamilyProfileType()">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><g:message code='myMoney.registration.profile.heading'/></h3>
        </div>

        <div class="panel-body">
            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label for="familyAlias" class="control-label"><g:message code='myMoney.registration.profile.family.name'/></label>
                </div>

                <div class="col-md-3">
                    <input type="text" id="familyAlias" name="familyAlias" class="form-control" ng-required="registrationCtrl.isFamilyProfileType()"
                           ng-model="registrationCtrl.profileDetails.familyName"/>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label class="control-label"><g:message code='myMoney.registration.profile.family.members'/></label>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <div class="col-md-8 text-right">
                            <input type="text" class="form-control"
                                   placeholder="${message(code: 'myMoney.registration.profile.family.members.lookup.placeholder')}"
                                   ng-model="registrationCtrl.familyMemberLookup" ng-change="registrationCtrl.resetPageLoad()"/>
                        </div>

                        <div class="col-md-4">
                            <button type="button" class="btn btn-default"
                                    ng-click="registrationCtrl.lookupFamilyMember('${createLink(controller: 'profile', action: 'lookupIndividualsByUsernameOrEmail')}')">
                                <g:message code='myMoney.registration.profile.family.members.lookup'/> <span class="glyphicon glyphicon-search"></span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group" ng-show="!registrationCtrl.pageLoad && registrationCtrl.hasIndividuals()">
                <div class="col-md-offset-4" ng-repeat="familyMemberRequest in registrationCtrl.familyMemberRequests">
                    <label  ng-class="{ 'label label-danger' : registrationCtrl.isFamilyMemberRequestInFocus(familyMemberRequest),
                                        'label label-primary' : !registrationCtrl.isFamilyMemberRequestInFocus(familyMemberRequest) }">
                        {{familyMemberRequest}} <span class="glyphicon glyphicon-remove"
                                                      ng-click="registrationCtrl.removeFamilyMember(familyMemberRequest)"
                                                      ng-mouseover="registrationCtrl.setFamilyMemberRequestInFocus(familyMemberRequest)"
                                                      ng-mouseleave="registrationCtrl.resetFamilyMemberRequestInFocus()"></span>
                    </label>
                </div>
            </div>

            <div class="form-group" ng-show="!registrationCtrl.pageLoad && registrationCtrl.hasIndividuals()">
                <div class="col-md-12 text-center text-success">
                    <span class="glyphicon glyphicon-search"></span>
                    <g:message code='myMoney.registration.profile.family.members.lookup.usersFound'
                               args='["{{registrationCtrl.individualsLookedUp.individuals.length}}", "{{registrationCtrl.familyMemberLookup}}"]'/>
                </div>
            </div>

            <div class="form-group" ng-show="!registrationCtrl.pageLoad && registrationCtrl.hasIndividuals()">

                <div class="col-md-12">
                    <div class="col-md-3 text-center"><strong><g:message code='myMoney.registration.profile.family.members.lookup.username'/></strong></div>

                    <div class="col-md-3 text-center"><strong><g:message code='myMoney.registration.profile.family.members.lookup.email'/></strong></div>

                    <div class="col-md-3 text-center"><strong><g:message code='myMoney.registration.profile.family.members.lookup.name'/></strong></div>
                </div>

                <div class="col-md-12" style="padding: 2px;" ng-repeat="individual in registrationCtrl.individualsLookedUp.individuals">

                    <div class="col-md-3 text-center">{{individual.username}}</div>

                    <div class="col-md-3 text-center">{{individual.email}}</div>

                    <div class="col-md-3 text-center">{{individual.name}}</div>

                    <div class="col-md-3 text-center">
                        <input type="button" class="btn btn-sm btn-default"
                               value="${message(code: 'myMoney.registration.profile.family.members.lookup.addToFamily')}"
                               ng-click="registrationCtrl.addFamilyMember(individual.username)"
                               ng-disabled="registrationCtrl.familyMemberAlreadyAdded(individual.username)"/>
                    </div>
                </div>
            </div>

            <div class="form-group" ng-hide="registrationCtrl.pageLoad || registrationCtrl.hasIndividuals()">
                <div class="col-md-12 text-center text-warning">
                    <span class="glyphicon glyphicon-search"></span>
                    <g:message code='myMoney.registration.profile.family.members.lookup.noUsersFound' args='["{{registrationCtrl.familyMemberLookup}}"]'/>
                </div>
            </div>
        </div>
    </div>
</div>