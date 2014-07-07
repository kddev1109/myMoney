package com.mymoney.transaction

public enum TransactionStatus {

    PENDING('Pending'),
    CANCELLED('Cancelled'),
    COMPLETED('Completed')

    private String name

    private TransactionStatus(String name) {
        this.name = name
    }

    public String getName() {
        return this.name
    }
}