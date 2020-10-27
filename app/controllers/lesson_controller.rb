require 'pry'

class LessonController < ApplicationController
    get "/lessons/new" do
        if logged_in?
            erb :"lessons/new_lesson"
        else
            redirect "/"
        end
    end

    post "/lessons" do
        #checking to see whether params works instead of array
        binding.pry
        arr = []
        title = params[:title]
        arr << title
        learning_obj = params[:learning_obj]
        arr << learning_obj
        length = params[:length]
        arr << length
        summary = params[:summary]
        arr << summary
        assessment = parrams[:assessment]
        arr << assessment
        if arr.include?("")
            redirect "/lessons/new"
        else
            lesson = current_user.lessons.create(title: title, learning_obj: learning_obj, length: length, summary: summary, assessment: assessment)
            redirect "lessons/#{lesson.id}"
        end
    end

    get "/lessons" do
        if logged_in?
            @lessons = Lesson.all
            erb :"lessons/lessons"
        else
            redirect "/"
        end
    end

    get "/lessons/:id" do
        if logged_in?
            @lesson = Lesson.find_by(id: params[:id])
            if @lesson
                erb :"lessons/show_lesson"
            else
                redirect "/lessons"
            end
        else
            redirect "/"
        end
    end

    get "lessons/:id/edit" do
        if logged_in?
            @lesson = Lesson.find_by(id: params[:id])
            if @lesson
                if @lesson.teacher = current_user
                    erb :"lessons/edit_lesson"
                else
                    redirect "/lessons/#{@lesson.id}"
                end
            else
                redirect "/lessons"
            end
        else
            redirect "/"
        end
    end

    patch "/lessons/:id" do
        lesson = current_user.lessons.find_by(id: params[:id])
        #again, checking to see whether params will work instead
        binding.pry
        arr = []
        title = params[:title]
        arr << title
        learning_obj = params[:learning_obj]
        arr << learning_obj
        length = params[:length]
        arr << length
        summary = params[:summary]
        arr << summary
        assessment = parrams[:assessment]
        arr << assessment
        if arr.include?("")
            redirect "/lessons/#{lesson.id}"
        else
            lesson.update(title: title, learning_obj: learning_obj, length: length, summary: summary, assessment: assessment)
        end
    end

    delete "/lessons/:id/delete" do
        if current_user.lessons.find_by(id: params[:id])
            lesson = current_user.lessons.find_by(id: params[:id])
            lesson.delete
            redirect "/lessons"
        else
            redirect "/lessons"
        end
    end


end