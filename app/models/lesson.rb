class Lesson < ActiveRecord::Base
    belongs_to :teacher

    def subject
        self.teacher.subject
    end

    def slug
        if @slug
            @slug
        else
            @slug = self.title.split.join("-")
        end
    end

    def self.find_by_slug(slug)
        Lesson.all.find do |lesson|
            lesson.slug == slug
        end
    end

end