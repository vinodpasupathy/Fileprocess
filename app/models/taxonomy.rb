class Taxonomy
  include Mongoid::Document
  field :sub_cat_name
  field :parent_id
  field :taxon_id
end
