require "rails_helper"

RSpec.describe RecordSearchJob, type: :job do
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers

  let(:ip_address) { "192.168.1.1" }
  let(:session_window) { Search::SESSION_WINDOW }

  before do
    Search.delete_all
  end

  context "when it is the first search" do
    it "creates a new search record" do
      expect {
        perform_enqueued_jobs { RecordSearchJob.perform_later(query: "first query", ip_address: ip_address) }
      }.to change(Search, :count).by(1)
      expect(Search.last.query).to eq("first query")
    end
  end

  context "when a search is performed within the session window" do
    let!(:last_search) { Search.create!(query: "apple", ip_address: ip_address, created_at: (session_window - 1.second).ago) }

    it "updates the last search record if it is a continuation" do
      expect {
        perform_enqueued_jobs { RecordSearchJob.perform_later(query: "apples", ip_address: ip_address) }
      }.not_to change(Search, :count)
      expect(last_search.reload.query).to eq("apples")
    end

    it "creates a new record if the query is unrelated" do
      expect {
        perform_enqueued_jobs { RecordSearchJob.perform_later(query: "banana", ip_address: ip_address) }
      }.to change(Search, :count).by(1)
    end
  end

  context "when a search is performed after the session window" do
    before do
      # Create a search record that is outside the session window
      travel_to (session_window + 1.minute).ago do
        Search.create!(query: "old query", ip_address: ip_address)
      end
    end

    it "updates the timestamp of an existing record if it is an exact duplicate" do
      old_record = Search.create!(query: "exact match", ip_address: ip_address, created_at: 2.days.ago)

      expect {
        perform_enqueued_jobs { RecordSearchJob.perform_later(query: "exact match", ip_address: ip_address) }
      }.not_to change(Search, :count)

      expect(old_record.reload.updated_at).to be > old_record.created_at
    end

    it "creates a new record for a brand new query" do
      expect {
        perform_enqueued_jobs { RecordSearchJob.perform_later(query: "new query", ip_address: ip_address) }
      }.to change(Search, :count).by(1)
    end
  end
end
