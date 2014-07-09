import java.text.SimpleDateFormat

import grails.plugin.springsecurity.SpringSecurityUtils

easygrid {
    formats {
        accountNumberDisplay = { accountNumber ->
            int length = accountNumber.toString().length()

            String displayAccountNumber = ""

            (length - 4).times { displayAccountNumber +=  "*" }

            return "${displayAccountNumber}${accountNumber.toString().substring(length - 4, length)}"
        }
        gridDateFormat = { Date date ->
            return new SimpleDateFormat('MM/dd/yyyy').format(date)
        }
    }

    defaults {
        //un-comment if you use spring security or implement your own with your framework
        securityProvider = { grid, oper ->
            return true

            if (!grid.roles) {
                return true
            }

            def grantedRoles
            if (Map.isAssignableFrom(grid.roles.getClass())) {
                grantedRoles = grid.roles.findAll { op, role -> oper == op }.collect { op, role -> role }
            }
            else if (List.isAssignableFrom(grid.roles.getClass())) {
                grantedRoles = grid.roles
            }
            else {
                grantedRoles = [grid.roles]
            }

            SpringSecurityUtils.ifAllGranted(grantedRoles.join(','))
        }

    }
}
            