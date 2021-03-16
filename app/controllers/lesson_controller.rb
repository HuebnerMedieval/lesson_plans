require 'pry'

class LessonController < ApplicationController
    # checks whether a user is logged in, rendering the New view if so and redirecting to the index route if not
    get "/lessons/new" do
        if logged_in?
            erb :"lessons/new_lesson"
        else
            redirect "/"
        end
    end

    # create action
    # if form fields are blank, redirects user back to the New route.
    # instantiates a new lesson which belongs to the current user
    # redirects the user to the Show route of the new lesson
    post "/lessons" do
        if params.has_value?("")
            redirect "/lessons/new"
        else
            lesson = current_user.lessons.create(params)
            redirect "lessons/#{lesson.id}"
        end
    end

    # if the user is not logged in, redirects tot he index route
    # creates instance variable of all lessons sorted by subject
    # renders the Index view for lessons
    get "/lessons" do
        if logged_in?
            @lessons = Lesson.all.sort_by{|lesson| lesson.subject.name}
            erb :"lessons/lessons"
        else
            redirect "/"
        end
    end

    # if user is not logged in, redirects to the index route
    # renders the Show view for a single lesson
    get "/lessons/:id" do
        if logged_in?
            # finds desired lesson by id
            @lesson = Lesson.find_by(id: params[:id])
            # if @lesson exists, renders the view. if not, redirects to the lesson index route
            if @lesson
                erb :"lessons/show_lesson"
            else
                redirect "/lessons"
            end
        else
            redirect "/"
        end
    end

    # if user is not logged in, redirects to the index route
    # renders the Edit view for the desired lesson
    get "/lessons/:id/edit" do
        if logged_in?
            # finds desired lesson by id
            @lesson = Lesson.find_by(id: params[:id])
            if @lesson
                # if the desired lesson exists, checks that it belongs to the current user
                # if not, the user does not have permission to edit, and is redirected to the Show view
                if @lesson.teacher == current_user
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

    # update route
    patch "/lessons/:id" do
        # stores the desired lesson in a variable
        lesson = current_user.lessons.find_by(id: params[:id])
        # creates an array to store form data
        # creates variables to hold form data
        arr = []
        title = params[:title]
        arr << title
        learning_obj = params[:learning_obj]
        arr << learning_obj
        length = params[:length]
        arr << length
        summary = params[:summary]
        arr << summary
        assessment = params[:assessment]
        arr << assessment
        # ensures that all form fields i.e. model attributes, are filled in
        # if not, discard edits and redirect to the Show route
        if arr.include?("")
            redirect "/lessons/#{lesson.id}"
        else
            lesson.update(title: title, learning_obj: learning_obj, length: length, summary: summary, assessment: assessment)
            redirect "/lessons/#{lesson.id}"
        end
    end

    # Delete route
    delete "/lessons/:id/delete" do
        # checks that the lesson to be deleted belongs to the user. If not, redirect to that user's show view
        if current_user.lessons.find_by(id: params[:id])
            lesson = current_user.lessons.find_by(id: params[:id])
            lesson.delete
            redirect "/teachers/#{current_user.slug}"
        else
            redirect "/lessons"
        end
    end


end