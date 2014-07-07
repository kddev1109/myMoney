import com.mymoney.security.Role
import com.mymoney.security.User
import com.mymoney.security.UserRole

class BootStrap {

    def init = { servletContext ->

        def individualRole = Role.findOrSaveWhere(authority: 'ROLE_INDIVIDUAL')
        def familyRole = Role.findOrSaveWhere(authority: 'ROLE_FAMILY')
    }
    def destroy = {
    }
}
