class SubjectController < ApplicationController
    get "/subjects" do
        if logged_in?
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