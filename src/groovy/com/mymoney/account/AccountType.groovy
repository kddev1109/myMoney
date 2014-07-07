package com.mymoney.account

public enum AccountType {

    CHECKING('Checking'),
    SAVINGS('Savings'),
    CREDIT_CARD('Credit Card'),
    DEBIT_CARD('Debit Card')

    private String name

    private AccountType(String name) {
        this.name = name
    }

    public String getName() {
        return this.name
    }
}