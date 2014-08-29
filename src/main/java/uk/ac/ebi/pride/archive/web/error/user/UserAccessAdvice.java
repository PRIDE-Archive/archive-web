package uk.ac.ebi.pride.archive.web.error.user;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;
import uk.ac.ebi.pride.archive.repo.user.service.UserAccessException;

/**
 * @author Rui Wang
 * @version $Id$
 */
@ControllerAdvice
public class UserAccessAdvice {

    private static final Logger logger = LoggerFactory.getLogger(UserAccessAdvice.class);

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private PageMaker pageMaker;


    @ExceptionHandler(UserAccessException.class)
    public ModelAndView handleUserAccessException(UserAccessException ex) {

        logger.error(ex.getMessage(), ex);

        String errorTitle = messageSource.getMessage("error.user", null, null);
        String errorMessage = messageSource.getMessage("error.access.user", null, null);

        String email = ex.getEmail();
        if (email != null) {
            errorMessage += " ( User: " + email+ ")";
        }

        return pageMaker.createErrorPage(errorTitle, errorMessage);
    }
}
