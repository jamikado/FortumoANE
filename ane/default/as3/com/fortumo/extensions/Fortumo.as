package com.fortumo.extensions
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Fortumo extends EventDispatcher
	{	
		public function Fortumo(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function setConsumable(c : Boolean) : void
		{
			trace("Fortumo: setConsumable called");
		}
		
		public function setDisplayString(s : String) : void
		{
			trace("Fortumo: setDisplayString called");
		}
		
		public function setProductName(n : String) : void
		{
			trace("Fortumo: setProductName called");
		}
		
		public function setService(id : String, secret : String) : void
		{
			trace("Fortumo: setService called");
		}
		
		public function setCreditsMultiplier(m : Number) : void
		{
			trace("Fortumo: setCreditsMultiplier called");
		}
		
		public function setIcon(i : int) : void
		{
			trace("Fortumo: setIcon called");
		}		
		
		public function setSku(s : String) : void
		{
			trace("Fortumo: setSku called");
		}
		
		public function makePayment() : void
		{
			trace("Fortumo: makePayment called");
		}
	}
}