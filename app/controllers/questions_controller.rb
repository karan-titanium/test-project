class QuestionsController < ApplicationController
  
  def index
    # Objective: To List all the Question in the system.
    # Inputs: This is called when user lands on Manage Questions page. it needs no inputs.
    # Logic: It Fetches all the questions from the database stores them in @question instance variable and makes
    # them available on view.
    # Output: List of all the questions from Database.

    @questions = Question.all
    @new_question = Question.new(:content => "test content")
  end

  def create
    # Objective: Store the Newly created Question in Database.
    # Input : Accepts the form containing Newly created question as a paramter(data) in params.
    # Logic: Stores the form data into the new empty Question Object instanciatedd from Question Model
    # and saves it to Database.
    # Output: Renders partial having list of all the Questions from database including new question now

    @question = Question.new(params[:question])
    @question.save
    @questions = Question.all
    render :partial => 'list', :locals => {:questions => @questions}
  end

  def edit
    @question =  Question.includes(:cdn_files, :question_files).find(params[:id])
    # @question.question_files.build
    # binding.pry

    render :partial => 'edit', :locals => {:question => @question}
  end

  def update
    @question = Question.find(params[:id])
    binding.pry
    cdn_files = params[:question][:cdn_files_attributes]
    cdn_files.each{|c| CdnFile.find(c.last['id']).destroy if c.last["_destroy"]=="1" } if cdn_files
    @question.update_attributes(params[:question])

    # @question.save(params[:question])
    binding.pry
    respond_to do |format|
      format.js
    end
  # render :partial => 'show', :locals => {:question => @question}
  end

  def remove_files

    file = CdnFile.find(params[:id])
    question =  Question.includes(:cdn_files, :question_files).find(file.question_file.question_id)
    file.destroy
    @question = question.reload
    # binding.pry
    render :partial => "question_file_fields", :locals => {:question => @question}
  end

  def select_question_part
    question_part_type = params[:question_part_type]
    binding.pry
    case params[:question_part_type]
    when "multiple"
      render :partial => "question_part_multiple_fields", :locals => {:f =>  Question.find(params[:question_id]).question_parts.build(:question_part_type => "multiple")}
    when "select"
      render :partial => "question_part_select_fields",  :locals => {:f =>  Question.find(params[:question_id]).question_parts.build(:question_part_type => "select")}
    when "text"
      render :partial => "question_part_text_fields",  :locals => {:f =>  Question.find(params[:question_id]).question_parts.build(:question_part_type => "text")}
    end
  end
  
end
