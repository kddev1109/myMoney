package mymoney

import com.mymoney.profile.FamilyMemberRequest
import com.mymoney.alert.request.RequestStatus
import com.mymoney.profile.FamilyProfile
import com.mymoney.profile.IndividualProfile
import com.mymoney.profile.Profile
import com.mymoney.security.User

import java.text.SimpleDateFormat

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class ProfileController {

    def profileService

    def springSecurityService

    @Secured(['ROLE_INDIVIDUAL', 'ROLE_FAMILY'])
    def index() {
        Long userId = params.long('id', -1)

        User currentUser = (User) springSecurityService.currentUser

        if (userId && userId == currentUser.id) {
            User user = User.get(userId)

            if (user) {
                Profile profile = user.profile

                def profileDetailsProperties = []

                if (profile && profile instanceof IndividualProfile) {
                    profileDetailsProperties = [
                        accountInformation: [
                            [
                                key: g.message(code: 'myMoney.profile.accountInformation.username'),
                                value: profile.user.username
                            ]
                        ],
                        individualUserInformation: [
                            [
                                key: g.message(code: 'myMoney.profile.individualUserInformation.firstName'),
                                value: profile.firstName,
                                type: 'text',
                                required: true
                            ],
                            [
                                key: g.message(code: 'myMoney.profile.individualUserInformation.lastName'),
                                value: profile.lastName ?: '',
                                type: 'text',
                                required: false
                            ],
                            [
                                key: g.message(code: 'myMoney.profile.individualUserInformation.gender'),
                                value: profile.gender?.name ?: '',
                                type: 'btn-group'
                            ],
                            [
                                key: g.message(code: 'myMoney.profile.individualUserInformation.dateOfBirth'),
                                value: profile.dateOfBirth ? new SimpleDateFormat("MM/dd/yyyy").format(profile.dateOfBirth) : '',
                                type: 'date',
                                required: false
                            ]
                        ],
                        contactInformation: [
                            [
                                key: g.message(code: 'myMoney.profile.contactInformation.email'),
                                value: profile.email,
                                type: 'email'
                            ],
                            [
                                key: g.message(code: 'myMoney.profile.contactInformation.phone'),
                                value: profile.phone,
                                type: 'email'
                            ],
                            [
                                key: g.message(code: 'myMoney.profile.contactInformation.address.line1'),
                                value: profile.address?.line1 ?: '',
                                type: 'text'
                            ],
                            [
                                key: g.message(code: 'myMoney.profile.contactInformation.address.line2'),
                                value: profile.address?.line2 ?: '',
                                type: 'text'
                            ],
                            [
                                key: g.message(code: 'myMoney.profile.contactInformation.address.city'),
                                value: profile.address?.city ?: '',
                                type: 'text'
                            ],
                            [
                                key: g.message(code: 'myMoney.profile.contactInformation.address.state'),
                                value: profile.address?.state ?: '',
                                type: 'text'
                            ],
                            [
                                key: g.message(code: 'myMoney.profile.contactInformation.address.zipCode'),
                                value: profile.address?.zipCode ?: '',
                                type: 'text'
                            ],
                            [
                                key: g.message(code: 'myMoney.profile.contactInformation.address.country'),
                                value: profile.address?.country ? profile.address.country.name : '',
                                type: 'text'
                            ]
                        ]
                    ]
                }
                else if (profile && profile instanceof FamilyProfile) {
                    profileDetailsProperties = [
                        accountInformation: [
                            [
                                key: g.message(code: 'myMoney.profile.accountInformation.username'),
                                value: profile.user.username
                            ]
                        ]
                    ]
                }

                render(
                    view: '/profile/profileDetails',
                    model: [activeNav: 'Profile', profileDetailsProperties: profileDetailsProperties, profileId: profile?.id]
                )
            }
        }
        else {
            redirect(controller: 'home', action: 'index')
        }
    }

    @Secured('permitAll')
    def register() {
        render(view: '/profile/registration/registrationPage', model: [activeNav: 'Profile'])
    }

    @Secured('permitAll')
    def checkUsernameAvailability() {
        withFormat {
            json {
                String username = request.JSON?.username?.toString()

                def results = [:]

                if (username) {
                    results.isAvailable = !User.findByUsername(username)
                }

                render(results as JSON)
            }
        }
    }

    @Secured('permitAll')
    def checkEmailAvailability() {
        withFormat {
            json {
                String email = request.JSON?.email?.toString()

                def results = [:]

                if (email) {
                    results.isAvailable = !IndividualProfile.findByEmail(email)
                }

                render(results as JSON)
            }
        }
    }

    @Secured('permitAll')
    def submitRegistrationDetails() {
        withFormat {
            json {
                if (log.isDebugEnabled()) {
                    log.debug("[submitRegistrationDetails] Request JSON: ${request.JSON}")
                }

                println "[submitRegistrationDetails] Request JSON:\n${request.JSON}"

                String profileType = request.JSON?.profileType?.toString()

                if (profileType.equals('Individual')) {
                    profileService.saveIndividualProfile((Map) request.JSON)
                }
                else if (profileType.equals('Family')) {
                    profileService.saveFamilyProfile((Map) request.JSON)
                }

                def results = [
                    success: true,
                    url: g.createLink(controller: 'home', action: 'index')
                ]

                render(results as JSON)
            }
        }
    }

    @Secured('permitAll')
    def lookupIndividualsByUsernameOrEmail() {
        withFormat {
            json {
                String searchString = request.JSON?.searchString

                def results = [
                    individuals: []
                ]

                if (searchString) {
                    List<IndividualProfile> individuals = profileService.lookupIndividualsByUsernameOrEmail(searchString)

                    results.individuals = individuals.collect {
                        return [
                            username: it.user.username,
                            email: it.email,
                            name: it.name
                        ]
                    }
                }

                println "[lookupIndividualsByUsernameOrEmail] Results: ${results}"

                render(results as JSON)
            }
        }
    }

    @Secured(['ROLE_INDIVIDUAL'])
    def reviewFamilyMemberRequest() {
        Long requestId = params.long('id', -1L)

        User currentUser = (User) springSecurityService.currentUser

        if (requestId > 0L) {
            FamilyMemberRequest request = FamilyMemberRequest.get(requestId)

            if (request &&
                (currentUser?.username?.equals(request.familyMemberRequested.user.username)) &&
                (request.requestStatus == RequestStatus.PENDING)) {
                def requestDetails = [
                    familyUsername: request.familyRequestedFor.user.username,
                    familyName: request.familyRequestedFor.familyName,
                    familyMembers: request.familyRequestedFor.familyMembers.collect { IndividualProfile familyMember ->
                        return [
                            memberUsername: familyMember.user.username,
                            memberEmail: familyMember.email,
                            memberName: familyMember.name
                        ]
                    }
                ]

                render(view: '/profile/registration/reviewFamilyMemberRequest', model: [requestId: requestId, requestDetails: requestDetails])
            }
            else {
                redirect(controller: 'home', action: 'index')
            }
        }
        else {
            redirect(controller: 'home', action: 'index')
        }
    }

    @Secured(['ROLE_INDIVIDUAL'])
    def acceptFamilyMemberRequest() {
        withFormat {
            json {
                Long requestId = params.long('id', -1)

                println "[acceptFamilyMemberRequest] Request Id: $requestId"

                profileService.acceptFamilyMemberRequest(requestId)

                render([redirectUrl: "${grailsApplication.config.grails.serverURL}/home"] as JSON)
            }
        }
    }

    @Secured(['ROLE_INDIVIDUAL'])
    def rejectFamilyMemberRequest() {
        withFormat {
            json {
                Long requestId = params.long('id', -1)

                println "[rejectFamilyMemberRequest] Request Id: $requestId"

                profileService.rejectFamilyMemberRequest(requestId)

                render([redirectUrl: "${grailsApplication.config.grails.serverURL}/home"] as JSON)
            }
        }
    }

    @Secured(['ROLE_INDIVIDUAL'])
    def dismissFamilyMemberRequest() {
        withFormat {
            json {
                Long requestId = params.long('id', -1)

                println "[dimsissFamilyMemberRequest] Request Id: $requestId"

                profileService.dismissFamilyMemberRequest(requestId)

                render([redirectUrl: "${grailsApplication.config.grails.serverURL}/home"] as JSON)
            }
        }
    }

    @Secured(['ROLE_INDIVIDUAL', 'ROLE_FAMILY'])
    def verifyCurrentPassword() {
        withFormat {
            json {
                println "[verifyCurrentPassword] Request JSON: ${request.JSON}"

                def username = request.JSON?.username?.toString()
                def currentPassword = request.JSON?.currentPassword?.toString()

                def results = [
                    valid: false
                ]

                if (username && currentPassword) {
                    User currentUser = (User) springSecurityService.currentUser

                    if (currentUser) {
                        springSecurityService.reauthenticate(username, currentPassword)

                        results.valid = (springSecurityService.isLoggedIn())
                    }
                }

                println "[verifyCurrentPassword] Results: ${results}"

                render(results as JSON)
            }
        }
    }

    @Secured(['ROLE_INDIVIDUAL', 'ROLE_FAMILY'])
    def updatePassword() {
        withFormat {
            json {
                def newPassword = request.JSON?.password?.toString()

                def results = [
                    success: false
                ]

                if (newPassword) {
                    User currentUser = (User) springSecurityService.currentUser

                    if (currentUser) {
                        currentUser.password = newPassword

                        if (currentUser.save(flush: true)) {
                            results.success = true
                        }
                        else {
                            println "[updatePassword] Error updating user password..."
                            currentUser.errors.allErrors.each { println it }
                        }
                    }
                }

                render(results as JSON)
            }
        }
    }
}
