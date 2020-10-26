class Teacher < ActiveRecord::Base
    has_many :lessons
    belongs_to :subject
    has_secure_password
end