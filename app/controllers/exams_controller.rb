class ExamsController < ApplicationController
  def index
    @exams = Exam.all
    @exam = Exam.new
  end

  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.new(params[:exam])
    @exam.save
    @exams = Exam.all
    
    # render :partial => 'list', :locals => {:exams => @exams}
    partial_locals = {:exams => @exams}
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "list", :partial_locals => partial_locals, :modal_id => "add_exam", :button_caption => params[:commit] }
  end

  def edit
    @exam = Exam.find(params[:id])
    @selected_tests = @exam.tfp_tests
    @available_tests = TfpTest.all - @selected_tests
    render :partial => 'edit', :locals => {:exam => @exam}
  end

  def update
    @exam = Exam.find(params[:id])
    @exam.update_attributes(params[:exam])
    @exams = Exam.all
    render :partial => 'list', :locals => {:exams => @exams}
  end

  def add_test

    test = TfpTest.find(params[:id])
    @exam = Exam.find(params[:exam_id])
    @selected_tests = @exam.tfp_tests.push * test
    @available_tests = TfpTest.all - @selected_tests
    render :partial => 'add_remove_tests', :locals => { :selected_tests => @selected_tests, :available_tests => @available_tests, :exam => @exam }
  end

  def remove_test
    test = TfpTest.find(params[:id])
    @exam = Exam.find(params[:exam_id])
    @exam.tfp_tests.delete(test)
    @selected_tests = @exam.tfp_tests.reload
    @available_tests = TfpTest.all - @selected_tests
    render :partial => 'add_remove_tests', :locals => { :selected_tests => @selected_tests, :available_tests => @available_tests, :exam => @exam }
  end
  
  def dashboard
    
  end

end
