require 'test_helper'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/blip_pl_api'

require 'fakeweb'
require 'json'
class BlipPlApiTest < ActiveSupport::TestCase
  def setup
    @api_url = 'http://api.blip.pl'
    @fake_id = 33231558;
    @fake_status = '{"type":"Status","transport":{"name":"www","id":6},"body":"http://blip.pl/s/33231470 podstawy w ratownictwie medycznym ;-)","created_at":"2010-01-11 22:50:56","id":33231558,"user_path":"/users/jansebastiantrach"}'
    @fake_id_doesn_exist = 4455;
  end
  # Replace this with your real tests.
  def test_should_exist_and_not_throw_errors
    blip = BlipPlApi.new
    assert_instance_of BlipPlApi, blip
    assert_equal @api_url, blip.api_root
  end
  def test_should_get_a_update
    fake_resp = "got "+@fake_id.to_s
    FakeWeb.register_uri(:get, @api_url+'/updates/'+@fake_id.to_s , {:body => fake_resp})
    FakeWeb.register_uri(:get, @api_url+'/updates/'+@fake_id_doesn_exist.to_s , {:body => ""})
    blip = BlipPlApi.new
    assert_equal fake_resp, blip.get_status_by_id(@fake_id.to_s)
    assert_equal "", blip.get_status_by_id(@fake_id_doesn_exist.to_s)
  end
  def test_should_parse_json
  end
end
