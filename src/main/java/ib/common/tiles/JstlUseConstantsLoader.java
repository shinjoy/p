package ib.common.tiles;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

public class JstlUseConstantsLoader {

    public static Class loadClass(String className)
        throws ClassNotFoundException
    {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        if(classLoader == null)
            classLoader = (ib.common.tiles.JstlUseConstantsLoader.class).getClassLoader();
        return classLoader.loadClass(className);
    }

    public static Object createInstance(String className)
        throws ClassNotFoundException, IllegalAccessException, InstantiationException
    {
        return loadClass(className).newInstance();
    }

    public static Map getClassConstants(String className)
        throws ClassNotFoundException, IllegalArgumentException, IllegalAccessException
    {
        Map constants = new HashMap();
        Class clazz = loadClass(className);
        Field fields[] = clazz.getFields();
        for(int i = 0; i < fields.length; i++)
        {
            Field field = fields[i];
            int modifiers = field.getModifiers();
            if((modifiers & 8) == 0 || (modifiers & 0x10) == 0)
                continue;
            Object value = field.get(null);
            if(value != null)
                constants.put(field.getName(), value);
        }

        return constants;
    }
}
