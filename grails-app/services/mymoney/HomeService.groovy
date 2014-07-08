package mymoney

import com.mymoney.alert.Alert
import com.mymoney.security.User

import grails.transaction.Transactional

@Transactional
class HomeService {

    List<Alert> searchAlertsByRecipient(User recipient) {
        assert recipient

        List<Alert> recipientAlerts = []

        String query = """
            select
                alert.id
            from
                com.mymoney.alert.Alert alert inner join alert.alertRecipient recipient
            where
                recipient.id = ${recipient.id}
        """

        println "[searchAlertsByRecipient] Query:\n${query}"

        List alertIds = Alert.executeQuery(query)

        println "[searchAlertsByRecipient] Found ${alertIds.size()} alerts for recipient ${recipient.username}..."

        alertIds?.each {
            Alert alert = Alert.get((long) it)

            if (alert) {
                recipientAlerts << alert
            }
        }

        return recipientAlerts
    }

    void dismissAlert(Alert alert) {
        assert alert

        alert.dismissed = true
        if (!alert.save(flush: true)) {
            println "[dismissAlert] Error dismissing alert..."
            alert.errors.allErrors.each { println it }
        }
    }
}
