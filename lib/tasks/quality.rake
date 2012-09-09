namespace :quality do
  desc "Run all code quality checks"
    task :all => [:design, :complexity, :convention, :coverage]

  desc "Checking code for design issues using Roodi"
  task :design => :environment do
    puts "\nChecking code for design issues using Roodi\n"
    system('roodi app/**/*.rb config/roodi.yml')
    #RoodiTask.new 'roodi', ['app/**/*.rb', 'lib/**/*.rb'], './config/roodi.yml'
    puts "\n"
  end

  desc "Checking code for complexity issues using Metric_abc"
  task :complexity => :environment do
    puts "\nChecking code for complexity issues using Metric_abc\n"
    system('metric_abc app/**/*.rb')
    puts "\n"
  end

  desc "Checking code for proper rails conventions using Rails-best-practices"
  task :convention => :environment do
    puts "\nChecking code for proper rails conventions using Rails-best-practices\n"
    system('rails_best_practices .')
    puts "\n"
  end

  desc "Checking specs for code coverage with SimpleCov"
  task :coverage => :environment do
    puts "\nChecking specs for code coverage with SimpleCov\n"
    Rake::Task['spec'].invoke
    puts "\n"
  end
end