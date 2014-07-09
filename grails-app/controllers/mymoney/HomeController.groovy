package mymoney

import com.mymoney.account.Account
import com.mymoney.account.AccountType
import com.mymoney.alert.Alert
import com.mymoney.alert.AlertAction
import com.mymoney.config.MyMoneyConstants
import com.mymoney.security.User

import grails.converters.JSON

import grails.plugin.springsecurity.annotation.Secured

import org.grails.plugin.easygrid.Easygrid

@Easygrid
class HomeController {

    def homeService

    def springSecurityService

    @Secured(['ROLE_INDIVIDUAL', 'ROLE_FAMILY'])
    def index() {
        User recipient = (User) springSecurityService.currentUser

        int alertCount = homeService.countAlertsByRecipient(recipient)
        render(view: '/home/homePage', model: [activeNav: 'Home', activeSubNav: 'Dashboard', template: '/home/dashboard', alertCount: alertCount])
    }

    @Secured(['ROLE_INDIVIDUAL', 'ROLE_FAMILY'])
    def accounts() {
        User recipient = (User) springSecurityService.currentUser

        int alertCount = homeService.countAlertsByRecipient(recipient)

        render(view: '/home/homePage', model: [activeNav: 'Home', activeSubNav: 'Accounts', template: '/home/accounts', alertCount: alertCount])
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

    def accountsListGrid = {
        domainClass Account
        gridImpl 'jqgrid'
        export {
            export_title 'Accounts'
        }
        columns {
            accountNumber {
                formatName 'accountNumberDisplay'
                jqgrid {
                    editable 'false'
                }
            }
            dateOpened {
                formatName 'gridDateFormat'
                jqgrid {
                    editable 'false'
                }
            }
            accountType {
                jqgrid {
                    editable 'false'
                }
            }
            accountBalance {
                jqgrid {
                    editable 'false'
                }
            }
            actions {
                type 'actions'
            }
        }
    }
}
