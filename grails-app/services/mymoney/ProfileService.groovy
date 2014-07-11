package mymoney

import com.mymoney.alert.Alert
import com.mymoney.alert.AlertAction
import com.mymoney.alert.AlertActionClass
import com.mymoney.alert.request.Request
import com.mymoney.config.MyMoneyConstants
import com.mymoney.profile.Address
import com.mymoney.profile.Country
import com.mymoney.profile.FamilyMemberRequest
import com.mymoney.alert.request.RequestStatus
import com.mymoney.profile.FamilyProfile
import com.mymoney.profile.Gender
import com.mymoney.profile.IndividualProfile
import com.mymoney.profile.Profile
import com.mymoney.security.Role
import com.mymoney.security.User
import com.mymoney.security.UserRole

import org.codehaus.groovy.grails.plugins.web.taglib.ValidationTagLib

import grails.transaction.Transactional

@Transactional
class ProfileService {

    def grailsApplication

    def mailService

    /* ------------------------------------------------ */
    /* -------------- GORM Save Methods --------------- */
    /* ------------------------------------------------ */

    User saveUser(Map properties) {
        assert properties?.size() > 0

        String username = properties.username?.toString()

        if (username) {
            User user = User.findByUsername(username)

            if (!user) {
                user = new User()
                user.username = username
                user.accountExpired = false
                user.accountLocked = false
                user.passwordExpired = false
            }

            if (properties.password) {
                user.password = properties.password.toString()
            }

            if (user.save(flush: true)) {
                println "[saveUser] Profile Type: ${properties.profileType}"
                String authority = properties.profileType?.toString()?.equals('Individual') ? MyMoneyConstants.AUTHORITY_ROLE_INDIVIDUAL : MyMoneyConstants.AUTHORITY_ROLE_FAMILY
                findAndAssignRoleToUser(user, authority)

                return user
            }
            else {
                println "[saveUser] Error saving user..."
                user.errors.allErrors.each {
                    println it
                }
            }
        }

        return null
    }

    UserRole findAndAssignRoleToUser(User user, String authority) {
        assert user
        assert authority

        Role role = Role.findByAuthority(authority)

        if (role) {
            UserRole userRole = UserRole.create(user, role, true)

            if (userRole) {
                println "[findAndAssignRoleToUser] Found and assigned role ${role.authority} to user ${user.username}..."
                return userRole
            }
        }

        return null
    }

    Profile saveIndividualProfile(Map properties) {
        assert properties?.size() > 0

        User user = saveUser(properties)

        if (user) {
            Profile individualProfile = new IndividualProfile()
            individualProfile.user = user

            if (properties.firstName) {
                individualProfile.firstName = properties.firstName.toString()
            }
            if (properties.lastName) {
                individualProfile.lastName = properties.lastName.toString()
            }
            if (properties.gender) {
                individualProfile.gender = Gender.valueOf(properties.gender.toString().toUpperCase())
            }
            if (properties.dateOfBirth) {
                individualProfile.dateOfBirth = new Date((long) properties.dateOfBirth)
            }
            if (properties.email) {
                individualProfile.email = properties.email.toString()
            }
            if (properties.phone) {
                individualProfile.phone = properties.phone.toString()
            }

            Address address = saveAddress(properties)

            if (address) {
                individualProfile.address = address
            }

            individualProfile.theme = MyMoneyConstants.THEME_DEFAULT

            Date now = new Date()

            individualProfile.createdDate = now
            individualProfile.lastUpdatedDate = now

            if (individualProfile.save(flush: true)) {
                user.profile = individualProfile
                return individualProfile
            }
            else {
                println "[saveIndividualProfile] Error saving individual profile..."
                individualProfile.errors.allErrors.each {
                    println it
                }
            }
        }

        return null
    }

