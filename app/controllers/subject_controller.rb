class SubjectController < ApplicationController
    # index route for subjects
    get "/subjects" do
        if logged_in?
            # instance variable to be used by the erb file
            @subjects = []
            # iterates through all Subjects. Only subjects with lessons are passed to the view
            Subject.all.each do |subject|
                if !subject.lessons.empty?
                    @subjects << subject
                end
            end
            erb :"subjects/subjects"
        else
            redirect "/"
        end
    end

    # subject show route
    get "/subjects/:id" do
        if logged_in?
            @subject = Subject.find_by(id: params[:id])
            erb :"subjects/show"
        else
            redirect "/"
        end
    end
end