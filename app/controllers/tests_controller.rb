class TestsController < ApplicationController
  def index
    @tfp_tests = TfpTest.all
    @tfp_test = TfpTest.new
  end

  def new
    @tfp_test = TfpTest.new
  end

  def create

    @tfp_test = TfpTest.new(params[:tfp_test])
    @tfp_test.save
    @tfp_tests = TfpTest.all
    render :partial => 'list', :locals => {:tests => @tfp_tests}
  end

  def edit
    @tfp_test = TfpTest.find(params[:id])
    @selected_questions = @tfp_test.questions
    @available_questions = Question.all - @selected_questions
    render :partial => 'edit', :locals => {:tfp_test => @tfp_test}
  end

  def update
    @tfp_test = TfpTest.find(params[:id])
    @tfp_test.update_attributes(params[:tfp_test])
    @tfp_tests = TfpTest.all
    binding.pry
    render :partial => 'list', :locals => {:tfp_tests => @tfp_tests}
  end

  def add_question
    question = Question.find(params[:id])
    @tfp_test = TfpTest.find(params[:test_id])
    @selected_questions = @tfp_test.questions.push * question
    @available_questions = Question.all - @selected_questions
    render :partial => 'add_remove_questions', :locals => { :selected_question => @selected_question, :available_questions => @available_questions, :tfp_test => @tfp_test }
  end

  def remove_question
    question = Question.find(params[:id])
    @tfp_test = TfpTest.find(params[:test_id])
    @tfp_test.questions.delete(question)
    @selected_questions = @tfp_test.questions.reload
    @available_questions = Question.all - @selected_questions
    render :partial => 'add_remove_questions', :locals => { :selected_question => @selected_question, :available_questions => @available_questions, :tfp_test => @tfp_test }
  end

end
