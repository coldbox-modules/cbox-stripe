component {

    property name="str" inject="Str@Str";

    function init() {
        variables.md = getMetadata( this );
    }

    function populate( stripeData = {} ) {
        for ( var key in stripeData ) {
            if ( hasProperty( str.camel( key ) ) ) {
                invoke( this, "set" & str.camel( key ), {
                    1 = ifNull( stripeData, key, "" )
                } );
            }
        }
        return this;
    }

    private function hasProperty( propertyName ) {
        return md.properties.filter( function( property ) {
            return property.name == propertyName;
        } ).len() > 0;
    }

    private function ifNull( data, key, defaultValue ) {
        return structKeyExists( data, key ) && ! isNull( data[ key ] ) ? data[ key ] : defaultValue;
    }

}
