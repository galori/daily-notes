def create_temp_folder
  FileUtils.mkdir_p(@base_path)
end

def teardown
  delete_temp_files
end

def init_time_zone
  Time.zone = "Pacific Time (US & Canada)"
end

def mock_system_caller
  system_caller = double(:sytem_caller)
  allow(system_caller).to receive(:call_system)
  system_caller
end

def create_daily_notes(base_path: @base_path, system_caller: mock_system_caller)
  Timecop.travel(Time.zone.local(2023, 7, 02, 13, 0, 0)) do
    DailyNotes::DailyNotesCreationService.new(base_path: base_path, system_caller: system_caller).perform
  end
end

def delete_temp_files
  FileUtils.rm_rf(@base_path)
end