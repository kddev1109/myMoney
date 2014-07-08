package mymoney

import com.mymoney.alert.Alert
import com.mymoney.alert.AlertAction
import com.mymoney.config.MyMoneyConstants
import com.mymoney.security.User

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class HomeController {

    def homeService

    def springSecurityService

    @Secured(['ROLE_INDIVIDUAL', 'ROLE_FAMILY'])
    def index() {
        render(view: '/home/homePage', model: [activeNav: 'Home', template: '/home/dashboard'])
    }

    @Secured(['ROLE_INDIVIDUAL', 'ROLE_FAMILY'])
    def alerts() {
        withFormat {
            json {
                def results = [
                    alerts: []
                ]

                // TODO: Pagination by priority
                User recipient = (User) springSecurityService.currentUser

                List<Alert> alerts = homeService.searchAlertsByRecipient(recipient)

                alerts?.each { Alert alert ->
                    if (!alert.dismissed) {
                        results.alerts.add(
                            [
                                id: alert.id,
                                heading: alert.alertHeading,
                                body: alert.alertBody,
                                link: alert.alertLink,
                                hasLink: (alert.alertLink != null),
                                actions: alert.actions.tokenize(MyMoneyConstants.ACTIONS_SEPARATOR).collect {
                                    return [
                                        text: AlertAction.parseActionTextFromActionString(it),
                                        link: AlertAction.parseActionLinkFromActionString(it) ?: '#',
                                        actionClass: AlertAction.parseActionClassFromActionString(it)?.name ?: ''
                                    ]
                                }
                            ]
                        )
                    }
                }

                render(results as JSON)
            }
        }
    }

    @Secured(['ROLE_INDIVIDUAL', 'ROLE_FAMILY'])
    def dismissAlert() {
        withFormat {
            json {
                def results = [:]

                Long alertId = (long) request.JSON?.id

                if (alertId) {
                    Alert alert = Alert.get(alertId)

                    if (alert) {
                        homeService.dismissAlert(alert)
                    }
                }

                render(results as JSON)
            }
        }
    }
}
