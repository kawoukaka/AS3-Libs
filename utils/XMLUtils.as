
package com.kaka.utils{
	public class XMLUtils {

		public function XMLUtils() {
		}

		static public  function to(dp:XML,ignoreNamespace:Boolean=false):Object {
			if (dp) {
				var _obj={};
				dp.ignoreWhitespace=true;
				pNode(dp,_obj,ignoreNamespace);
				return _obj;
			}
			return null;
		}

		static private  function pNode(node,obj:Object,ignoreNamespace:Boolean):void {
			//
			if (ignoreNamespace) {
				node.setNamespace("");
			}//
			var nodeName=node.name().toString();
			var o:Object={};
			var j;
			trace(nodeName)
			if (node.attributes().length() > 0) {
				for (j in node.attributes()) {
					o[node.attributes()[j].name().toString()] = node.attributes()[j];
					trace("-attributes--"+node.attributes()[j].name().toString()+":"+node.attributes()[j])
				}
				if (node.children().length() <= 1 && o["value"] == undefined) {
					o["value"]=node.toString();
				}
			} else {
				if (node.children().length() <= 1 && ! node.hasComplexContent()) {
					o=node.toString();
				}
			}
			//------------------------------
			if (obj[nodeName] == undefined) {
				obj[nodeName] = o;
				trace(nodeName+"::"+o)
			} else {
				if (obj[nodeName] is Array) {
					obj[nodeName].push(o);
				} else {
					obj[nodeName]=[obj[nodeName],o];
				}
				trace("obj[" + nodeName + "]" )
				for (var i in obj[nodeName])
				{
					trace(i+":"+obj[nodeName][i])
				}
			}
			try {
				toObj(node,obj[nodeName],ignoreNamespace);
			} catch (e) {
			}
		}
		static private  function toObj(dp:XML,obj:Object,ignoreNamespace:Boolean):void {
			var i,j,nodeName,nl;
			nl=dp.children().length();
			for (i=0; i < nl; i++) {
				var node=dp.children()[i];
				if (obj is Array) {
					pNode(node,obj[obj.length - 1],ignoreNamespace);
				} else {
					pNode(node,obj,ignoreNamespace);
				}//
			}
		}
	}
}