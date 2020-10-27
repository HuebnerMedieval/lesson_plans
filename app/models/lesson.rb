class Lesson < ActiveRecord::Base
    belongs_to :teacher

    def subject
        self.teacher.subject
    end

end