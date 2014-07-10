<div class="row" style="max-width: 800px; margin: 5px auto;" ng-show="registrationCtrl.isIndividualProfileType()">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><g:message code='myMoney.registration.contact.heading'/></h3>
        </div>

        <div class="panel-body">
            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label for="email" class="control-label"><g:message code='myMoney.registration.contact.individual.email'/></label>
                </div>

                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-envelope"></span>
                        </span>
                        <input type="email" id="email" name="email" class="form-control" ng-required="registrationCtrl.isIndividualProfileType()"
                               ng-model="registrationCtrl.profileDetails.email"
                               ng-change="registrationCtrl.checkEmailAvailability('${createLink(controller: 'profile', action: 'checkEmailAvailability')}')"/>
                    </div>
                </div>
            </div>

            <div class="form-group" ng-show="registrationCtrl.isFormInvalid.emailCheck">
                <div class="col-md-12 text-danger text-center">
                    <g:message code='myMoney.registration.contact.individual.email.checkAvailability.emailIsUnavailable'/> <span
                    class="glyphicon glyphicon-thumbs-down">
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label for="phone" class="control-label"><g:message code='myMoney.registration.contact.individual.phone'/></label>
                </div>

                <div class="col-md-4 text-left">
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-globe"></span>
                        </span>
                        <select id="phoneCountry" name="phoneCountry" class="form-control bfh-countries"
                                ng-model="registrationCtrl.phoneCountry"
                                data-country="US">
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-offset-4 col-md-4">
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-earphone"></span>
                        </span>
                        <input type="text" id="phone" name="phone" class="form-control bfh-phone"
                               ng-model="registrationCtrl.profileDetails.phone"
                               data-country="phoneCountry"/>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-4 text-right">
                    <label class="control-label">
                        <span class="glyphicon glyphicon-map-marker"></span> <g:message code='myMoney.registration.contact.individual.address'/>
                    </label>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-offset-2 col-md-9">
                    <div class="well">
                        <div class="form-group">
                            <div class="col-md-2 text-right">
                                <label for="line1" class="control-label"><g:message code='myMoney.registration.contact.individual.address.line1'/></label>
                            </div>

                            <div class="col-md-10">
                                <input type="text" id="line1" name="line1" class="form-control" ng-model="registrationCtrl.profileDetails.line1"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-2 text-right">
                                <label for="line2" class="control-label"><g:message code='myMoney.registration.contact.individual.address.line2'/></label>
                            </div>

                            <div class="col-md-10">
                                <input type="text" id="line2" name="line2" class="form-control" ng-model="registrationCtrl.profileDetails.line2"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-2 text-right">
                                <label for="city" class="control-label"><g:message code='myMoney.registration.contact.individual.address.city'/></label>
                            </div>

                            <div class="col-md-6">
                                <input type="text" id="city" name="city" class="form-control" ng-model="registrationCtrl.profileDetails.city"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-2 text-right">
                                <label for="state" class="control-label"><g:message code='myMoney.registration.contact.individual.address.state'/></label>
                            </div>

                            <div class="col-md-6">
                                <select id="state" name="state" class="form-control bfh-states"
                                        ng-model="registrationCtrl.profileDetails.state"
                                        data-country="country"></select>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-2 text-right">
                                <label for="zipCode" class="control-label"><g:message code='myMoney.registration.contact.individual.address.zipCode'/></label>
                            </div>

                            <div class="col-md-4">
                                <input type="text" id="zipCode" name="zipCode" class="form-control" ng-model="registrationCtrl.profileDetails.zipCode"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-2 text-right">
                                <label for="country" class="control-label"><g:message code='myMoney.registration.contact.individual.address.country'/></label>
                            </div>

                            <div class="col-md-6">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-globe"></span>
                                    </span>

                                    <select id="country" name="country" class="form-control bfh-countries"
                                            ng-model="registrationCtrl.profileDetails.country"
                                            data-country="US">
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>