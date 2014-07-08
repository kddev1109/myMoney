package com.mymoney.profile

import com.mymoney.alert.request.Request

class FamilyMemberRequest extends Request {

    FamilyProfile familyRequestedFor
    IndividualProfile familyMemberRequested

    static constraints = {
        familyRequestedFor(nullable: false)
        familyMemberRequested(nullable: false)
    }
}
