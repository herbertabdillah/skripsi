require 'factory'
namespace :seed do
  desc "TODO"

  task :fill_semester_and_sync_until, [:start_semester, :end_semester]  => [:environment] do |t, args|
    Factory.fill_semester_and_sync_until(args[:start_semester].to_i,args[:end_semester].to_i)
  end
end
