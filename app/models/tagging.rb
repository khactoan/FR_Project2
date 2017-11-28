class Tagging < ApplicationRecord
  scope :select_distinct_tag_id,-> {select "distinct tag_id"}
end
