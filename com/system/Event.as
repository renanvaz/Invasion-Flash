package com.system {

	public class Event {
		public var context;
		public var events:Object;

		public function Event(context){
			this.context = context;
			this.events = {};
		}

		public function bind (name, fn){
			if(!this.events[name]){
				this.events[name] = [fn];
			}else{
				this.events[name].push(fn);
			}
		};

		public function trigger(name, params = null){
			if(this.events[name])
			for(var i = 0; i < this.events[name].length; i++){
				this.events[name][i](params);
			}
		};

	}

}
