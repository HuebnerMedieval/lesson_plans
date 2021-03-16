require 'pry'
class TeacherController < ApplicationController

    # teacher new route
    get "/teachers/new" do
        # redirects the user to their page if they are already logged in
        if logged_in?
            redirect "/teachers/#{current_user.slug}"
        else
            @subjects = Subject.all
            erb :"teachers/signup"
        end
    end

    # teacher create route
    post "/teachers" do
        # creates array to hold form data
        # initializes variables for form data, and stores them in the array
        arr = []
        name = params[:name]
        arr << name
        password = params[:password]
        arr << password
        # stores the correct Subject instance to allow the association
        subject = Subject.find_by(id: params[:subject])
        arr << subject
        # if the teacher already exists, redirects them to the login view
        # if any fields on the form are empty, reloads the new view
        if Teacher.find_by(name: name)
            redirect "/login"
        elsif arr.include?("")
            redirect "/teachers/new"
        else
            # instantiates a new teacher with attributes from the form
            teacher = Teacher.new(name: name, password: password, subject: subject)
            # authenticates the password using bcrypt, saves the teacher, and sets the user_id to the teacher id.
            # sends the user to their show view
            if teacher.authenticate(password)
                teacher.save
                session[:user_id] = teacher.id
                redirect "/teachers/#{teacher.slug}"
            end
        end
    end

    # renders the login page
    # if the user is already logged in, redirects them to their own page
    get "/login" do
        if logged_in?
            redirect "/teachers/#{current_user.slug}"
        else
            erb :"teachers/login"
        end
    end

    post "/login" do
        # searches the db for a teacher matching the form data
        teacher = Teacher.find_by(name: params[:name])
        
        # checks that the teacher exists and that their password is correct
        # if not, redirects to the new route
        if teacher && teacher.authenticate(params[:password])
            # sets the user_id to the teacher id and redirects to user to their page
            session[:user_id] = teacher.id
            redirect "/teachers/#{teacher.slug}"
        else
            redirect "/teachers/new"
        end
    end

    # renders teachers index view if the user is logged in
    get "/teachers" do
        if logged_in?
            @subjects = Subject.all
            erb :"teachers/teachers"
        else
            redirect "/"
        end
    end

    # renders teacher show view if the user is logged in
    get "/teachers/:slug" do
        if logged_in?
            @teacher = Teacher.find_by_slug(params[:slug])
            erb :"teachers/slug"
        else
            redirect "/"
        end
    end

    # clears the session cookies, logging the user out
    get "/logout" do
        session.clear
        redirect "/"
    end

end