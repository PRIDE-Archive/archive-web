package uk.ac.ebi.pride.archive.web.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import uk.ac.ebi.pride.archive.security.user.UserSecureReadOnlyService;
import uk.ac.ebi.pride.archive.security.user.UserSecureService;
import uk.ac.ebi.pride.archive.web.util.PageMaker;

import javax.servlet.http.HttpServletRequest;

/**
 * Abstract user profile controller to provide common dependency injections and auto login
 *
 * @author Rui Wang
 * @version $Id$
 */
abstract class AbstractUserProfileController {
    private static final Logger logger = LoggerFactory.getLogger(AbstractUserProfileController.class);

    @Autowired
    protected UserSecureReadOnlyService userSecureReadOnlyService;

    @Autowired
    protected UserSecureService userSecureServiceWebService;

    @Autowired
    protected AuthenticationManager authenticationManager;

    @Autowired
    protected PageMaker pageMaker;

    void doAutoLogin(String username, String password, HttpServletRequest request) {
        try {
            // Must be called from request filtered by Spring Security, otherwise SecurityContextHolder is not updated
            UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, password);
            token.setDetails(new WebAuthenticationDetails(request));
            Authentication authentication = authenticationManager.authenticate(token);
            logger.debug("Logging in with [{}]", authentication.getPrincipal());
            SecurityContextHolder.getContext().setAuthentication(authentication);
        } catch (Exception e) {
            SecurityContextHolder.getContext().setAuthentication(null);
            logger.error("Failure in autoLogin", e);
        }
    }
}
