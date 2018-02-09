class SchoolsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]

  def index
    schools = School.select([:name]).all()
    render json: { status: 200,
                  data: schools }
  end

  def new
    school = School.new
  end

  def create
    begin
      school = School.create!(params.permit(:name, :password, :username))
      school.save
      render json: { status: 201,
          data: {
            name: params[:name],
            username: params[:username]
          }
        }
    rescue ActiveRecord::RecordNotUnique => error
      if error.message == 'SQLite3::ConstraintException: UNIQUE constraint failed: schools.name: INSERT INTO "schools" ("name", "username", "password", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)'
        render json: { status: 200,
              data: {
                error: 'name already exists',
                name: params[:name]
              }
            }
        return
      end
      if error.message == 'SQLite3::ConstraintException: UNIQUE constraint failed: schools.username: INSERT INTO "schools" ("name", "username", "password", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)'
        render json: { status: 200,
              data: {
                error: 'username already exists',
                username: params[:username]
              }
            }
        return
      end
    end
  end

  def register
    @school = School.create(school_params)
   if @school.save
    response = { message: 'School created successfully'}
    render json: response, status: :created 
   else
    render json: @school.errors, status: :bad
   end 
  end

  def login
    authenticate params[:username], params[:password]
  end

  def test
    render json: {
          message: 'You have passed authentication and authorization test'
        }
  end

  private

  def school_params
    params.permit(
      :name,
      :username,
      :password
    )
  end

  def authenticate(username, password)
    command = AuthenticateSchool.call(username, password)

    if command.success?
      render json: {
        access_token: command.result,
        message: 'Login Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
   end
end