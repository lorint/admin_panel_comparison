# frozen_string_literal: true

# Settings for the Brick gem
# (By default this auto-creates models, controllers, views, and routes on-the-fly.)

if ActiveRecord::Base.respond_to?(:brick_select) && !::Brick.initializer_loaded
  # Mode -- generally :on or :off, or only in :development.  Also available is :diag_env which enables only
  # when the environment variable BRICK is set.
  Brick.mode = :development
  # Can be further overridden by placing this line in development.rb / test.rb / production.rb:
  # # Brick.mode = :on # (or :off to entirely disable)

  # Custom path prefix to apply to all auto-generated Brick routes.  Also causes auto-generated controllers
  # to be created inside a module with the same name.
  ::Brick.path_prefix = 'brick'

  # # Normally all are enabled in development mode, and for security reasons only models are enabled in production
  # # and test.  This allows you to either (a) turn off models entirely, or (b) enable controllers, views, and routes
  # # in production.
  # Brick.enable_routes = true # Setting this to "false" will disable routes in development
  # Brick.enable_models = false
  # Brick.enable_controllers = true # Setting this to "false" will disable controllers in development
  # Brick.enable_views = true # Setting this to "false" will disable views in development

  # If The Brick sees that RSwag gem is present, it allows for API resources to be automatically served out.
  # You can configure one or more root path(s) for these resources, and when there are multiple then an attempt
  # is made to return data from that version of the view or table name, or the most recent prior to that version:
  ::Brick.api_roots = ['/api/v1/']
  # # You may also want to add an OpenAPI 3.0 documentation endpoint using Rswag::Ui:
  Rswag::Ui.configure do |config|
    config.swagger_endpoint '/api-docs/v1/swagger.json', 'API V1 Docs'
  end

  # # By default models are auto-created for database views, and set to be read-only.  This can be skipped.
  # Brick.skip_database_views = true

  # # Any tables or views you'd like to skip when auto-creating models
  # Brick.exclude_tables = ['custom_metadata', 'version_info']

  # # Class that auto-generated models should inherit from
  # Brick.models_inherit_from = ApplicationRecord

  # # When table names have specific prefixes automatically place them in their own module with a table_name_prefix.
  # Brick.table_name_prefixes = { 'nav_' => 'Navigation' }

  # # COLUMN SEQUENCING AND INCLUSION / EXCLUSION

  # # By default if there is a primary key present then rows in an index view are ordered by this primary key.  To
  # # use a different rule for doing ORDER BY, you can override this default ordering done by The Brick, for instance
  # # to have the rows in a contact list sorted by email:
  # Brick.order = { 'contacts' => { _brick_default: :email } }
  # # or by last name then first name:
  # Brick.order = { 'contacts' => { _brick_default: [:lastname, :firstname] } }
  # # Totally legitimate to have the default order be the name of a belongs_to or has_many association instead of an
  # # actual column name, in which case for has_many it just orders by the count of how many records are associated,
  # # and for belongs_to it's based on the primary table's DSL if any is defined (since that is what is used to
  # # calculate what is shown when a foreign table lists out related records).  If contacts relates to addresses,
  # # then this is perfectly fine:
  # Brick.order = { 'contacts' => { _brick_default: :address } }
  # # You can even have a specific custom clause used in the ORDER BY.  In this case it is recommended to include a
  # # special placeholder for the table name with the sequence "^^^".  Here is an example of having the default
  # # ordering happening on the "code" column, and also defining custom sorting to be done, in this case proper
  # # ordering if that code is stored as a dotted numeric value:
  # Brick.order = { 'document_trees' => { _brick_default: :code,
  #                                       code: "ORDER BY STRING_TO_ARRAY(^^^.code, '.')::int[]" } }

  # # Sequence of columns for each model.  This also allows you to add read-only calculated columns in the same
  # # kind of way that they can be added in the include: portion of include/exclude columns, below.
  # # Designated by { <table name> => [<column name>, <column name>] }
  # Brick.column_sequence = { 'users' => ['email', 'profile.firstname', 'profile.lastname'] }

  # # Specific columns to include or exclude for each model.  If there are only inclusions then only those
  # # columns show.  If there are any exclusions then all non-excluded columns are attempted to be shown,
  # # which negates the usefulness of inclusions except to add calculated column detail built from DSL.
  # # Designated by <table name>.<column name>
  # Brick.column_sequence = { 'users' =>   { include: ['email', 'profile.firstname', 'profile.lastname'] },
  #                           'profile' => { exclude: ['birthdate'] } }

  # # EXTRA FOREIGN KEYS AND OTHER HAS_MANY SETTINGS

  # # Additional table references which are used to create has_many / belongs_to associations inside auto-created
  # # models.  (You can consider these to be "virtual foreign keys" if you wish)...  You only have to add these
  # # in cases where your database for some reason does not have foreign key constraints defined.  Sometimes for
  # # performance reasons or just out of sheer laziness these might be missing.
  # # Each of these virtual foreign keys is defined as an array having three values:
  # #   foreign table name / foreign key column / primary table name.
  # # (We boldly expect that the primary key identified by ActiveRecord on the primary table will be accurate,
  # # usually this is "id" but there are some good smarts that are used in case some other column has been set
  # # to be the primary key.)
  # Brick.additional_references = [['orders', 'customer_id', 'customer'],
  #                                ['customer', 'region_id', 'regions']]
  Brick.additional_references = [['employees', 'reports_to_id', 'employees']]
  # # Columns named somewhat like a foreign key which you may want to consider:
  # #   hr.d.departmentid, hr.e.businessentityid, hr.e.loginid, hr.e.rowguid, hr.edh.businessentityid, hr.edh.shiftid, hr.edh.departmentid, hr.eph.businessentityid, hr.jc.jobcandidateid, hr.jc.businessentityid, hr.s.shiftid, humanresources.vemployee.businessentityid, humanresources.vemployeedepartment.businessentityid, humanresources.vemployeedepartmenthistory.businessentityid, humanresources.vjobcandidate.jobcandidateid, humanresources.vjobcandidate.businessentityid, humanresources.vjobcandidateeducation.jobcandidateid, humanresources.vjobcandidateemployment.jobcandidateid, humanresources.employee.loginid, humanresources.employee.rowguid, pe.a.rowguid, pe.a.addressid, pe.a.stateprovinceid, pe.at.addresstypeid, pe.at.rowguid, pe.be.rowguid, pe.be.businessentityid, pe.bea.addresstypeid, pe.bea.rowguid, pe.bea.addressid, pe.bea.businessentityid, pe.bec.rowguid, pe.bec.contacttypeid, pe.bec.personid, pe.bec.businessentityid, pe.ct.contacttypeid, pe.e.businessentityid, pe.e.emailaddressid, pe.e.rowguid, pe.p.businessentityid, pe.p.rowguid, pe.pa.rowguid, pe.pa.businessentityid, pe.pnt.phonenumbertypeid, pe.pp.phonenumbertypeid, pe.pp.businessentityid, pe.sp.territoryid, pe.sp.stateprovinceid, pe.sp.rowguid, person.vadditionalcontactinfo.businessentityid, person.vadditionalcontactinfo.rowguid, person.address.rowguid, person.addresstype.rowguid, person.businessentity.rowguid, person.businessentityaddress.rowguid, person.businessentitycontact.rowguid, person.emailaddress.rowguid, person.password.rowguid, person.person.rowguid, person.stateprovince.rowguid, pr.bom.billofmaterialsid, pr.bom.productassemblyid, pr.bom.componentid, pr.c.cultureid, pr.d.rowguid, pr.i.illustrationid, pr.l.locationid, pr.p.productid, pr.p.productsubcategoryid, pr.p.productmodelid, pr.p.rowguid, pr.pc.rowguid, pr.pc.productcategoryid, pr.pch.productid, pr.pd.rowguid, pr.pd.productdescriptionid, pr.pdoc.productid, pr.pi.productid, pr.pi.locationid, pr.pi.rowguid, pr.plph.productid, pr.pm.rowguid, pr.pm.productmodelid, pr.pmi.illustrationid, pr.pmi.productmodelid, pr.pmpdc.cultureid, pr.pmpdc.productdescriptionid, pr.pmpdc.productmodelid, pr.pp.productphotoid, pr.ppp.productid, pr.ppp.productphotoid, pr.pr.productreviewid, pr.pr.productid, pr.psc.rowguid, pr.psc.productsubcategoryid, pr.psc.productcategoryid, pr.sr.scrapreasonid, pr.th.productid, pr.th.referenceorderlineid, pr.th.referenceorderid, pr.th.transactionid, pr.tha.referenceorderlineid, pr.tha.referenceorderid, pr.tha.productid, pr.tha.transactionid, pr.w.productid, pr.w.scrapreasonid, pr.w.workorderid, pr.wr.locationid, pr.wr.workorderid, pr.wr.productid, production.vproductmodelcatalogdescription.productmodelid, production.vproductmodelcatalogdescription.rowguid, production.vproductmodelcatalogdescription.productphotoid, production.vproductmodelinstructions.LocationID, production.vproductmodelinstructions.rowguid, production.vproductmodelinstructions.productmodelid, production.document.rowguid, production.product.rowguid, production.productcategory.rowguid, production.productdescription.rowguid, production.productinventory.rowguid, production.productmodel.rowguid, production.productsubcategory.rowguid, production.transactionhistory.referenceorderlineid, production.transactionhistory.referenceorderid, production.transactionhistoryarchive.productid, production.transactionhistoryarchive.referenceorderid, production.transactionhistoryarchive.referenceorderlineid, pu.pod.productid, pu.pod.purchaseorderdetailid, pu.pod.purchaseorderid, pu.poh.purchaseorderid, pu.poh.employeeid, pu.poh.vendorid, pu.poh.shipmethodid, pu.pv.productid, pu.pv.businessentityid, pu.sm.shipmethodid, pu.sm.rowguid, pu.v.businessentityid, purchasing.vvendorwithaddresses.businessentityid, purchasing.vvendorwithcontacts.businessentityid, purchasing.shipmethod.rowguid, sa.c.customerid, sa.c.personid, sa.c.rowguid, sa.c.territoryid, sa.c.storeid, sa.cc.creditcardid, sa.cr.currencyrateid, sa.pcc.businessentityid, sa.pcc.creditcardid, sa.s.businessentityid, sa.s.salespersonid, sa.s.rowguid, sa.sci.productid, sa.sci.shoppingcartid, sa.sci.shoppingcartitemid, sa.so.rowguid, sa.so.specialofferid, sa.sod.specialofferid, sa.sod.rowguid, sa.sod.salesorderid, sa.sod.salesorderdetailid, sa.sod.productid, sa.soh.shipmethodid, sa.soh.shiptoaddressid, sa.soh.billtoaddressid, sa.soh.territoryid, sa.soh.salespersonid, sa.soh.customerid, sa.soh.creditcardid, sa.soh.salesorderid, sa.soh.rowguid, sa.soh.currencyrateid, sa.sohsr.salesorderid, sa.sohsr.salesreasonid, sa.sop.specialofferid, sa.sop.productid, sa.sop.rowguid, sa.sp.rowguid, sa.sp.territoryid, sa.sp.businessentityid, sa.spqh.rowguid, sa.spqh.businessentityid, sa.sr.salesreasonid, sa.st.rowguid, sa.st.territoryid, sa.sth.businessentityid, sa.sth.territoryid, sa.sth.rowguid, sa.tr.salestaxrateid, sa.tr.stateprovinceid, sa.tr.rowguid, sales.vindividualcustomer.businessentityid, sales.vpersondemographics.businessentityid, sales.vsalesperson.businessentityid, sales.vsalespersonsalesbyfiscalyears.SalesPersonID, sales.vsalespersonsalesbyfiscalyearsdata.salespersonid, sales.vstorewithaddresses.businessentityid, sales.vstorewithcontacts.businessentityid, sales.vstorewithdemographics.businessentityid, sales.customer.rowguid, sales.salesorderdetail.rowguid, sales.salesorderdetail.productid, sales.salesorderdetail.specialofferid, sales.salesorderheader.rowguid, sales.salesperson.rowguid, sales.salespersonquotahistory.rowguid, sales.salestaxrate.rowguid, sales.salesterritory.rowguid, sales.salesterritoryhistory.rowguid, sales.shoppingcartitem.shoppingcartid, sales.specialoffer.rowguid, sales.specialofferproduct.rowguid, sales.store.rowguid

  # # Custom columns to add to a table, minimally defined with a name and DSL string.
  # Brick.custom_columns = { 'users' =>  { messages:    ['[COUNT(messages)] messages', 'messages'] },
  #                          'orders' => { salesperson:  '[salesperson.first] [salesperson.last]',
  #                                        products:    ['[COUNT(order_items.product)] products', 'order_items.product' ] }
  #                        }

  # # Skip creating a has_many association for these (only retain the belongs_to built from this additional_reference).
  # # (Uses the same exact three-part format as would define an additional_reference)
  # # Say for instance that we didn't care to display the favourite colours that users have:
  # Brick.exclude_hms = [['users', 'favourite_colour_id', 'colours']]

  # # Skip showing counts for these specific has_many associations when building auto-generated #index views.
  # # When there are related tables with a significant number of records (generally 100,000 or more), this can lessen
  # # the load on the database considerably, sometimes fixing what might appear to be an index page that just "hangs"
  # # for no apparent reason.
  # Brick.skip_index_hms = ['User.litany_of_woes']

  # # By default primary tables involved in a foreign key relationship will indicate a "has_many" relationship pointing
  # # back to the foreign table.  In order to represent a "has_one" association instead, an override can be provided
  # # using the primary model name and the association name which you instead want to have treated as a "has_one":
  # Brick.has_ones = [['User', 'user_profile']]
  # # If you want to use an alternate name for the "has_one", such as in the case above calling the association "profile"
  # # instead of "user_profile", then apply that as a third parameter like this:
  # Brick.has_ones = [['User', 'user_profile', 'profile']]

  # # We normally don't show the timestamp columns "created_at", "updated_at", and "deleted_at", and also do
  # # not consider them when finding associative tables to support an N:M association.  (That is, ones that can be a
  # # part of a has_many :through association.)  If you want to use different exclusion columns than our defaults
  # # then this setting resets that list.  For instance, here is an override that is useful in the Sakila sample
  # # database:
  # Brick.metadata_columns = ['last_update']

  # # Columns for which to add a validate presence: true even though the database doesn't have them marked as NOT NULL.
  # # Designated by <table name>.<column name>
  # Brick.not_nullables = ['users.name']

  # # String or text columns which for editing purposes should be treated as JSON.
  # Brick.json_columns = { 'users' => ['info'] }

  # # FRIENDLY DSL

  # # A simple DSL is available to allow more user-friendly display of objects.  Normally a user object might be shown
  # # as its first non-metadata column, or if that is not available then something like "User #42" where 42 is that
  # # object's ID.  If there is no primary key then even that is not possible, so the object's .to_s is called.  To
  # # override these defaults and specify exactly what you want shown, such as first names and last names for a user,
  # # then you can do something like this:
  Brick.model_descrips = { 'Order' => '[customer.company_code] ([customer.company_name]), [order_date]',
                           'OrderDetail' => '[quantity] [product.product_name] ($[unit_price])' }

  # # SINGLE TABLE INHERITANCE

  # # Specify STI subclasses either directly by name or as a general module prefix that should always relate to a specific
  # # parent STI class.  The prefixed :: here for these examples is mandatory.  Also having a suffixed :: means instead of
  # # a class reference, this is for a general namespace reference.  So in this case requests for, say, either of the
  # # non-existent classes Animals::Cat or Animals::Goat (or anything else with the module prefix of "Animals::" would
  # # build a model that inherits from Animal.  And a request specifically for the class Snake would build a new model
  # # that inherits from Reptile, and no other request would do this -- only specifically for Snake.  The ending ::
  # # indicates that it's a module prefix instead of a specific class name.
  # Brick.sti_namespace_prefixes = { '::Animals::' => 'Animal',
  #                                  '::Snake' => 'Reptile' }

  # # Custom inheritance_column to be used for STI.  This is by default "type", and applies to all models.  With this
  # # option you can change this either for specific models, or apply a new overall name generally:
  # Brick.sti_type_column = 'sti_type'
  # Brick.sti_type_column = { 'rails_type' => ['sales.specialoffer'] }

  # # POLYMORPHIC ASSOCIATIONS

  # # Polymorphic associations are set up by providing a model name and polymorphic association name like this:
  # Brick.polymorphics = {
  #                        'comments.commentable' => nil,
  #                        'images.imageable' => nil
  #                      }

  # # For multi-tenant databases that use a separate schema for each tenant, a single representative database schema
  # # can be analysed to determine the range of polymorphic classes that can be used for each association.  Hopefully
  # # the schema chosen is one loaded with existing data that is representative of all possible polymorphic
  # # associations.
  # Brick.schema_behavior = :namespaced
  # Brick.schema_behavior = { multitenant: { schema_to_analyse: 'engineering' } }

  # # DEFAULT ROOT ROUTE

  # # If a default route is not supplied, Brick attempts to find the most "central" table and wires up the default
  # # route to go to the :index action for what would be a controller for that table.  You can specify any controller
  # # name and action you wish in order to override this and have that be the default route when none other has been
  # # specified in routes.rb or elsewhere.  (Or just use an empty string in order to disable this behaviour.)
  # This defaults to "customers#index", and if there was also a prefix set called "admin" then it would instead
  # go to "admin/customers#index".
  # Brick.default_route_fallback = 'customers'
  # Brick.default_route_fallback = 'orders#outstanding' # Example of a non-RESTful route
  # Brick.default_route_fallback = '' # Omits setting a default route in the absence of any other
end
