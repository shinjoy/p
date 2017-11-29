package ib.basic.web;

import org.springframework.stereotype.Controller;

/**
 * <pre>
 * package  : ib.basic.service.impl
 * filename : MultiFileUpload.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2014. 4. 16.
 * @version : 1.0.0
 */
@Controller
public class UtilReplaceTag {


    public String replaceTag(String Expression, String type){
        String result = "";
        if (Expression==null || Expression.equals("")) return "";

        if (type == "encode") {
            result = replaceString(Expression, "&", "&amp;");
            result = replaceString(result, "\"", "&quot;");

            result = replaceString(result, "'", "&apos;");
            result = replaceString(result, "<", "&lt;");
            result = replaceString(result, ">", "&gt;");
            result = replaceString(result, "\r", "<br>");
            result = replaceString(result, "\n", "<p>");
        }
        else if (type == "decode") {
            result = replaceString(Expression, "&amp;", "&");
            result = replaceString(result, "&quot;", "\"");

            result = replaceString(result, "&apos;", "'");
            result = replaceString(result, "&lt;", "<");
            result = replaceString(result, "&gt;", ">");
            result = replaceString(result, "<br>", "\r");
            result = replaceString(result, "<p>", "\n");
        }

        return result;
    }

    public String replaceString(String Expression, String Pattern, String Rep)
    {
        if (Expression==null || Expression.equals("")) return "";

        int s = 0;
        int e = 0;
        StringBuffer result = new StringBuffer();

        while ((e = Expression.indexOf(Pattern, s)) >= 0) {
            result.append(Expression.substring(s, e));
            result.append(Rep);
            s = e + Pattern.length();
        }
        result.append(Expression.substring(s));
        return result.toString();
    }

}