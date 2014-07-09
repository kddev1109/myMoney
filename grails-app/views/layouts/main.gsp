<%@ page import="com.mymoney.security.User; grails.util.Holders" %>
<!DOCTYPE html>
<html lang="en" ng-app="myMoney">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">

    <r:require modules="bootstrap"/>
    <r:require module="app"/>

    <title><g:layoutTitle/><g:message code='myMoney.title'/></title>
    <r:layoutResources/>
</head>

<body>
<script type="text/javascript" src="${resource(dir: 'js', file: 'angular.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/ng-app', file: 'app.js')}"></script>
<g:if test="${Holders.applicationContext.getBean('springSecurityService').isLoggedIn()}">
    <ul class="nav nav-pills navbar-static-top" ng-controller="MainController as mainCtrl" ng-init="mainCtrl.initActiveNav('${activeNav}')">
        <li ng-class="{ 'active' : mainCtrl.isActiveNav('Home') }" ng-click="mainCtrl.setActiveNav('Home')">
            <a href="${createLink(controller: 'home', action: 'index')}">
                <span class="glyphicon glyphicon-home"></span> <g:message code='myMoney.nav.home'/>
            </a>
        </li>
        <li ng-class="{ 'active' : mainCtrl.isActiveNav('Profile') }" ng-click="mainCtrl.setActiveNav('Profile')">
            <a href="${createLink(controller: 'profile', action: 'index',
                                  params: [id: ((User) Holders.applicationContext.getBean('springSecurityService').currentUser).id])}">
                <span class="glyphicon glyphicon-briefcase"></span> <g:message code='myMoney.nav.profile'/>
            </a>
        </li>
        <li class="dropdown navbar-right">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <span class="glyphicon glyphicon-user"></span> <g:message code='myMoney.nav.welcome'
                                                                          args='["${((User) Holders.applicationContext.getBean('springSecurityService').currentUser).username}"]'/> <span
                class="caret"></span>
            </a>
            <ul class="dropdown-menu" role="menu">
                <li>
                    <a href="${createLink(controller: 'home', action: 'alertList')}">
                        <span class="glyphicon glyphicon-exclamation-sign"></span> <g:message code='myMoney.nav.alerts'/> <span
                        class="badge">${alertCount}</span>
                    </a>
                </li>
                <li>
                    <a href="${createLink(controller: 'profile', action: 'settings')}">
                        <span class="glyphicon glyphicon-cog"></span> <g:message code='myMoney.nav.settings'/>
                    </a>
                </li>
                <li class="nav-divider"></li>
                <li>
                    <a href="#"
                       ng-click="mainCtrl.logout('${createLink(controller: 'logout', action: 'index')}', '${createLink(controller: 'home', action: 'index')}')">
                        <span class="glyphicon glyphicon-off"></span> <g:message code='myMoney.nav.logout'/>
                    </a>
                </li>
            </ul>
        </li>
    </ul>
    <ul class="nav navbar-fixed-bottom">
        <li class="col-md-12 text-center">
            <%
                def c = Calendar.getInstance()
                c.setTime(new Date())
            %>
            Copyright <span class="glyphicon glyphicon-copyright-mark"></span> ${c.get(Calendar.YEAR)}. All Rights Reserved.
        </li>
    </ul>
</g:if>
<g:layoutBody/>
<r:layoutResources/>
</body>
</html>