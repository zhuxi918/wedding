/**
 * @session��cookie
 * @author yyy
 */

var session = function(){
	this.init = function(data, url, success_callback, error_callback){
		this.data = data;
		this.url = url;

		if(!success_callback || typeof success_callback != "function"){
			this.success_callback = function(){}
		}else{
			this.success_callback = success_callback;
		}
		if(!error_callback || typeof success_callback != "function"){
			this.error_callback = function(){}
		}else{
			this.error_callback = error_callback;
		}
	}

	this.setSession = function(){
		//console.log(this.success_callback);
		$.ajax({
			url : this.url,
			data : this.data,
			dataType : 'text',
			type : 'post',
			success : this.success_callback,
			error : this.error_callback
		})
	};
	this.setCookie = function(expiresHours){
		for(var i in this.data){
			this.addCookie(i, this.data[i], expiresHours);
		}
	};
	this.addCookie = function (name,value,expiresHours){

		var cookieString=name+"="+value;

		if(expiresHours>0){
			var date=new Date();
			date.setTime(date.getTime()+expiresHours*3600*1000);
			cookieString=cookieString+"; expires="+date.toGMTString()+" ;path=/";
		}
		document.cookie=cookieString;
	}

	this.getCookie = function getCookie(name){
		var strCookie=document.cookie;
		var arrCookie=strCookie.split("; ");
		for(var i=0;i<arrCookie.length;i++){
			var arr=arrCookie[i].split("=");
			if(arr[0]==name)return decodeURI(arr[1]);
		}
		return "";
	}
	this.deleteCookie = function (name){
		var date=new Date();
		date.setTime(date.getTime()-10000);
		document.cookie=name+"=v; expires="+date.toGMTString();
	}
}