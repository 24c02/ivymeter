# frozen_string_literal: true

require 'json'
require 'date'
require_relative '../prop'
require_relative '../opcode'

module IvyMeter
  class Event
    include Prop

    class << self
      def inherited(subclass)
        subclass.instance_variable_set(:@property_mappings, property_mappings.dup)
      end

      def prop(name, json_name, csv_name, type: nil)
        attr_accessor name

        @property_mappings ||= {}
        @property_mappings[name] = { json: json_name, csv: csv_name, type: type }
      end

      def property_mappings
        @property_mappings || {}
      end

      def from_json(json_data)
        event = new
        property_mappings.each do |attr_name, mappings|
          value = json_data[mappings[:json]]
          next if value.nil?

          event.send("#{attr_name}=", convert_value(value, mappings[:type]))
        end
        event
      end

      def from_csv(row)
        event = new
        property_mappings.each do |attr_name, mappings|
          value = row[mappings[:csv]]
          next if value.nil?

          event.send("#{attr_name}=", convert_value(value, mappings[:type]))
        end
        event
      end

      private

      def convert_value(value, type)
        case type
        when :date
          Date.parse(value)
        when :datetime
          DateTime.parse(value)
        else
          value
        end
      end
    end

    def to_json(*_args)
      result = {}
      self.class.property_mappings.each do |attr_name, mappings|
        value = send(attr_name)
        if value.is_a?(DateTime) && mappings[:type] == :datetime
          value = value.strftime('%Y-%m-%d %H:%M:%S%z')
        elsif value.is_a?(Date) && mappings[:type] == :date
          value = value.strftime('%Y-%m-%d')
        end
        result[mappings[:json]] = value
      end
      result.compact.to_json
    end

    # Common eDoc properties
    prop :edoc_job_id, 'edocJobId', 'eDoc Job ID'
    prop :edoc_mailing_group_id, 'edocMailingGroupId', 'eDoc Mailing Group ID'
    prop :edoc_submitter_crid, 'edocSubmitterCrid', 'eDoc Submitter CRID'

    # Common handling event properties
    prop :scan_datetime, 'scanDatetime', 'Scan DateTime', type: :datetime
    prop :scan_event_code, 'scanEventCode', 'Scan Event Code'
    prop :scan_facility_city, 'scanFacilityCity', 'Scan Facility City'
    prop :scan_facility_name, 'scanFacilityName', 'Scan Facility Name'
    prop :scan_facility_state, 'scanFacilityState', 'Scan Facility State'
    prop :scan_facility_zip, 'scanFacilityZip', 'Scan Facility ZIP'
    prop :scan_locale_key, 'scanLocaleKey', 'Scan Locale Key'
    prop :handling_event_type, 'handlingEventType', 'Handling Event Type'
    prop :handling_event_type_description, 'handlingEventTypeDescription', 'Handling Event Type Description'

    # Common mail properties
    prop :mail_class_description, 'mailClassDescription', 'Mail Class Description'
    prop :mail_shape_description, 'mailShapeDescription', 'Mail Shape Description'

    # Common scanner properties
    prop :scanner_type, 'scannerType', 'Scanner Type'
    prop :machine_name, 'machineName', 'Machine Name'
    prop :device_id, 'deviceId', 'Device ID'

    # Common start the clock properties
    prop :start_the_clock_date, 'startTheClockDate', 'Start the Clock Date', type: :date
    prop :start_the_clock_facility_address, 'startTheClockFacilityAddress', 'Start the Clock Facility Address'
    prop :start_the_clock_facility_city, 'startTheClockFacilityCity', 'Start the Clock Facility City'
    prop :start_the_clock_facility_locale_key, 'startTheClockFacilityLocaleKey', 'Start the Clock Facility Locale Key'
    prop :start_the_clock_facility_name, 'startTheClockFacilityName', 'Start the Clock Facility Name'
    prop :start_the_clock_facility_state, 'startTheClockFacilityState', 'Start the Clock Facility State'
    prop :start_the_clock_facility_zip, 'startTheClockFacilityZip', 'Start the Clock Facility ZIP'

    # Common recipient CRID properties
    prop :recipient_crid_of_mid_on_piece, 'recipientCridOfMidOnPiece', 'Recipient CRID of MID on Piece'
    prop :recipient_crid_of_mid_on_piece_delegator, 'recipientCridOfMidOnPieceDelegator',
         'Recipient CRID of MID on Piece Delegator'
    prop :recipient_mail_owner_crid, 'recipientMailOwnerCrid', 'Recipient Mail Owner CRID'
    prop :recipient_mail_owner_delegator_crid, 'recipientMailOwnerDelegatorCrid', 'Recipient Mail Owner Delegator CRID'
    prop :recipient_routing_code_authorized_crid, 'recipientRoutingCodeAuthorizedCrid',
         'Recipient Routing Code Authorized CRID'

    # Common operational status
    prop :operational_status, 'operationalStatus', 'Operational Status'

    # Common handling event properties
    prop :handling_event_datetime, 'handlingEventDateTime', 'Handling Event DateTime'
    prop :handling_event_facility_city, 'handlingEventFacilityCity', 'Handling Event Facility City'
    prop :handling_event_facility_name, 'handlingEventFacilityName', 'Handling Event Facility Name'
    prop :handling_event_facility_state, 'handlingEventFacilityState', 'Handling Event Facility State'
    prop :handling_event_facility_zip, 'handlingEventFacilityZip', 'Handling Event Facility ZIP Code'
    prop :handling_event_locale_key, 'handlingEventLocaleKey', 'Handling Event Locale Key'
    prop :handling_event_scan_state, 'handlingEventScanState', 'Handling Event Scan State'

    # Common eDoc properties
    prop :edoc_container_id, 'edocContainerId', 'eDoc Container ID'
    prop :edoc_csa_agreement_id, 'edocCsaAgreementId', 'eDoc CSA Agreement ID'
    prop :edoc_customer_group_id, 'edocCustomerGroupId', 'eDoc Customer Group ID'
    prop :edoc_parent_container_id, 'edocParentContainerId', 'eDoc Parent Container ID'
    prop :edoc_sibling_container_id, 'edocSiblingContainerId', 'eDoc Sibling Container ID'
    prop :edoc_user_license_code, 'edocUserLicenseCode', 'eDoc User License Code'

    # Common recipient CRID properties
    prop :recipient_edoc_submitter_crid, 'recipientEdocSubmitterCrid', 'Recipient eDoc Submitter CRID'
    prop :recipient_edoc_submitter_delegator_crid, 'recipientEdocSubmitterDelegatorCrid',
         'Recipient eDoc Submitter Delegator CRID'
    prop :recipient_mail_preparer_crid, 'recipientMailPreparerCrid', 'Recipient Mail Preparer CRID'
    prop :recipient_mail_preparer_delegator_crid, 'recipientMailPreparerDelegatorCrid',
         'Recipient Mail Preparer Delegator CRID'

    # Common mail properties
    prop :piece_count, 'pieceCount', 'Piece Count'

    def actual?
      handling_event_type == 'A'
    end

    def assumed_actual?
      handling_event_type == 'AA'
    end

    def logical?
      handling_event_type == 'L'
    end

    def assumed_logical?
      handling_event_type == 'AL'
    end

    def assumed?
      assumed_actual? || assumed_logical?
    end

    def opcode
      @opcode ||= OpCode.find(scan_event_code)
    end

    def stop_the_clock_scan?
      opcode&.stop_the_clock_scan?
    end

    def unexpected_opcode?
      opcode&.unexpected?
    end

    def clearance_cutoff_time
      opcode&.clearance_cutoff_time
    end

    def mail_phase
      opcode&.mail_phase
    end

    def process_description
      opcode&.process_description
    end
  end
end
