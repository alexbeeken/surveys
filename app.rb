require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get("/") do
  erb(:home)
end

get("/user_dash") do
  @surveys = Survey.all()
  erb(:user_dash)
end

get("/form") do
  erb(:form)
end

post("/create_survey") do
  @survey = Survey.create({:title => params.fetch("title")})
  @question = Question.create({:text => params.fetch("question"), :survey_id => @survey.id()})
  answer1 = Answer.create({:text => params.fetch("answer1"), :question_id => @question.id})
  answer2 = Answer.create({:text => params.fetch("answer2"), :question_id => @question.id})
  answer3 = Answer.create({:text => params.fetch("answer3"), :question_id => @question.id})
  answer4 = Answer.create({:text => params.fetch("answer4"), :question_id => @question.id})
  redirect '/dashboard'
end

get("/dashboard") do
  @surveys = Survey.all()
  erb(:dashboard)
end

post('/delete_survey') do
  id = params.fetch("id").to_i
  Survey.destroy(Survey.find(id))
  redirect '/dashboard'
end

post('/edit_form') do
  id = params.fetch("id").to_i
  @survey = Survey.find(id)
  @questions = @survey.questions
  @answers = @questions[0].answers
  erb(:edit_form)
end

post("/update_survey") do
  @survey = Survey.find(params.fetch("survey_id"))
  @survey.update({:title => params.fetch("title")})
  @question = Question.find(params.fetch("question_id"))
  @question.update({:text => params.fetch("question")})
  answer1 = Answer.find(params.fetch("answer1_id"))
  answer1.update({:text => params.fetch("answer1")})
  answer2 = Answer.find(params.fetch("answer2_id"))
  answer2.update({:text => params.fetch("answer2")})
  answer3 = Answer.find(params.fetch("answer3_id"))
  answer3.update({:text => params.fetch("answer3")})
  answer4 = Answer.find(params.fetch("answer4_id"))
  answer4.update({:text => params.fetch("answer4")})
  redirect '/dashboard'
end
