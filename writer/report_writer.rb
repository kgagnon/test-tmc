class ReportWriter
  def initialize(file_writer)
    @file_writer = file_writer
    @company_name = nil
    @company_id = nil
    @total_top_up = 0
    @users_emailed = []
    @users_not_emailed = []
  end

  def set_company(name, id)
    @company_name = name
    @company_id = id
  end

  def add_user(user, top_up)
    user_info = {
      name: "#{user.last_name}, #{user.first_name}",
      email: user.email,
      previous_balance: user.tokens,
      new_balance: user.tokens + top_up,
    }

    if user.email_status
      @users_emailed << user_info
    else
      @users_not_emailed << user_info
    end
  end

  def set_total_top_up(amount)
    @total_top_up = amount
  end

  def print_document
    @file_writer.write
  end

  def print_company
    return if @users_emailed.empty? && @users_not_emailed.empty?

    @file_writer.add("Company Id: #{@company_id}")
    @file_writer.add("Company Name: #{@company_name}")
    @file_writer.add("Users Emailed:")
    sort_and_print_users(@users_emailed)

    @file_writer.add("Users Not Emailed:")
    sort_and_print_users(@users_not_emailed)

    @file_writer.add("Total amount of top ups for #{@company_name}: #{@total_top_up}")
    @file_writer.add("")

    clear
  end

  private

  def sort_and_print_users(users)
    users.sort_by! { |user| user[:name] }
    users.each do |user|
      @file_writer.add("  #{user[:name]}, #{user[:email]}")
      @file_writer.add("    Previous Token Balance: #{user[:previous_balance]}")
      @file_writer.add("    New Token Balance: #{user[:new_balance]}")
    end
  end

  def clear
    @company_name = nil
    @company_id = nil
    @total_top_up = 0
    @users_emailed.clear
    @users_not_emailed.clear
  end
end
