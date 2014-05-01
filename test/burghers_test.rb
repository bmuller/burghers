require 'minitest/autorun'
require 'burghers'

class BurghersTest < MiniTest::Test
  def setup
    # NOTE: these tests make real HTTP calls, so they probably
    # can't be run often due to API rate limits, but can be
    # used to help catch regressions
    @client = Burghers::Client.new("3zjwnzgr6ptek99nqgebwx9r")
    @expected = [{:name=>"Education", :score=>1.0},
                {:name=>"Labor", :score=>0.952},
                {:name=>"Business_Finance", :score=>0.875},
                {:name=>"Politics", :score=>0.566}]
  end

  def test_with_text
    content = "The government of the United Kingdom has given corporations like fast food chain McDonald's the right to award high school qualifications to employees who complete a company training program."
    assert_equal @expected, @client.enrich(content).topics
  end

  def test_with_html
    content = "<html><body>The government of the United Kingdom has given corporations like fast food chain McDonald's the right to award high school qualifications to employees who complete a company training program.</html></body>"
    assert_equal @expected, @client.enrich(content).topics
  end

  def test_with_url
    content = "http://www.washingtonpost.com/lifestyle/style/rep-vance-mcallister-kissed-now-can-he-make-up-with-voters-after-the-scandal/2014/04/16/9a898fde-c57c-11e3-9f37-7ce307c56815_story.html"
    expected = [{:name=>"Politics", :score=>0.66}]
    assert_equal expected, @client.enrich(content).topics
  end
end
