class Teacher < ActiveRecord::Base
    # sets ActiveRecord associations
    has_many :lessons
    belongs_to :subject
    # enables password encryption thanks to bcrypt
    has_secure_password

    # getter method to allow identifying teacher by name, rather than id
    def slug
        if @slug
            @slug
        else
            # sets instance varaible to the instance's name, with spaces replaced by "-"
            @slug = self.name.split.join("-")
        end
    end

    # class method to find a teacher by slug, rather than id
    def self.find_by_slug(slug)
        Teacher.all.find do |teacher|
            teacher.slug == slug
        end
    end

end