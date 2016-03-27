require 'active_record'

class Film < ActiveRecord::Base
  paginates_per 30
end
