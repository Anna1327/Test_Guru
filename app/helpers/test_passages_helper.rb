module TestPassagesHelper
  def current_question
    "Question #{@test_passage.current_question_num} of #{@test_passage.test.questions.count}"
  end
end
