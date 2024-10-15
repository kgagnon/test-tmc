require_relative "json_reader"

class UserReader < JsonReader
  attr_reader :users

  def initialize
    super("users.json")
    @users = map_users
    validate_data
  end

  private

  def map_users
    @data.map do |user_data|
      User.new(
        user_data["id"],
        user_data["first_name"],
        user_data["last_name"],
        user_data["email"],
        user_data["company_id"],
        user_data["email_status"],
        user_data["active_status"],
        user_data["tokens"]
      )
    end
  end

  def validate_data
    @data.each do |user|
      validate_user_fields(user)
    end
  end

  private

  def validate_user_fields(user)
    unless user.is_a?(Hash)
      raise "Invalid user data structure: #{user}"
    end

    validate_id(user["id"])
    validate_first_name(user["first_name"])
    validate_last_name(user["last_name"])
    validate_email(user["email"])
    validate_company_id(user["company_id"])
    validate_email_status(user["email_status"])
    validate_active_status(user["active_status"])
    validate_tokens(user["tokens"])
  end

  def validate_id(id)
    unless id.is_a?(Integer) && id > 0
      raise "Invalid 'id' field: #{id}"
    end
  end

  def validate_first_name(first_name)
    unless first_name.is_a?(String) && !first_name.empty?
      raise "Invalid 'first_name' field: #{first_name}"
    end
  end

  def validate_last_name(last_name)
    unless last_name.is_a?(String) && !last_name.empty?
      raise "Invalid 'last_name' field: #{last_name}"
    end
  end

  def validate_email(email)
    email_regex = /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/
    unless email.is_a?(String) && email.match?(email_regex)
      raise "Invalid 'email' field: #{email}"
    end
  end

  def validate_company_id(company_id)
    unless company_id.is_a?(Integer) && company_id > 0
      raise "Invalid 'company_id' field: #{company_id}"
    end
  end

  def validate_email_status(email_status)
    unless [true, false].include?(email_status)
      raise "Invalid 'email_status' field: #{email_status}"
    end
  end

  def validate_active_status(active_status)
    unless [true, false].include?(active_status)
      raise "Invalid 'active_status' field: #{active_status}"
    end
  end

  def validate_tokens(tokens)
    unless tokens.is_a?(Integer) && tokens >= 0
      raise "Invalid 'tokens' field: #{tokens}"
    end
  end
end
