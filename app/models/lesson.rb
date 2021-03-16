class Lesson < ActiveRecord::Base
    # sets ActiveRecord association
    belongs_to :teacher

    # getter method to display the associated subject
    def subject
        self.teacher.subject
    end

end