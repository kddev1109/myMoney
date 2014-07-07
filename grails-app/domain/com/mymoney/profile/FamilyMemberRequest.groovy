package com.mymoney.profile

class FamilyMemberRequest {

    FamilyProfile familyRequestedFor
    IndividualProfile requestedIndividual

    Date dateRequested

    FamilyMemberRequestStatus requestStatus = FamilyMemberRequestStatus.PENDING

    static constraints = {
        familyRequestedFor(nullable: false)
        requestedIndividual(nullable: false)
        dateRequested(nullable: false)
        requestStatus(nullable: false)
    }
}
