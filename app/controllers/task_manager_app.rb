require_relative '../models/task_manager'

class TaskManagerApp < Sinatra::Base
  set :method_override, true
  set :root, File.expand_path("..", __dir__)

    get '/' do
      erb :dashboard
    end

    get '/tasks' do
      @tasks = task_manager.all
      erb :index
    end

    get '/tasks/new' do
      erb :new
    end

    put '/tasks/:id' do |id|
      task_manager.update(id.to_i, params[:task])
      redirect "/tasks/#{id}"
    end

    post '/tasks' do
      task_manager.create(params[:task])
      redirect '/tasks'
    end

    get '/tasks/:id' do |id|
      @task = task_manager.find(id.to_i)
      erb :show
    end

    delete '/tasks/:id' do |id|
      task_manager.destroy(id.to_i)
      redirect '/tasks'
    end

    def task_manager
      database = YAML::Store.new('db/task_manager')
      @task_manager ||= TaskManager.new(database)
    end

    get '/tasks/:id/edit' do |id|
      @task = task_manager.find(id.to_i)
      erb :edit
    end

  end
