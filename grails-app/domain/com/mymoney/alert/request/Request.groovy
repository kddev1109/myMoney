package com.mymoney.alert.request

import com.mymoney.alert.Alert

class Request {

    Date requestedDate
    RequestStatus requestStatus = RequestStatus.PENDING

    Alert requestAlert

    static constraints = {
        requestedDate(nullable: false)
        requestStatus(nullable: false)
        requestAlert(nullable: true)
    }
}
