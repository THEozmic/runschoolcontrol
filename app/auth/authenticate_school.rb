class AuthenticateSchool
  prepend SimpleCommand
  attr_accessor :username, :password

  #this is where parameters are taken when the command is called
  def initialize(username, password)
    @username = username
    @password = password
  end
  
  #this is where the result gets returned
  def call
    JsonWebToken.encode(school_id: school.id) if school
  end

  private

  def school
    school = School.find_by_username(username)
    return school if school && school.authenticate(password)

    errors.add :school_authentication, 'Invalid credentials'
    nil
  end
end