    Profile saveFamilyProfile(Map properties) {
        assert properties?.size() > 0

        User user = saveUser(properties)

        Date now = new Date()

        if (user) {
            Profile familyProfile = new FamilyProfile()
            familyProfile.user = user

            if (properties?.familyName) {
                familyProfile.familyName = properties.familyName.toString()
            }

            familyProfile.theme = MyMoneyConstants.THEME_DEFAULT

            familyProfile.createdDate = now
            familyProfile.lastUpdatedDate = now

            if (familyProfile.save(flush: true)) {
                if (properties.familyMemberRequests?.size() > 0) {
                    properties.familyMemberRequests?.each {
                        List<IndividualProfile> individuals = lookupIndividualsByUsernameOrEmail(it.toString().trim())

                        individuals.each { IndividualProfile familyMember ->
                            Request familyMemberRequest = new FamilyMemberRequest()
                            familyMemberRequest.familyRequestedFor = (FamilyProfile) familyProfile
                            familyMemberRequest.familyMemberRequested = familyMember
                            familyMemberRequest.requestedDate = now
                            familyMemberRequest.requestStatus = RequestStatus.PENDING

                            if (!familyMemberRequest.save(flush: true)) {
                                println "[saveFamilyProfile] Error saving family member request..."
                                familyMemberRequest.errors.allErrors.each {
                                    println it
                                }
                            }
                            else {
                                // Set up request alert
                                Alert requestAlert = new Alert()

                                requestAlert.alertRecipient = familyMember.user
                                requestAlert.alertHeading = MyMoneyConstants.FAMILY_MEMBER_REQUEST_HEADING

                                String familyUsername = ((FamilyMemberRequest) familyMemberRequest).familyRequestedFor.user.username
                                String familyName = ((FamilyMemberRequest) familyMemberRequest).familyRequestedFor.familyName

                                requestAlert.alertBody = "Review family member request for family '${familyUsername}: ${familyName}'"
                                requestAlert.alertLink = "${grailsApplication.config.grails.serverURL}/profile/reviewFamilyMemberRequest/${familyMemberRequest.id}"

                                requestAlert.dismissed = false

                                List<AlertAction> actions = []

                                actions.add(new AlertAction('Accept', "${grailsApplication.config.grails.serverURL}/profile/acceptFamilyMemberRequest/${familyMemberRequest.id}", AlertActionClass.SUCCESS))
                                actions.add(new AlertAction('Reject', "${grailsApplication.config.grails.serverURL}/profile/rejectFamilyMemberRequest/${familyMemberRequest.id}", AlertActionClass.DANGER))
                                actions.add(new AlertAction('Dismiss', "${grailsApplication.config.grails.serverURL}/profile/dismissFamilyMemberRequest/${familyMemberRequest.id}", AlertActionClass.DEFAULT))

                                requestAlert.actions = actions.collect { it.toString() }.join(MyMoneyConstants.ACTIONS_SEPARATOR)

                                if (!requestAlert.save(flush: true)) {
                                    println "[saveFamilyProfile] Error saving request alert..."
                                    requestAlert.errors.allErrors.each { println it }
                                }
                                else {
                                    familyMemberRequest.requestAlert = requestAlert
                                    familyMemberRequest.save(flush: true)
                                }

                                def g = new ValidationTagLib()
                                // Send request email to user
                                mailService.sendMail {
                                    async true
                                    to familyMember.email
                                    from grailsApplication.config.myMoney.mail.defaultFrom
                                    subject g.message(code: 'myMoney.registration.mail.familyMemberRequest.subject')
                                    html g.render(
                                        template: '/mail/profile/familyMemberRequest',
                                        model: [requestId: familyMemberRequest.id, recipientName: familyMember.firstName]
                                    )
                                }
                            }
                        }
                    }
                }

                user.profile = familyProfile

                return familyProfile
            }
            else {
                println "[saveFamilyProfile] Error saving family profile..."
                familyProfile.errors.allErrors.each {
                    println it
                }
            }
        }

        return null
    }

    Address saveAddress(Map properties) {
        assert properties?.size() > 0

        String line1 = properties.line1?.toString()

        if (line1) {
            Address address = new Address()

            address.line1 = line1

            if (properties.line2) {
                address.line2 = properties.line2.toString()
            }
            if (properties.city) {
                address.city = properties.city.toString()
            }
            if (properties.state) {
                address.state = properties.state.toString()
            }
            if (properties.zipCode) {
                address.zipCode = properties.zipCode.toString()
            }
            if (properties.country) {
                Country country = Country.findByShortName(properties.country.toString())
                if (!country) {
                    country = new Country()
                    country.shortName = properties.country.toString()
                    country.name = properties.countryName?.toString()?: properties.country.toString()
                    country.save()
                }

                address.country = country
            }

            if (address.save(flush: true)) {
                return address
            }
            else {
                println "[saveAddress] Error saving address..."
                address.errors.allErrors.each {
                    println it
                }
            }
        }

        return null
    }

    void acceptFamilyMemberRequest(Long requestId) {
        assert requestId

        FamilyMemberRequest request = FamilyMemberRequest.get(requestId)

        if (request) {
            // First, accept request status
            request.requestStatus = RequestStatus.ACCEPTED

            if (request.save(flush: true)) {
                if (request.requestAlert) {
                    request.requestAlert.dismissed = true
                    request.requestAlert.save(flush: true)
                }
                // Add requested individual to family
                request.familyRequestedFor.addToFamilyMembers(request.familyMemberRequested)
                request.save(flush: true)
                println "[acceptFamilyMemberRequest] Family member request accepted"
            }
        }
    }

    void rejectFamilyMemberRequest(Long requestId) {
        assert requestId

        FamilyMemberRequest request = FamilyMemberRequest.get(requestId)

        if (request) {
            if (request.requestAlert) {
                request.requestAlert.dismissed = true
                request.requestAlert.save(flush: true)
            }
            // Reject request status
            request.requestStatus = RequestStatus.REJECTED
            request.save(flush: true)
            println "[rejectFamilyMemberRequest] Family member request rejected"
        }
    }

    void dismissFamilyMemberRequest(Long requestId) {
        assert requestId

        FamilyMemberRequest request = FamilyMemberRequest.get(requestId)

        if (request && request.requestAlert) {
            request.requestAlert.dismissed = true
            request.requestAlert.save(flush: true)
            println "[dismissFamilyMemberRequest] Family member request dismissed"
        }
    }

    /* ------------------------------------------------ */
    /* -------------- GORM Search Methods ------------- */
    /* ------------------------------------------------ */

    List<IndividualProfile> lookupIndividualsByUsernameOrEmail(String searchString) {
        List<IndividualProfile> individualsLookedUp = []

        String query = """
            select
                i.id as individualId
            from
                IndividualProfile i inner join i.user u
            where
                i.email like '%${searchString}%' or
                u.username like '%${searchString}%'
        """

        println "[lookupIndividualsByUsernameOrEmail] Query:\n${query}"

        List individualIds = IndividualProfile.executeQuery(query)

        println "[lookupIndividualsByUsernameOrEmail] Found ${individualIds.size()} individuals for search string ${searchString}..."

        individualIds?.each {
            IndividualProfile individual = IndividualProfile.get((long) it)

            if (individual) {
                individualsLookedUp << individual
            }
        }

        return individualsLookedUp
    }
}
