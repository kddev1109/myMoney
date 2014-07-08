<%@ page import="com.mymoney.security.User" %>
<div class="row" style="max-width: 800px; margin: 5px auto;">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><span class="glyphicon glyphicon-usd"></span> <g:message code='myMoney.profile.accountInformation.heading'/></h3>
        </div>

        <div class="panel-body">
            <div class="form-group">
                <div class="col-md-12 text-right">
                    <a href="#deactivateProfile" class="btn btn-warning" data-toggle="modal">
                        <span class="glyphicon glyphicon-pause"></span> <g:message code='myMoney.profile.accountInformation.actions.deactivateProfile'/>
                    </a>
                    <a href="#deleteProfile" class="btn btn-danger" data-toggle="modal">
                        <span class="glyphicon glyphicon-trash"></span> <g:message code='myMoney.profile.accountInformation.actions.deleteProfile'/>
                    </a>
                </div>
            </div>

            <div class="form-group" ng-repeat="accountInformationProperty in profileCtrl.profileDetailsProperties.accountInformation">
                <div class="col-md-4 text-right">
                    <label class="property-label">{{accountInformationProperty.key}}</label>
                </div>

                <div class="col-md-6">
                    {{accountInformationProperty.value}}
                </div>
            </div>

            <div class="form-group" ng-hide="profileCtrl.changePassword">
                <div class="col-md-offset-4 col-md-6">
                    <button type="button" class="btn btn-default" ng-click="profileCtrl.showChangePasswordWell()" ng-hide="profileCtrl.changePassword">
                        <span class="glyphicon glyphicon-pencil"></span> <g:message code='myMoney.profile.accountInformation.password.changePassword'/>
                    </button>
                </div>
            </div>

            <div class="form-group" ng-show="profileCtrl.changePassword">
                <div class="col-md-offset-2 col-md-8">
                    <div class="well">
                        <div class="form-group" ng-show="profileCtrl.invalidCurrentPassword">
                            <div class="col-md-12 text-center text-danger">
                                <g:message code='myMoney.profile.accountInformation.password.changePassword.invalidCurrentPassword'/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-6 text-right">
                                <label for="currentPassword" class="control-label">
                                    <g:message code='myMoney.profile.accountInformation.password.changePassword.currentPassword'/>
                                </label>
                            </div>

                            <div class="col-md-6">
                                <input type="password" id="currentPassword" name="currentPassword" class="form-control" required
                                       ng-model="profileCtrl.currentPassword">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-6 text-right">
                                <label for="newPassword" class="control-label">
                                    <g:message code='myMoney.profile.accountInformation.password.changePassword.newPassword'/>
                                </label>
                            </div>

                            <div class="col-md-6">
                                <input type="password" id="newPassword" name="newPassword" class="form-control" required
                                       ng-model="profileCtrl.newPassword">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-6 text-right">
                                <label for="confirmNewPassword" class="control-label">
                                    <g:message code='myMoney.profile.accountInformation.password.changePassword.confirmNewPassword'/>
                                </label>
                            </div>

                            <div class="col-md-6">
                                <input type="password" id="confirmNewPassword" name="confirmNewPassword" class="form-control" required
                                       ng-model="profileCtrl.confirmNewPassword">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-12 text-right">
                                <button type="button" class="btn btn-primary"
                                        ng-click="profileCtrl.updatePassword('${createLink(controller: 'profile', action: 'verifyCurrentPassword')}',
                                        '${createLink(controller: 'profile', action: 'updatePassword')}',
                                        '${createLink(controller: 'profile', action: 'index', params: [id: profileId])}')"
                                        ng-disabled="profileForm.$invalid">
                                    <g:message code='myMoney.profile.accountInformation.password.changePassword.actions.ok'/>
                                </button>
                                <button type="button" class="btn btn-default" ng-click="profileCtrl.hideChangePasswordWell()">
                                    <g:message code='myMoney.profile.accountInformation.password.changePassword.actions.cancel'/>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="deactivateProfile" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">
                    <span class="glyphicon glyphicon-question-sign"></span> <g:message
                    code='myMoney.profile.accountInformation.modals.deactivateProfile.heading'/>
                </h4>
            </div>

            <div class="modal-body">
                <div class="col-md-12 text-center">
                    <g:message code='myMoney.profile.accountInformation.modals.deactivateProfile.message'/>
                </div>
            </div>

            <div class="modal-footer">
                <div class="col-md-12 text-right">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" ng-click="profileCtrl.deactivateProfile()">
                        <span class="glyphicon glyphicon-pause"></span> <g:message
                        code='myMoney.profile.accountInformation.modals.deactivateProfile.actions.deactivate'/>
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        <span class="glyphicon glyphicon-remove"></span> <g:message
                        code='myMoney.profile.accountInformation.modals.deactivateProfile.actions.cancel'/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="deleteProfile" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">
                    <span class="glyphicon glyphicon-question-sign"></span> <g:message code='myMoney.profile.accountInformation.modals.deleteProfile.heading'/>
                </h4>
            </div>

            <div class="modal-body">
                <div class="col-md-12 text-center">
                    <g:message code='myMoney.profile.accountInformation.modals.deleteProfile.message'/>
                </div>
            </div>

            <div class="modal-footer">
                <div class="col-md-12 text-right">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" ng-click="profileCtrl.deleteProfile()">
                        <span class="glyphicon glyphicon-trash"></span> <g:message
                        code='myMoney.profile.accountInformation.modals.deleteProfile.actions.delete'/>
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        <span class="glyphicon glyphicon-remove"></span> <g:message
                        code='myMoney.profile.accountInformation.modals.deleteProfile.actions.cancel'/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>