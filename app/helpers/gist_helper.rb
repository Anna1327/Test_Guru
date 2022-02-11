module GistHelper
  def gist_hash(html_url)
    html_url.split('/').last
  end
end