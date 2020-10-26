class LessonController < ApplicationController
    get "/lessons/new" do
        if logged_in?
            erb :"lessons/new_lesson"
        else
            redirect "/"
        end
    end

    post "/lessons" do
        #instantiates a new lesson. Need to write the code
    end

    get "/lessons" do
        if logged_in?
            @lessons = Lesson.all
            erb :"lessons/lessons"
        else
            redirect "/"
        end
    end

    get "/lessons/:slug" do
        if logged_in?
            @lesson = Lesson.find_by_slug(params[:slug])
            if @lesson
                erb :"lessons/show_lesson"
            else
                redirect "/lessons"
            end
        else
            redirect "/"
        end
    end

    get "lessons/:slug/edit" do
        if logged_in?
            @lesson = Lesson.find_by_slug(params[:slug])
            if @lesson
                if @lesson.teacher = current_user
                    erb :"lessons/edit_lesson"
                else
                    redirect "/lessons/#{@lesson.slug}"
                end
            else
                redirect "/lessons"
            end
        else
            redirect "/"
        end
    end

    patch "/lessons/:slug" do
        lesson = current_user.lessons.find_by_slug(params[:slug])
        if params #content of the edits are valid
            #update each part of the lesson
        else
            redirect "/lessons/#{lesson.slug}"
        end
    end

    delete "/lessons/:slug/delete" do
        if current_user.lessons.find_by_slug(params[:slug])
            lesson = current_user.lessons.find_by_slug(params[:slug])
            lesson.delete
            redirect "/lessons"
        else
            redirect "/lessons"
        end
    end


end