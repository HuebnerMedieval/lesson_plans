class SubjectController < ApplicationController
    get "/subjects" do
        if logged_in?
            @subjects = []
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

    get "subjects/:id" do
        if logged_in?
            @subject = Subject.find_by(id: params[:id])
            erb :"subjects/show"
        else
            redirect "/"
        end
    end
end