# Compare Admin Panels!

An analysis of six popular admin panel gems for use with Ruby on Rails:

## Active Admin
* The "original" admin panel -- still widely used for new projects today
* Ruby-centric markup design using Arbre
* Has CSV, XML, and JSON export

https://activeadmin.info/

## Avo
* Attractive interface using the newest front-end technology
* Paid option adds dashboards / menu editing / inline editing
* Built by Adrian Marin

https://avohq.io/

## Forest
* Semi-Saas where you keep the database, and the Forest servers only know the tables, columns, and associations.  Data is delivered by an agent to the forest servers which render pages.
* Paid option adds visualisation / charting / workflow enhancements
* Lots of traction, having secured significant funding

https://www.forestadmin.com/

## Motor Admin
* Very lean
* Has GUI Form Builder / CSV export
* Configuration all done in database tables instead of an initializer file
* Paid option available
* Built by Pete Matsyburka

https://www.getmotoradmin.com/ruby-on-rails

## Rails Admin
* The "original" sexier alternative admin panel
* Has CSV export
* Built by a very dedicated soul -- Mitsuhiro Shibuya

https://github.com/railsadminteam/rails_admin

## Trestle
* Automatically adds routes without having to modify routes.rb
* Offers a Ruby-centric DSL via a well thought out set of helpers
* Pretty lean
* Built by Sam Pohlenz

https://trestle.io/

---

Also considering adding ThoughtBot's [Administrate](https://github.com/thoughtbot/administrate) and
Chris Oliver's [madmin](https://github.com/excid3/madmin).

### Troubleshooting

If you get:
```
The asset "active_admin.css" is not present in the asset pipeline.
```
then do this:
```
bin/rails g active_admin:assets
```
(But it really should already be there.)
