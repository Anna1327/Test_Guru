class Version

  attr_reader :major, :minor, :patch

  def initialize(version)
    @major, @minor, @patch = version.split('.').map(&:to_i)
  end

  def current_version
    "#{@major}.#{@minor}.#{@patch}"
  end
end 