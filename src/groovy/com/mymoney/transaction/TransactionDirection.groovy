package com.mymoney.transaction

public enum TransactionDirection {

    CREDIT('Credit'),
    DEBIT('Debit')

    private String name

    private TransactionDirection(String name) {
        this.name = name
    }

    public String getName() {
        return this.name
    }
}