# frozen_string_literal: true

module IvyMeter
  class OpCode
    attr_reader :machine_type, :code, :equipment_description, :stop_the_clock_scan,
                :clearance_cutoff_time, :handling_event_type, :piece_mail_type, :mail_level,
                :mail_phase, :process_description, :available_date, :last_updated

    def initialize(attributes = {})
      @machine_type = attributes[:machine_type]
      @code = attributes[:code]
      @equipment_description = attributes[:equipment_description]
      @stop_the_clock_scan = attributes[:stop_the_clock_scan]
      @clearance_cutoff_time = attributes[:clearance_cutoff_time]
      @handling_event_type = attributes[:handling_event_type]
      @piece_mail_type = attributes[:piece_mail_type]
      @mail_level = attributes[:mail_level]
      @mail_phase = attributes[:mail_phase]
      @process_description = attributes[:process_description]
      @available_date = attributes[:available_date]
      @last_updated = attributes[:last_updated]
    end

    def self.find(code)
      code = code.to_s
      OPCODES[code] || UNEXPECTED_CODES[code]
    end

    def unexpected?
      UNEXPECTED_CODES.key?(code)
    end

    def stop_the_clock_scan?
      !!stop_the_clock_scan
    end
  end
end
