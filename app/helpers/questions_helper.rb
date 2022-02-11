module QuestionsHelper
  def question_header(question)
    if question.persisted?
      "#{I18n.t('admin.questions.edit.edit_question')} #{question.test.title}"
    else
      "#{I18n.t('admin.questions.new.create_question')} #{question.test.title}"
    end
  end
end
