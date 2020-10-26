class TeacherController < ApplicationController

    get "/signup" do
        #need to create signup view
        if logged_in?
            redirect "/teachers/#{current_user.slug}"
        else
            erb :"teachers/signup"
        end
    end

    post "/teachers/new" do
        arr = []
        name = params[:name]
        arr << name
        password = params[:password]
        arr << password
        subject = params[:subject]
        arr << subject
        if Teacher.find_by(name: name)
            redirect "/login"
        elsif arr.include?("")
            redirect "/signup"
        else
            teacher = Teacher.new(name: name, password: password)
            if teacher.authenticate(password)
                teacher.save
                session[:user_id] = teacher.id
                redirect "/teachers/#{teacher.slug}"
            end
        end
    end


    get "/login" do
        if logged_in?
            redirect "/teachers/#{current_user.slug}"
        else
            erb :"teachers/login"
        end
    end

    post "/login" do
        teacher = Teacher.find_by(name: params[:name])
        if teacher && Teacher.authenticate(params[:password])
            session[:user_id] = teacher.id
            redirect "/teachers/#{teacher.slug}"
        else
            redirect "/signup"
        end
    end

    get "/teachers" do
        if logged_in?
            erb :"teachers/teachers"
        else
            redirect "/"
        end
    end

    get "/teachers/:slug" do
        if logged_in?
            @teacher = Teacher.find_by_slug(params[:slug])
            erb :"teachers/slug"
        else
            redirect "/"
        end
    end

end