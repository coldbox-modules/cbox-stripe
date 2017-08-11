/**
*********************************************************************************
* Your Copyright
********************************************************************************
*/
component{

	// Module Properties
	this.title 				= "cbstripe";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "Provides you with integration to Stripe for payments and subscriptions.";
	this.version			= "@build.version@+@build.number@";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "cbstripe";
	// Model Namespace
	this.modelNamespace		= "cbstripe";
	// CF Mapping
	this.cfmapping			= "cbstripe";
	// Auto-map models
	this.autoMapModels		= true;
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies		= [ ];

	/**
	* Configure module
	*/
	function configure(){
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		
	}

}
