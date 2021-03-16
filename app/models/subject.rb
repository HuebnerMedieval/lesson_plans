class Subject < ActiveRecord::Base
    # sets ActiveRecord associations
    has_many :teachers
    has_many :lessons, through: :teachers
end