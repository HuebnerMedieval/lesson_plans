class Subject < ActiveRecord::Base
    has_many :teachers
    has_many :lessons, through: :teachers
end