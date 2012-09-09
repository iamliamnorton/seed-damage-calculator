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
    #ensure_test_coverage 100
    puts "\n"
  end

  def ensure_test_coverage(threshold)
    doc = Nokogiri::HTML File.read("coverage/index.html")
    node = doc.css("h2:first .covered_percent").first
    covered = node.content.to_f
    raise "The test coverage #{covered}% is below the threshold of #{threshold}%. Not good enough, sorry." if covered < threshold
  end
end