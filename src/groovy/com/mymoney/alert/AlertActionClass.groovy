package com.mymoney.alert

public enum AlertActionClass {

    DEFAULT ('btn btn-default'),
    SUCCESS ('btn btn-success'),
    INFO ('btn btn-info'),
    WARNING ('btn btn-warning'),
    DANGER ('btn btn-danger')

    private String name

    private AlertActionClass(String name) {
        this.name = name
    }

    public String getName() {
        return name
    }
}