component {

	this.title          = "cbstripe";
	this.author         = "Ortus Solutions";
	this.webURL         = "https://www.ortussolutions.com";
	this.description    = "Provides you with integration to Stripe for payments and subscriptions.";
	this.version        = "1.0.0";
	this.entryPoint     = "cbstripe";
	this.modelNamespace = "cbstripe";
	this.cfmapping      = "cbstripe";
	this.dependencies   = [];


	function configure(){
		settings = {
			"secretKey" = "",
			"publishableKey" = ""
		};
	}

}
