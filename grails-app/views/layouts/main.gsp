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
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-formhelpers.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-formhelpers.min.css')}" type="text/css">

    <r:require modules="bootstrap"/>
    <r:require module="app"/>

    <title><g:layoutTitle/><g:message code='myMoney.title'/></title>
    <r:layoutResources/>
</head>

<body ng-controller="MainController as mainCtrl"
      ng-init="mainCtrl.initController('${activeNav}', '${createLink(controller: 'profile', action: 'initTheme')}')">

<link rel="stylesheet" href="${resource(dir: 'css/themes', file: 'theme-{{mainCtrl.theme.name}}.css')}" type="text/css">
<script type="text/javascript" src="${resource(dir: 'js', file: 'angular.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/bootstrap-formhelpers', file: 'bootstrap-formhelpers.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/bootstrap-formhelpers', file: 'bootstrap-formhelpers.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/ng-app', file: 'app.js')}"></script>


<ul class="nav nav-pills navbar-static-top">
    <li style="font-family: 'Brush Script MT', cursive !important; font-weight: bold !important; font-size: 24px !important; padding-top: 5px !important;">
        <label class="property-label">
            %{--<i class="fa fa-money"></i> <g:message code='myMoney.nav.title'/>--}%
            <g:message code='myMoney.nav.title'/>
        </label>
    </li>
    <g:if test="${Holders.applicationContext.getBean('springSecurityService').isLoggedIn()}">
        <li class="dropdown navbar-right">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <span class="glyphicon glyphicon-user"></span> <g:message code='myMoney.nav.welcome'
                                                                          args='["${((User) Holders.applicationContext.getBean('springSecurityService').currentUser).username}"]'/> <span
                class="caret"></span>
            </a>
            <ul class="dropdown-menu" role="menu">
                <li>
                    <a href="${createLink(controller: 'home', action: 'alertList')}">
                        <span class="glyphicon glyphicon-bell"></span> <g:message code='myMoney.nav.alerts'/> <span
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
        <li class="dropdown navbar-right">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <span class="glyphicon glyphicon-picture"></span> <g:message code='myMoney.nav.themes'/> <span class="caret"></span>
            </a>
            <ul class="dropdown-menu" role="menu">
                <li ng-class="{ 'disabled' : mainCtrl.theme.name === 'monochrome' }">
                    <a ng-show="mainCtrl.theme.name !== 'monochrome'" href="#saveTheme" ng-click="mainCtrl.previewSelectedTheme('monochrome', 'Monochrome')"
                       data-toggle="modal">
                        <span class="glyphicon glyphicon-stop monochrome"></span> <g:message code='myMoney.nav.themes.monochrome'/>
                    </a>
                    <a ng-show="mainCtrl.theme.name === 'monochrome'" href="#">
                        <span class="glyphicon glyphicon-stop monochrome"></span> <g:message code='myMoney.nav.themes.monochrome'/>
                    </a>
                </li>
                <li ng-class="{ 'disabled' : mainCtrl.theme.name === 'sapphire' }">
                    <a ng-show="mainCtrl.theme.name !== 'sapphire'" href="#saveTheme" ng-click="mainCtrl.previewSelectedTheme('sapphire', 'Sapphire')"
                       data-toggle="modal">
                        <span class="glyphicon glyphicon-stop sapphire"></span> <g:message code='myMoney.nav.themes.sapphire'/>
                    </a>
                    <a ng-show="mainCtrl.theme.name === 'sapphire'" href="#">
                        <span class="glyphicon glyphicon-stop sapphire"></span> <g:message code='myMoney.nav.themes.sapphire'/>
                    </a>
                </li>
                <li ng-class="{ 'disabled' : mainCtrl.theme.name === 'wine' }">
                    <a ng-show="mainCtrl.theme.name !== 'wine'" href="#saveTheme" ng-click="mainCtrl.previewSelectedTheme('wine', 'Wine')" data-toggle="modal">
                        <span class="glyphicon glyphicon-stop wine"></span> <g:message code='myMoney.nav.themes.wine'/>
                    </a>
                    <a ng-show="mainCtrl.theme.name === 'wine'" href="#">
                        <span class="glyphicon glyphicon-stop wine"></span> <g:message code='myMoney.nav.themes.wine'/>
                    </a>
                </li>
                <li ng-class="{ 'disabled' : mainCtrl.theme.name === 'rainforest' }">
                    <a ng-show="mainCtrl.theme.name !== 'rainforest'" href="#saveTheme" ng-click="mainCtrl.previewSelectedTheme('rainforest', 'Rain Forest')"
                       data-toggle="modal">
                        <span class="glyphicon glyphicon-stop rainforest"></span> <g:message code='myMoney.nav.themes.rainforest'/>
                    </a>
                    <a ng-show="mainCtrl.theme.name === 'rainforest'" href="#">
                        <span class="glyphicon glyphicon-stop rainforest"></span> <g:message code='myMoney.nav.themes.rainforest'/>
                    </a>
                </li>
                <li ng-class="{ 'disabled' : mainCtrl.theme.name === 'cotton-candy' }">
                    <a ng-show="mainCtrl.theme.name !== 'cotton-candy'" href="#saveTheme"
                       ng-click="mainCtrl.previewSelectedTheme('cotton-candy', 'Cotton Candy')" data-toggle="modal">
                        <span class="glyphicon glyphicon-stop cottoncandy"></span> <g:message code='myMoney.nav.themes.cottoncandy'/>
                    </a>
                    <a ng-show="mainCtrl.theme.name === 'cotton-candy'" href="#">
                        <span class="glyphicon glyphicon-stop cottoncandy"></span> <g:message code='myMoney.nav.themes.cottoncandy'/>
                    </a>
                </li>
                <li ng-class="{ 'disabled' : mainCtrl.theme.name === 'ivory' }">
                    <a ng-show="mainCtrl.theme.name !== 'ivory'" href="#saveTheme"
                       ng-click="mainCtrl.previewSelectedTheme('ivory', 'Ivory')" data-toggle="modal">
                        <span class="glyphicon glyphicon-stop ivory"></span> <g:message code='myMoney.nav.themes.ivory'/>
                    </a>
                    <a ng-show="mainCtrl.theme.name === 'ivory'" href="#">
                        <span class="glyphicon glyphicon-stop ivory"></span> <g:message code='myMoney.nav.themes.ivory'/>
                    </a>
                </li>
            </ul>
        </li>
        <li ng-class="{ 'navbar-right active' : mainCtrl.isActiveNav('Profile'), 'navbar-right': !mainCtrl.isActiveNav('Profile') }"
            ng-click="mainCtrl.setActiveNav('Profile')">
            <a href="${createLink(controller: 'profile', action: 'index',
                                  params: [id: ((User) Holders.applicationContext.getBean('springSecurityService').currentUser).id])}">
                <span class="glyphicon glyphicon-briefcase"></span> <g:message code='myMoney.nav.profile'/>
            </a>
        </li>
        <li ng-class="{ 'navbar-right active' : mainCtrl.isActiveNav('Home'), 'navbar-right' : !mainCtrl.isActiveNav('Home') }"
            ng-click="mainCtrl.setActiveNav('Home')">
            <a href="${createLink(controller: 'home', action: 'index')}">
                <span class="glyphicon glyphicon-home"></span> <g:message code='myMoney.nav.home'/>
            </a>
        </li>
    </g:if>
