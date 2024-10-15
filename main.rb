require_relative 'readers/companies_reader'
require_relative 'readers/user_reader'
require_relative 'models/company'
require_relative 'models/user'
require_relative 'writer/file_writer'

def sort_by_last_name(users)
  users.sort_by! { |user| user[:name] }
end

companies_reader = CompaniesReader.new
user_reader = UserReader.new
f = FileWriter.new('output.txt')

sorted_companies = companies_reader.companies.sort_by(&:id)

sorted_companies.each do |company|
  f.add("Company Id: #{company.id}")
  f.add("Company Name: #{company.name}")
  f.add("Users Emailed:")
  
  users_emailed = []
  users_not_emailed = []
  total_top_up = 0

  user_reader.users.each do |user|
    next if user.company_id != company.id

    new_balance = user.tokens + company.top_up
    total_top_up += company.top_up

    if user.email_status
      users_emailed << { name: "#{user.last_name}, #{user.first_name}", email: user.email, previous_balance: user.tokens, new_balance: new_balance }
    else
      users_not_emailed << { name: "#{user.last_name}, #{user.first_name}", email: user.email, previous_balance: user.tokens, new_balance: new_balance }
    end
    # In the real world here we would save user tokens and company total, maybe?
  end

  sort_by_last_name(users_emailed)
  users_emailed.each do |user|
    f.add("  #{user[:name]}, #{user[:email]}")
    f.add("    Previous Token Balance: #{user[:previous_balance]}")
    f.add("    New Token Balance: #{user[:new_balance]}")
  end

  sort_by_last_name(users_not_emailed)
  f.add("Users Not Emailed:")
  users_not_emailed.each do |not_emailed_user|
    f.add("  #{not_emailed_user[:name]}, #{not_emailed_user[:email]}")
    f.add("    Previous Token Balance: #{not_emailed_user[:previous_balance]}")
    f.add("    New Token Balance: #{not_emailed_user[:new_balance]}")
  end

  f.add("Total amount of top ups for #{company.name}: #{total_top_up}")
  f.add("")
end

f.write
