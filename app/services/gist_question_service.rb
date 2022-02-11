class GistQuestionService

  def initialize(question)
    @question = question
    @test = @question.test
    @client = default_client
  end

  def call
    @result = @client.create_gist(gist_params)
    @result
  end

  def success?
    @client.last_response.status == 201
  end

  def url
    @result.html_url
  end

  private

  def gist_params
    {
      description: I18n.t('services.gist_question_service.description', title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

  def default_client
    Octokit::Client.new(access_token: ENV['GITHUB_TEST_GURU_TOKEN'])
  end
end 