package uk.ac.ebi.pride.archive.web.util;

/**
 * @author ntoro
 * @since 16/09/2014 09:46
 */
public class SearchUtils {

    /**
     * Customize from SolrJ ClientUtils. Removes *  and ? from the escape characters
     *
     * See: {@link org.apache.lucene.queryparser.classic queryparser syntax}
     * for more information on Escaping Special Characters
     */
    public static String escapeQueryCharsExceptStartAndQuestionMark(String s) {
        //        c == '*' || c == '?' ||
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            // These characters are part of the query syntax and must be escaped
            if (c == '\\' || c == '+' || c == '-' || c == '!'  || c == '(' || c == ')' || c == ':'
                    || c == '^' || c == '[' || c == ']' || c == '\"' || c == '{' || c == '}' || c == '~'
                    || c == '|' || c == '&'  || c == ';' || c == '/'
                    || Character.isWhitespace(c)) {
                sb.append('\\');
            }
            sb.append(c);
        }
        return sb.toString();
    }
}
