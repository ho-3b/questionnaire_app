class AskedCondition < ApplicationRecord
  belongs_to :target, polymorphic: true

end
