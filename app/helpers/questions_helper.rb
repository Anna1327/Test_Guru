module QuestionsHelper
  def question_header(question)
    if question.persisted?
        "Edit new #{question.test.title} question"
    else
        "Create new #{question.test.title} question"
    end
  end
end
