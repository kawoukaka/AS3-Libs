package com.kaka{
		
	import flash.net.navigateToURL;
	import flash.net.*;
	import flash.external.ExternalInterface;

	public function class ToURL
	{
		public function open(url:String, target:String = '_blank'):void
		{
			var req:URLRequest = new URLRequest(url);
			if (!ExternalInterface.available)
			{
				return navigateToURL(req, target);
			}
			if (/safari|opera/i.test(ExternalInterface.call('function(){return navigator.userAgent}') || 'opera'))
			{
				navigateToURL(req, target);
			}
			else
			{
				ExternalInterface.call("function(){window.open('" + toURLString(req) + "','" + target + "');}");
			}
		}
		public  function toURLString(req:URLRequest):String
		{
			var params:String = req.data ? URLVariables(req.data).toString() : '';
			if ((req.method == URLRequestMethod.POST) || !params)
			{
				return req.url;
			}
			return req.url + '?' + params;
		}
	}
}