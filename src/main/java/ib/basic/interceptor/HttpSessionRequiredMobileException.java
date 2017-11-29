package ib.basic.interceptor;

import javax.servlet.ServletException;

public class HttpSessionRequiredMobileException extends ServletException{

	private static final long serialVersionUID = 1L;

	
	public HttpSessionRequiredMobileException(String msg) {
		super(msg);
	}
}
