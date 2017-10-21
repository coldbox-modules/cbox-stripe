component extends="cbstripe.models.BaseStripeModel" accessors="true" {

    property name="CustomerService"
             inject="CustomerService@cbstripe"
             getter="false"
             setter="false";

    property name="id" default="";
    property name="email" default="";
    property name="description" default="";
    property name="isDeleted" default="false";

    function save() {
        var res = "";
        if ( isNull( variables.id ) ) {
            res = CustomerService.create( this );
        }
        else {
            res = CustomerService.update( this );
        }
    }

    function getMemento() {
        return {
            "email" = getEmail(),
            "description" = getDescription()
        };
    }

}
