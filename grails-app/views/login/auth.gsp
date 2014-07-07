<%@ page import="grails.util.Holders" contentType="text/html;charset=UTF-8" %>
<html ng-app="myMoney">
<head>
    <meta name='layout' content='main'/>
</head>

<body>
<div class="container-fluid">
    <div class="row">
        <form method="POST" action="${postUrl}" name="loginForm" class="form-horizontal" autocomplete="off"
              ng-controller="LoginController as loginCtrl" novalidate ng-submit="loginCtrl.testMethod()">
            <div class="panel panel-default" style="max-width:600px; margin: 160px auto;">
                <div class="panel-heading">
                    <h3 class="panel-title"><g:message code='myMoney.login.title'/></h3>
                </div>

                <div class="panel-body">
                    <div class="form-group">
                        <div class="col-md-4 text-right">
                            <label class="control-label"><g:message code='myMoney.login.username'/></label>
                        </div>

                        <div class="col-md-6">
                            <input type='text' class='form-control' name='j_username' id='username' ng-model="loginCtrl.j_username" required/>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-4 text-right">
                            <label class="control-label"><g:message code='myMoney.login.password'/></label>
                        </div>

                        <div class="col-md-6">
                            <input type='password' class='form-control' name='j_password' id='password' ng-model="loginCtrl.j_password" required/>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-offset-6">
                            <input type="checkbox" name="${rememberMeParameter}" id="remember_me" <g:if test="${hasCookie}">checked='checked'</g:if>/>
                            <label for="remember_me"><g:message code='myMoney.login.rememberMe'/></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-offset-6">
                            <input type="submit" class="btn btn-primary" id="submit" value="${message(code: 'myMoney.login.login')}"
                                   ng-disabled="!loginForm.$valid"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-offset-2 text-center">
                            <a href="../profile/register"><g:message code='myMoney.login.register'/></a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script type='text/javascript'>
    <!--
    (function () {
        document.forms['loginForm'].elements['j_username'].focus();
    })();
    // -->
</script>
</body>
</html>