</ul>

<div id="saveTheme" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">
                    <span class="glyphicon glyphicon-question-sign"></span> <g:message
                    code='myMoney.nav.themes.modals.saveTheme.heading'/>
                </h4>
            </div>

            <div class="modal-body">
                <div class="col-md-12 text-center">
                    <g:message code='myMoney.nav.themes.modals.saveTheme.message'/>
                </div>
            </div>

            <div class="modal-footer">
                <div class="col-md-12 text-right">
                    <button type="button" class="btn btn-primary" data-dismiss="modal"
                            ng-click="mainCtrl.savePreviewedTheme('${createLink(controller: 'profile', action: 'saveTheme')}')">
                        <span class="glyphicon glyphicon-save"></span> <g:message code='myMoney.nav.themes.modals.saveTheme.actions.save'/>
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="mainCtrl.resetTheme()">
                        <span class="glyphicon glyphicon-remove"></span> <g:message code='myMoney.nav.themes.modals.saveTheme.actions.cancel'/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<ul class="nav navbar-fixed-bottom">
    <li class="col-md-12 text-center property-value">
        <%
            def c = Calendar.getInstance()
            c.setTime(new Date())
        %>
        Copyright <span class="glyphicon glyphicon-copyright-mark"></span> ${c.get(Calendar.YEAR)}. All Rights Reserved.
    </li>
</ul>
<g:layoutBody/>
<r:layoutResources/>
</body>
</html>