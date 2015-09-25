package com.kaka{
		
	import flash.net.navigateToURL;
	import flash.net.*;
	import flash.external.ExternalInterface;

	public function GetURL(url:String, target:String = null){
		
		try {
			navigateToURL(new URLRequest(url), target);
		}catch(error:Error){
			trace("[getURL] "+error);
		}
		
	}
	
}
