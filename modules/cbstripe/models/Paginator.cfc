component accessors="true" {

    property name="data";
    property name="service";
    property name="method";
    property name="defaultParams";
    property name="hasMore" default="false";

    function init() {
        variables.defaultParams = {};
        return this;
    }

    function setDefaultParams( params = {} ) {
        variables.defaultParams = arguments.params.filter( function( key, value ) {
            return key != "ending_before" || key != "starting_after";
        } );
        return this;
    }

    function previous() {
        return invoke( getService(), getMethod(), {
            params = { "ending_before" = first().getId() }
        } );
    }

    function next() {
        return invoke( getService(), getMethod(), {
            params = { "starting_after" = last().getId() }
        } );
    }

    private function first() {
        return getData()[ 1 ];
    }

    private function last() {
        var data = getData();
        return data[ data.len() ];
    }

}
