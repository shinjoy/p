package ib.common.tiles;

import java.util.Map;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.TagSupport;

public class JstlUseConstantsTag extends TagSupport{


    public String getClassName()
    {
        return className;
    }

    public void setClassName(String className)
    {
        this.className = className;
    }

    public String getScope()
    {
        return scope;
    }

    public void setScope(String scope)
    {
        this.scope = scope;
    }

    public String getVar()
    {
        return var;
    }

    public void setVar(String var)
    {
        this.var = var;
    }

    public int doStartTag()
        throws JspException
    {
        int scope = JstlUseConstantsTag.getScope(this.scope, 1);
        if(className != null && var != null)
        {
            Map constants = null;
            try
            {
                constants = JstlUseConstantsLoader.getClassConstants(className);
            }
            catch(ClassNotFoundException e)
            {
                throw new JspTagException("Class not found: " + className);
            }
            catch(IllegalArgumentException e)
            {
                throw new JspTagException("Illegal argument: " + className);
            }
            catch(IllegalAccessException e)
            {
                throw new JspTagException("Illegal access: " + className);
            }
            if(constants != null && !constants.isEmpty())
                pageContext.setAttribute(var, constants, scope);
        }
        return 0;
    }

    public void release()
    {
        super.release();
        className = null;
        scope = null;
        var = null;
    }

    private String className;
    private String scope;
    private String var;

    public static int getScope(String scope, int defaultScope)
        throws JspException
    {
        int pcscope;
        if(scope == null)
            switch(defaultScope)
            {
            case 1: // '\001'
            case 2: // '\002'
            case 3: // '\003'
            case 4: // '\004'
                pcscope = defaultScope;
                break;

            default:
                throw new JspTagException("Invalid default scope: " + defaultScope);
            }
        else
        if("page".equals(scope))
            pcscope = 1;
        else
        if("request".equals(scope))
            pcscope = 2;
        else
        if("session".equals(scope))
            pcscope = 3;
        else
        if("application".equals(scope))
            pcscope = 4;
        else
            throw new JspTagException("Invalid scope name: " + scope);
        return pcscope;
    }
}
