package uk.ac.ebi.pride.archive.web.user.service.aap;

/*
* This class helps to utilize the Authorization module of AAP security service
* */

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.net.ssl.HttpsURLConnection;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;

@Component
public class AuthorizationHandlerService {

    private String aapAuthUrl;

    public AuthorizationHandlerService() {
    }

    @Autowired
    public AuthorizationHandlerService(@Value("${user.aap.create.url}")String aapAuthUrl) {
        this.aapAuthUrl = aapAuthUrl;
    }

    public boolean changePassword(String email, String oldPwd, String newPwd){
        boolean isPwdUpdated = false;

        try{

            URL url = new URL(aapAuthUrl+"?_method=patch");
            HttpsURLConnection conn = (HttpsURLConnection ) url.openConnection();
            //conn.setRequestMethod("PATCH"); doesn't work and gives an invalid req.
            //try the workaround below
            //conn.setRequestProperty("X-HTTP-Method-Override", "PATCH");
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Accept", "application/json");
            conn.setRequestProperty("Content-Type","application/json");

            //Set authorization headers
            String userCredentials = email+":"+oldPwd;
            String basicAuth = "Basic " + new String(Base64.getEncoder().encode(userCredentials.getBytes()));
            conn.setRequestProperty ("Authorization", basicAuth);

            //update credentials
            String input = "{\"password\":\""+newPwd+"\"}";

            //pass data object to http req
            conn.setDoOutput(true);
            conn.setDoInput(true);
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes());
            os.flush();

            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                throw new RuntimeException("Failed : HTTP error code : "
                        + responseCode);
            }

            conn.disconnect();

            isPwdUpdated = true;
        }catch(Exception e){
            e.printStackTrace();
        }

        return isPwdUpdated;
    }

}
