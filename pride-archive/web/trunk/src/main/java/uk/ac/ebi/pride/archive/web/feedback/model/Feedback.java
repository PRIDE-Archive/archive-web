package uk.ac.ebi.pride.archive.web.feedback.model;

/**
 * @author Rui Wang
 * @version $Id$
 */
public class Feedback {
    private String comment;
    private String email;

    public Feedback() {
    }

    public Feedback(String comment, String email) {
        this.comment = comment;
        this.email = email;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
