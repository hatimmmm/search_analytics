require "rails_helper"

RSpec.describe Search, type: :model do
  include ActiveJob::TestHelper

  let(:ip_address) { "192.168.1.1" }

  before do
    clear_enqueued_jobs
    Rails.cache.clear
  end

  describe "validations" do
    it "is valid with query and ip_address" do
      search = Search.new(query: "test", ip_address: ip_address)
      expect(search).to be_valid
    end

    it "is invalid without query" do
      search = Search.new(ip_address: ip_address)
      expect(search).not_to be_valid
    end

    it "is invalid without ip_address" do
      search = Search.new(query: "test")
      expect(search).not_to be_valid
    end
  end

  describe ".record" do
    it "enqueues job for valid parameters" do
      expect {
        Search.record(query: "test", ip_address: ip_address)
      }.to have_enqueued_job(RecordSearchJob)
    end

    it "does not enqueue job for blank query" do
      expect {
        Search.record(query: "", ip_address: ip_address)
      }.not_to have_enqueued_job(RecordSearchJob)
    end

    it "does not enqueue job for blank ip_address" do
      expect {
        Search.record(query: "test", ip_address: "")
      }.not_to have_enqueued_job(RecordSearchJob)
    end

    it "updates cache when called" do
      cache_key = "last_search_query_for_#{ip_address}"

      Search.record(query: "test", ip_address: ip_address)

      expect(Rails.cache.read(cache_key)).to eq("test")
    end

    it "does not enqueue duplicate queries" do
      Search.record(query: "test", ip_address: ip_address)
      clear_enqueued_jobs

      expect {
        Search.record(query: "test", ip_address: ip_address)
      }.not_to have_enqueued_job(RecordSearchJob)
    end

    it "enqueues different queries" do
      Search.record(query: "test1", ip_address: ip_address)
      clear_enqueued_jobs

      expect {
        Search.record(query: "test2", ip_address: ip_address)
      }.to have_enqueued_job(RecordSearchJob)
    end

    it "treats queries case-insensitively" do
      Search.record(query: "TEST", ip_address: ip_address)
      clear_enqueued_jobs

      expect {
        Search.record(query: "test", ip_address: ip_address)
      }.not_to have_enqueued_job(RecordSearchJob)
    end

    it "ignores whitespace differences" do
      # First call with spaces
      Search.record(query: "  test  ", ip_address: ip_address)
      clear_enqueued_jobs

      expect {
        Search.record(query: "test", ip_address: ip_address)
      }.not_to have_enqueued_job(RecordSearchJob)
    end
  end
end
