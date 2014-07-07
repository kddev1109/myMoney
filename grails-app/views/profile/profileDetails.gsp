<%@ page import="grails.converters.JSON" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
</head>

<body>
<div class="container-fluid">
    <form method="POST" id="profileForm" name="profileForm" class="form-horizontal" autocomplete="off" novalidate=""
          ng-controller="ProfileController as profileCtrl" ng-init="profileCtrl.initProfileDetailsProperties('${profileDetailsProperties as JSON}')">
        <g:render template="profileAccountInformation"/>
        <g:render template="profileIndividualUserInformation"/>
        <g:render template="profileContactInformation"/>
    </form>
</div>
</body>
</html>