# typed: strict
# frozen_string_literal: true

require "active_support"
require "active_support/time_with_zone"
require "active_support/core_ext/time/zones"
require "active_support/core_ext/integer/inflections"

module DailyNotes
  class DailyNotesCreationService
    def initialize(base_path:, system_caller:)
      @base_path = base_path
      @system_caller = system_caller
    end

    def perform
      validate_base_path
      init_time_zone
      create_folder
      create_daily_notes_file unless file_exists?
      open_file_in_intellij
    end

    private

    attr_accessor :base_path, :system_caller

    def open_file_in_intellij
      system_caller.call_system("idea \"#{folder_and_file_with_path}\"")
    end

    def validate_base_path
      validate_base_path_parameter_not_empty
      validate_base_path_exists
    end

    def validate_base_path_parameter_not_empty
      if base_path.to_s.empty?
        raise "Base path can not be empty"
      end
    end

    def validate_base_path_exists
      unless File.directory?(base_path)
        raise "Base path must exist"
      end
    end

    def init_time_zone
      Time.zone = "Pacific Time (US & Canada)"
    end

    def date_for_markdown
      Time.now.strftime("%m.%d.%Y")
    end

    def month
      Time.now.strftime("%-m")
    end

    def padded_month
      Time.now.strftime("%m")
    end

    def padded_day
      Time.now.strftime("%d")
    end

    def folder_with_path
      "#{base_path}/#{padded_month}/#{month}.#{padded_day}"
    end

    def create_folder
      require "fileutils"
      FileUtils.mkdir_p(folder_with_path)
    end

    def file_exists?
      File.exist?(folder_and_file_with_path)
    end

    def folder_and_file_with_path
      filename = "daily_notes.md"
      folder_with_path + "/" + filename
    end

    def spelled_out_date
      # Example:  December 21st, 2022
      Time.now.strftime("%B #{Time.now.day.ordinalize}, %Y")
    end

    def create_daily_notes_file
      daily_notes_template_text = <<~EOS
        ---
        Title: Daily Notes for #{spelled_out_date}
        Date: #{date_for_markdown}
        ---

        # Daily Notes for #{spelled_out_date}

      EOS
      File.write(folder_and_file_with_path, daily_notes_template_text)
      puts "Created daily notes file at #{folder_and_file_with_path}"
    end
  end
end
