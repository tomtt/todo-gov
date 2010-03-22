namespace :todo_gov do
  desc "Resave all models with serialized data"
  task :resave_models_with_serialized_data => :environment do
    Item.all.each { |i| i.save! }
    User.all.each { |u| u.save! }
  end
end
