package com.fortumo.extensions
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class Fortumo extends EventDispatcher
	{	
		private var exContext : ExtensionContext;
		private var consumable : Boolean = true;
		private var displayString : String = null;
		private var productName : String = null;
		private var serviceId : String = null;
		private var appSecret : String = null;
		private var creditsMultiplier : Number = 1.0;
		private var icon : int = -1;
		private var sku : String = null;		
		
		public function Fortumo(target:IEventDispatcher=null)
		{
			super(target);
			this.exContext = ExtensionContext.createExtensionContext("com.fortumo.extension", "fortumo");
			this.exContext.addEventListener(StatusEvent.STATUS, onStatusChange);
		}
		
		public function setConsumable(c : Boolean) : void
		{
			consumable = c;
		}
		
		public function setDisplayString(s : String) : void
		{
			displayString = s;
		}
		
		public function setProductName(n : String) : void
		{
			productName = n;
		}
		
		public function setService(id : String, secret : String) : void
		{
			serviceId = id;
			appSecret = secret;
		}
		
		public function setCreditsMultiplier(m : Number) : void
		{
			creditsMultiplier = m;
		}
		
		public function setIcon(i : int) : void
		{
			icon = i;
		}		
		
		public function setSku(s : String) : void
		{
			sku = s;
		}
		
		public function makePayment() : void
		{
			this.exContext.call("makepayment", consumable, displayString, productName, serviceId, appSecret, creditsMultiplier, icon, sku);
		}
		
		private function onStatusChange(e:StatusEvent):void
		{
			if (e.code == "PAYMENT_CANCELLED" 
				|| e.code == "PAYMENT_FAILED"
				|| e.code == "PAYMENT_PENDING"
				|| e.code == "PAYMENT_SUCCESS")
			{
				this.dispatchEvent(e);
			}
		}
	}
}