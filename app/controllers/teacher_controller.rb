require 'pry'
class TeacherController < ApplicationController

    get "/teachers/new" do
        if logged_in?
            redirect "/teachers/#{current_user.slug}"
        else
            @subjects = Subject.all
            erb :"teachers/signup"
        end
    end

    post "/teachers" do
        arr = []
        name = params[:name]
        arr << name
        password = params[:password]
        arr << password
        subject = Subject.find_by(id: params[:subject])
        arr << subject
        if Teacher.find_by(name: name)
            redirect "/login"
        elsif arr.include?("")
            redirect "/teachers/new"
        else
            teacher = Teacher.new(name: name, password: password, subject: subject)
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
        
        if teacher && teacher.authenticate(params[:password])
            session[:user_id] = teacher.id
            redirect "/teachers/#{teacher.slug}"
        else
            redirect "/teachers/new"
        end
    end

    get "/teachers" do
        if logged_in?
            @subjects = Subject.all
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

    get "/logout" do
        session.clear
        redirect "/"
    end

end