<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en" ng-app="myMoney">
<head>
    <meta name="layout" content="main"/>
</head>

<body>
<div class="container-fluid">
    <form method="POST" id="registrationForm" name="registrationForm" class="form-horizontal"
          autocomplete="off" novalidate ng-controller="RegistrationController as registrationCtrl"
          ng-submit="registrationForm.$valid &&
                     registrationCtrl.submitRegistration('${createLink(controller: 'profile', action: 'submitRegistrationDetails')}',
                                                         '${createLink(controller: 'home', action: 'index')}')">
        <g:render template="registration/registrationAccountInformation"/>
        <g:render template="registration/registrationIndividualProfileInformation"/>
        <g:render template="registration/registrationFamilyProfileInformation"/>
        <g:render template="registration/registrationContactInformation"/>
        <g:render template="registration/registrationActions"/>
    </form>
</div>
</body>
</html>