require_relative 'readers/companies_reader'
require_relative 'readers/user_reader'
require_relative 'models/company' 
require_relative 'models/user'    

companies_reader = CompaniesReader.new
user_reader = UserReader.new

puts "Companies:"
companies_reader.companies.each do |company|
  puts "ID: #{company.id}, Name: #{company.name}, Top Up: #{company.top_up}, Email Status: #{company.email_status}"
end

puts "\nUsers:"
user_reader.users.each do |user|
  puts "#{user.first_name} #{user.last_name}: #{user.tokens} tokens, Company ID: #{user.company_id}, Active: #{user.active_status}"
end
