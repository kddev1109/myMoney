package com.mymoney.card

class CreditCard extends Card {

    Double currentBalance
    Double totalCreditLimit

    Double minimumPaymentDue

    Date paymentDueDate

    static constraints = {
        currentBalance(nullable: false)
        totalCreditLimit(nullable: false)
        minimumPaymentDue(nullable: false)
        paymentDueDate(nullable: false)
    }

    @Override
    public Double getCardBalance() {
        return (this.totalCreditLimit - this.currentBalance)
    }

    @Override
    public CardCategory getCardCategory() {
        return CardCategory.CREDIT
    }
}
