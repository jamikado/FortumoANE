package com.fortumo.android.extension;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

public class ExtensionContext extends FREContext
{
	@Override
	public Map<String, FREFunction> getFunctions()
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		functionMap.put("makepayment", new MakePaymentFunction());
	    return functionMap;
	}

	@Override
	public void dispose()
	{
	}
}
