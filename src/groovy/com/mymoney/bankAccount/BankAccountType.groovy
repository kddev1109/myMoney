package com.mymoney.bankAccount

public enum BankAccountType {

    CHECKING('Checking'),
    SAVINGS('Savings'),
    CREDIT_CARD('Credit Card')

    private String name

    private BankAccountType(String name) {
        this.name = name
    }

    public String getName() {
        return this.name
    }
}