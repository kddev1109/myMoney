<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
</head>

<body>
<div class="container-fluid">
    <form method="POST" id="familyRequestReviewForm" name="familyRequestReviewForm" class="form-horizontal"
          autocomplete="off" novalidate ng-controller="RegistrationController as registrationCtrl"
          ng-init="registrationCtrl.initFamilyMemberRequest('${requestDetails as grails.converters.JSON}')">
        <div class="row" style="max-width: 800px; margin: 120px auto;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><g:message code='myMoney.registration.reviewFamilyMemberRequest.heading'/></h3>
                </div>

                <div class="panel-body">
                    <div class="form-group">
                        <div class="col-md-4 text-right">
                            <label class="property-label">
                                <g:message code='myMoney.registration.reviewFamilyMemberRequest.familyUsername'/>
                            </label>
                        </div>

                        <div class="col-md-offset-4">
                            {{registrationCtrl.familyMemberRequestDetails.familyUsername}}
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-4 text-right">
                            <label class="property-label">
                                <g:message code='myMoney.registration.reviewFamilyMemberRequest.familyName'/>
                            </label>
                        </div>

                        <div class="col-md-offset-4">
                            {{registrationCtrl.familyMemberRequestDetails.familyName}}
                        </div>
                    </div>

                    <div class="col-md-12"><hr></div>

                    <div class="col-md-12 text-center" ng-hide="registrationCtrl.familyHasMembers()">
                        <g:message code='myMoney.registration.reviewFamilyMemberRequest.noFamilyMembers'/>
                    </div>

                    <div class="form-group" ng-show="registrationCtrl.familyHasMembers()">
                        <div class="col-md-4 text-right">
                            <label class="property-label">
                                <g:message code='myMoney.registration.reviewFamilyMemberRequest.familyMembers'/>
                            </label>
                        </div>
                    </div>

                    <div class="form-group" ng-show="registrationCtrl.familyHasMembers()">
                        <div class="col-md-4 text-center">
                            <label class="property-label">
                                <g:message code='myMoney.registration.reviewFamilyMemberRequest.familyMembers.username'/>
                            </label>
                        </div>

                        <div class="col-md-4 text-center">
                            <label class="property-label">
                                <g:message code='myMoney.registration.reviewFamilyMemberRequest.familyMembers.email'/>
                            </label>
                        </div>

                        <div class="col-md-4 text-center">
                            <label class="property-label">
                                <g:message code='myMoney.registration.reviewFamilyMemberRequest.familyMembers.name'/>
                            </label>
                        </div>
                    </div>

                    <div class="form-group" ng-repeat="familyMember in registrationCtrl.familyMemberRequestDetails.familyMembers">
                        <div class="col-md-4 text-center">{{familyMember.memberUsername}}</div>

                        <div class="col-md-4 text-center">{{familyMember.memberEmail}}</div>

                        <div class="col-md-4 text-center">{{familyMember.memberName}}</div>
                    </div>

                    <div class="col-md-12"><hr></div>

                    <div class="form-group">
                        <div class="col-md-5 text-right">
                            <button type="button" ng-click="registrationCtrl.familyMemberRequestDecision('${createLink(controller: 'profile', action:
                                'acceptFamilyMemberRequest', params: [id: requestId])}')" class="btn btn-sm btn-success">
                                <g:message code='myMoney.registration.reviewFamilyMemberRequest.actions.accept'/>
                            </button>
                        </div>
                        <div class="col-md-2 text-center">
                            <button type="button" ng-click="registrationCtrl.familyMemberRequestDecision('${createLink(controller: 'profile', action:
                                'rejectFamilyMemberRequest', params: [id: requestId])}')" class="btn btn-sm btn-danger">
                                <g:message code='myMoney.registration.reviewFamilyMemberRequest.actions.reject'/>
                            </button>
                        </div>
                        <div class="col-md-5 text-left">
                            <button type="button" ng-click="registrationCtrl.familyMemberRequestDecision('${createLink(controller: 'home', action: 'index')}')"
                                    class="btn btn-sm btn-default">
                                <g:message code='myMoney.registration.reviewFamilyMemberRequest.actions.cancel'/>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="panel-footer"></div>
            </div>
        </div>
    </form>
</div>
</body>
</html>