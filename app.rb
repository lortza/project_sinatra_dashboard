require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'erb'
require 'pry'

# Classes
require './models/job.rb'
require './models/scraper.rb'

# Routes
enable :sessions

get '/' do
  # Build objects
  job1 = Job.new
  job1.title = 'Super Amazing Job'
  job1.job_id = '123'
  job1.description_url = 'http://www.google.com'
  job1.company = 'JazzHandRama'
  job1.company_id ='254'
  job1.location = 'Omaha'
  job1.description = 'super job with fantastic happiness'
  job1.date_posted = 'October Teenth'
  job1.salary = '10,000,000'
  job1.skills = 'ruby'
  job1.remote = true

  jobs = [job1]

  # Modify objects

  # Save objects to session
  session['jobs'] = [job1, job1, job1, job1]

  # Output data to view
  erb :index, locals: { jobs: jobs }
end

post '/search' do
  # Build objects
  keyword = params['title_keyword']
  location = params['location']
  scraper = Scraper.new('https://www.dice.com')

  # Modify objects
  matches = session['jobs']
  # matches = scraper.scrape(title: keyword, location: location)
  # scraper.scrape(title: 'Ruby on Rails Engineer', location: 'New Orleans, LA')
  # scraper.scrape(title: 'Data Analyst Business Analyst', location: 'New Orleans, LA', name: 'Josh')

  # Save objects to session

  # Output data to view
  erb :index, locals: { jobs: matches }
end