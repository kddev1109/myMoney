<%@ page import="grails.util.Holders" %>
<div class="container-fluid">
    <div class="row" style="max-width: 800px; margin: 0 auto;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><g:message code='myMoney.registration.mail.familyMemberRequest.heading' args='["${recipientName}"]'/></h3>
            </div>
            <div class="panel-body">
                <div class="col-md-12 text-justify">
                    <p>You have received a MyMoney family member request. Please review the request and accept/reject the same.</p>
                    <p>
                        <%
                            def serverUrl = Holders.grailsApplication.config.grails.serverURL
                        %>
                        Please click <a href="${serverUrl}/profile/reviewFamilyMemberRequest/${requestId}">here</a> to review the request.
                    </p>
                </div>
            </div>
            <div class="panel-footer">
                <div class="col-md-6 text-left">
                    <label><g:message code='myMoney.registration.mail.regards'/></label>
                    <label><g:message code='myMoney.registration.mail.myMoneyTeam'/></label>
                </div>
                <div class="col-md-6 text-right">
                    <%
                        Calendar c = Calendar.getInstance()
                        c.setTime(new Date())
                    %>
                    <g:message code='myMoney.registration.mail.familyMemberRequest.footer' args='["${c.get(Calendar.YEAR)}"]'/>
                </div>
            </div>
        </div>
    </div>
</div>