package uk.ac.ebi.pride.archive.web.user.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import uk.ac.ebi.pride.archive.web.user.model.UpdateUserSummary;
import uk.ac.ebi.pride.archive.repo.user.service.UserService;
import uk.ac.ebi.pride.archive.repo.user.service.UserSummary;
import uk.ac.ebi.pride.archive.repo.user.service.validation.UserSummaryValidator;

/**
 * @author Rui Wang
 * @version $Id$
 */
@Component
public class UpdateUserSummaryValidator extends UserSummaryValidator {

    public static final String PASSWORD_NOT_MATCH_ERROR_MESSAGE = "Password does not match existing password";

    protected PasswordEncoder passwordEncoder;

    @Autowired
    public UpdateUserSummaryValidator(UserService userServiceImpl, PasswordEncoder passwordEncoder) {
        super(userServiceImpl);
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return UpdateUserSummary.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        UpdateUserSummary updateUserSummary = (UpdateUserSummary)target;

        // validate new email address doesn't exist
        String newEmail = updateUserSummary.getEmail();
        if (!updateUserSummary.getExistingEmail().equals(newEmail)) {
            validateEmail(updateUserSummary, errors);
        }

        // validate password
        if (updateUserSummary.getPassword() !=  null) {
            validateExistingPassword(updateUserSummary, errors);

            UserSummary originalUser = userServiceImpl.findByEmail(updateUserSummary.getExistingEmail());
            validateMatchingExistingPassword(originalUser.getPassword(), updateUserSummary.getExistingPassword(), errors);
        }

        // validate contact details
        validateContactDetails(updateUserSummary, errors);
    }

    protected void validateExistingPassword(Object target, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "existingPassword", "required", PASSWORD_ERROR_MESSAGE);
    }


    protected void validateMatchingExistingPassword(String encodedExistingPassword, String password, Errors errors) {
        if (!passwordEncoder.matches(password, encodedExistingPassword)) {
            errors.rejectValue("existingPassword", "required", null, PASSWORD_NOT_MATCH_ERROR_MESSAGE);
        }
    }
}