/**
* Copyright Since 2005 Ortus Solutions, Corp
* www.coldbox.org | www.luismajano.com | www.ortussolutions.com | www.gocontentbox.org
**************************************************************************************
*/
component{
	this.name = "A TestBox Runner Suite " & hash( getCurrentTemplatePath() );
	// any other application.cfc stuff goes below:
	this.sessionManagement = true;
	// Turn on/off white space managemetn
	this.whiteSpaceManagement = "smart";

	// any mappings go here, we create one that points to the root called test.
	this.mappings[ "/tests" ] = getDirectoryFromPath( getCurrentTemplatePath() );
	rootPath = REReplaceNoCase( this.mappings[ "/tests" ], "tests(\\|/)", "" );
	this.mappings[ "/root" ]   = rootPath;

	//example CF Mappings
	//this.mappings[ "/cbvalidation" ] 	= rootPath & "modules/cbvalidation";
	//this.mappings[ "/mymodule" ]   	= rootPath & "modules/mymodule";

	// any orm definitions go here.

	// request start
	public boolean function onRequestStart( String targetPage ){
		return true;
	}
}
