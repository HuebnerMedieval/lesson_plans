class Teacher < ActiveRecord::Base
    has_many :lessons
    belongs_to :subject
    has_secure_password

    def slug
        if @slug
            @slug
        else
            @slug = self.name.split.join("-")
        end
    end

    def self.find_by_slug(slug)
        Teacher.all.find do |teacher|
            teacher.slug == slug
        end
    end

end