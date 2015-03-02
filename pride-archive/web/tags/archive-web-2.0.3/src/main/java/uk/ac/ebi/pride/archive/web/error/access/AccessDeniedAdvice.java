package uk.ac.ebi.pride.archive.web.error.access;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;

import java.security.Principal;

/**
 * @author Jose A. Dianes
 * @author Rui Wang
 * @version $Id$
 */
@ControllerAdvice
public class AccessDeniedAdvice {

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private PageMaker pageMaker;

    @ExceptionHandler(AccessDeniedException.class)
    public ModelAndView handleAccessDeniedException(AccessDeniedException ex, Principal principal) {
        ModelAndView modelAndView = new ModelAndView();

        if (principal != null) {
            String errorTitle = messageSource.getMessage("error.access.denied", null, null);
            String errorMessage = messageSource.getMessage("error.resource.access.denied", null, null);
            modelAndView = pageMaker.createErrorPage(errorTitle, errorMessage);
        } else {
            String errorMessage = messageSource.getMessage("error.login.required", null, null);
            return pageMaker.createUserLoginPage(errorMessage);
        }

        return modelAndView;
    }
}
