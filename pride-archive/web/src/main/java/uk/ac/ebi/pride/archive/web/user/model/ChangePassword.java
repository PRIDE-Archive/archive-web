package uk.ac.ebi.pride.archive.web.user.model;

/**
 * Object for changing a user's password
 *
 * @author Rui Wang
 * @version $Id$
 */
public class ChangePassword {
    private String email;
    private String oldPassword;
    private String newPassword;
    private String confirmedNewPassword;

    public ChangePassword() {
    }

    public ChangePassword(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getConfirmedNewPassword() {
        return confirmedNewPassword;
    }

    public void setConfirmedNewPassword(String confirmedNewPassword) {
        this.confirmedNewPassword = confirmedNewPassword;
    }

}
