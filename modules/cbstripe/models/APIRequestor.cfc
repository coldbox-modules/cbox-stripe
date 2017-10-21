component {

    /*============================================
    =            Dependency Injection            =
    ============================================*/

    property name="populator" inject="wirebox:populator";
    property name="path"      inject="Path@cbstripe";
    property name="wirebox"   inject="wirebox";

    /*===================================
    =            Stripe Keys            =
    ===================================*/

    property name="secretKey"      inject="coldbox:setting:secretKey@cbstripe";
    property name="publishableKey" inject="coldbox:setting:publishableKey@cbstripe";

    /*========================================
    =            Stripe Constants            =
    ========================================*/

    variables.STRIPE_BASE_URL    = "https://api.stripe.com";
    variables.STRIPE_API_VERSION = "v1";

    /*======================================
    =            Public Methods            =
    ======================================*/

    function request(
        endpoint,
        method = "GET",
        headers = {},
        params = {},
        fields = {},
        body = ""
    ) {
        structAppend( headers, {
            "Authorization" = "Bearer #secretKey#"
        } );

        // writeDump( path.join( STRIPE_BASE_URL, STRIPE_API_VERSION, endpoint ) );

        cfhttp(
            url          = path.join( STRIPE_BASE_URL, STRIPE_API_VERSION, endpoint ),
            result       = "local.result",
            method       = method,
            timeout      = 10
        ) {
            for ( var name in headers ) {
                cfhttpparam(
                    type  = "header",
                    name  = name,
                    value = headers[ name ]
                );
            }

            for ( var name in params ) {
                cfhttpparam(
                    type  = "url",
                    name  = name,
                    value = params[ name ]
                );
            }

            for ( var name in fields ) {
                cfhttpparam(
                    type  = "formfield",
                    name  = name,
                    value = fields[ name ]
                );
            }

            if ( ! isSimpleValue( body ) || len( body ) ) {
                cfhttpparam(
                    type = "body",
                    value = isStruct( body ) ? serializeJSON( body ) : body
                );
            }
        };

        if ( left( local.result.responseheader.status_code, 1 ) != 2 ) {
            throw( type = "cbstripe.APIRequestError", message = local.result.filecontent );
        }

        // writeDump( var = local.result, abort = true );

        return populator.populateFromStruct(
            wirebox.getInstance( "APIResponse@cbstripe" ), {
                "statusCode" = local.result.responseheader.status_code,
                "headers"    = local.result.responseheader,
                "body"       = local.result.filecontent,
                "data"       = deserializeJSON( local.result.filecontent )
            }
        );
    }

}
