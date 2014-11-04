class Payment < ActiveRecord::Base
  belogs_to :order
end
