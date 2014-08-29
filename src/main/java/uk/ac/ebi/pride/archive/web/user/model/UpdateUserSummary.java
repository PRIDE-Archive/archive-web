package uk.ac.ebi.pride.archive.web.user.model;

import uk.ac.ebi.pride.archive.dataprovider.person.UserAuthority;
import uk.ac.ebi.pride.archive.repo.user.service.UserSummary;

import java.util.HashSet;

/**
 * @author Rui Wang
 * @version $Id$
 */
public class UpdateUserSummary extends UserSummary {

    private String existingEmail;
    private String existingPassword;

    /**
     * This constructor is needed by spring framework
     */
    public UpdateUserSummary() {
    }

    public UpdateUserSummary(UserSummary userSummary) {
        this.setId(userSummary.getId());
        this.setEmail(userSummary.getEmail());
        this.setExistingEmail(userSummary.getEmail());
        this.setPassword(userSummary.getPassword());
        this.setTitle(userSummary.getTitle());
        this.setFirstName(userSummary.getFirstName());
        this.setLastName(userSummary.getLastName());
        this.setAffiliation(userSummary.getAffiliation());
        this.setCreateAt(userSummary.getCreateAt());
        this.setUpdateAt(userSummary.getUpdateAt());
        this.setUserAuthorities(new HashSet<UserAuthority>(userSummary.getUserAuthorities()));
    }

    public String getExistingEmail() {
        return existingEmail;
    }

    public void setExistingEmail(String existingEmail) {
        this.existingEmail = existingEmail;
    }

    public String getExistingPassword() {
        return existingPassword;
    }

    public void setExistingPassword(String existingPassword) {
        this.existingPassword = existingPassword;
    }
}
