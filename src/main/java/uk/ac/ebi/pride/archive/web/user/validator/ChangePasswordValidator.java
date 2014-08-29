package uk.ac.ebi.pride.archive.web.user.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import uk.ac.ebi.pride.archive.web.user.model.ChangePassword;
import uk.ac.ebi.pride.archive.repo.user.service.UserService;
import uk.ac.ebi.pride.archive.repo.user.service.UserSummary;
import uk.ac.ebi.pride.archive.repo.user.service.validation.UserSummaryValidator;

/**
 * @author Rui Wang
 * @version $Id$
 */
@Component
public class ChangePasswordValidator extends UserSummaryValidator {

    public static final String PASSWORD_MUST_BE_SAME_MESSAGE = "New passwords must be the same";
    public static final String PASSWORD_NOT_MATCH_ERROR_MESSAGE = "Password does not match existing password";

    private PasswordEncoder passwordEncoder;

    @Autowired
    public ChangePasswordValidator(UserService userServiceImpl, PasswordEncoder passwordEncoder) {
        super(userServiceImpl);
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return ChangePassword.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        ChangePassword changePassword = (ChangePassword) target;

        // check no empty passwords
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "oldPassword", "required", PASSWORD_ERROR_MESSAGE);
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "newPassword", "required", PASSWORD_ERROR_MESSAGE);
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmedNewPassword", "required", PASSWORD_ERROR_MESSAGE);


        if (!errors.hasErrors()) {
            // check new password and confirmed password are the same
            if (!changePassword.getNewPassword().equals(changePassword.getConfirmedNewPassword())) {
                errors.rejectValue("newPassword", "required", null, PASSWORD_MUST_BE_SAME_MESSAGE);
                errors.rejectValue("confirmedNewPassword", "required", null, PASSWORD_MUST_BE_SAME_MESSAGE);
            }

            // check old password is correct
            String email = changePassword.getEmail();
            UserSummary originalUser = userServiceImpl.findByEmail(email);
            validateMatchingExistingPassword(originalUser.getPassword(), changePassword.getOldPassword(), errors);
        }
    }


    private void validateMatchingExistingPassword(String encodedExistingPassword, String password, Errors errors) {
        if (!passwordEncoder.matches(password, encodedExistingPassword)) {
            errors.rejectValue("oldPassword", "required", null, PASSWORD_NOT_MATCH_ERROR_MESSAGE);
        }
    }
}
