package mymoney

import com.mymoney.bankAccount.BankAccountType

import grails.plugin.springsecurity.annotation.Secured

class BankAccountController {

    @Secured(['ROLE_INDIVIDUAL'])
    def newBankAccount() {
        render(
            view: '/home/homePage',
            model: [
                activeNav: 'Home',
                activeSubNav: 'Accounts',
                template: '/bankAccount/newBankAccount',
                accountTypes: BankAccountType.values().collect {
                    return [
                        id: it.name(),
                        name: it.name
                    ]
                }
            ]
        )
    }
}
