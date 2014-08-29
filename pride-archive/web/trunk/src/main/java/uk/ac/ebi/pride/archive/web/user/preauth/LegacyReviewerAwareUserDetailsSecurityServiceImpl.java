package uk.ac.ebi.pride.archive.web.user.preauth;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import uk.ac.ebi.pride.archive.repo.user.UserRepository;
import uk.ac.ebi.pride.archive.security.framework.UserDetailsSecurityServiceImpl;

/**
 * @author Rui Wang
 * @version $Id$
 */
public class LegacyReviewerAwareUserDetailsSecurityServiceImpl extends UserDetailsSecurityServiceImpl{
    private static final String REVIEWER = "review";
    private static final String EMAIL_SIGN = "@";
    private static final String EBI_EMAIL_DOMAIN = "ebi.ac.uk";

    public LegacyReviewerAwareUserDetailsSecurityServiceImpl(UserRepository userRepository) {
        super(userRepository);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        if (username != null && username.toLowerCase().startsWith(REVIEWER) && !username.contains(EMAIL_SIGN)) {
            username += EMAIL_SIGN + EBI_EMAIL_DOMAIN;
        }

        return super.loadUserByUsername(username);
    }
}
