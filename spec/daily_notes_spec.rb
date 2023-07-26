# frozen_string_literal: true

require "active_support"
require "active_support/time_with_zone"
require "active_support/core_ext/time/zones"
require "awesome_print"
require "timecop"
require "fileutils"
require_relative '../lib/daily_notes'
require_relative 'daily_notes_test_helpers'

RSpec.describe DailyNotes do
  before do
    @daily_notes_file_test_path = "tmp/07/7.02/daily_notes.md"
    @base_path = File.expand_path("tmp")
    create_temp_folder
    init_time_zone
  end

  after do
    teardown
  end

  it "has a version number" do
    expect(DailyNotes::VERSION).not_to be nil
  end

  it 'creates a daily notes file' do
    create_daily_notes
    expect(File.exist?(@daily_notes_file_test_path)).to be true
  end

  it 'adds the right contents to the daily notes file' do
    create_daily_notes
    contents = File.read(@daily_notes_file_test_path)
    expected_contents = <<~EOS
      ---
      Title: Daily Notes for July 2nd, 2022
      Date: 07.02.2022
      ---

      # Daily Notes for July 2nd, 2022

    EOS

    expect(contents).to eq(expected_contents)
  end

  it 'does not overwrite existing file' do
    create_daily_notes
    new_contents = "new contents"
    File.write(@daily_notes_file_test_path, new_contents)
    create_daily_notes
    contents = File.read(@daily_notes_file_test_path)
    expect(contents).to eq(new_contents)
  end

  it 'raises an error if base path is not passed in' do
    expect{
      create_daily_notes(base_path: nil)
    }.to raise_error(RuntimeError, "Base path can not be empty")

  end

  it 'raises an error if base path does not exist' do
    expect{
      create_daily_notes(base_path: "whatever")
    }.to raise_error(RuntimeError, "Base path must exist")
  end

  it 'prints the new filename and path to stdout' do
    expect {
      create_daily_notes
    }.to output("Created daily notes file at #{@base_path}/07/7.02/daily_notes.md\n").to_stdout
  end

  describe 'opening the IDE after creating the file' do
    let(:system_caller) { double(:system_caller) }
    let(:call_string) { "code -r \"#{@base_path}/07/7.02/daily_notes.md\"" }

    before do
      allow(system_caller).to receive(:call_system)
    end

    it 'opens opens the editor to the new file' do
      create_daily_notes(system_caller: system_caller)
      expect(system_caller).to have_received(:call_system).with(call_string)
    end
  end
end
