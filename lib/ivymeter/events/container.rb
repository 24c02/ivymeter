# frozen_string_literal: true

require_relative 'base'

module IvyMeter
  class Event
    class ContainerEvent < Event
      # Container-specific properties
      prop :container_id, 'containerId', 'Container ID'
      prop :bundle_count, 'bundleCount', 'Bundle Count'
      prop :edoc_container_id, 'edocContainerId', 'eDoc Container ID'
      prop :edoc_container_zip, 'edocContainerZip', 'eDoc Container ZIP'
      prop :edoc_csa_agreement_id, 'edocCsaAgreementId', 'eDoc CSA Agreement ID'
      prop :edoc_customer_group_id, 'edocCustomerGroupId', 'eDoc Customer Group ID'
      prop :edoc_parent_container_id, 'edocParentContainerId', 'eDoc Parent Container ID'
      prop :edoc_sibling_container_id, 'edocSiblingContainerId', 'eDoc Sibling Container ID'
      prop :edoc_user_license_code, 'edocUserLicenseCode', 'eDoc User License Code'

      # FAST appointment properties
      prop :fast_appointment_scheduled_datetime, 'fastAppointmentScheduledDatetime',
           'FAST Appointment Scheduled DateTime', type: :datetime
      prop :fast_appointment_unload_end_time, 'fastAppointmentUnloadEndTime', 'FAST Appointment Unload End Time',
           type: :datetime
      prop :fast_appointment_unload_start_time, 'fastAppointmentUnloadStartTime', 'FAST Appointment Unload Start Time',
           type: :datetime

      # Count properties
      prop :piece_count, 'pieceCount', 'Piece Count'
      prop :tray_count, 'trayCount', 'Tray Count'

      # Container IMb properties
      prop :imcb, 'imcb', 'IMcb'
      prop :imcb_mid, 'imcbMid', 'IMcb MID'
      prop :imcb_routing_code, 'imcbRoutingCode', 'IMcb Routing Code'
      prop :imcb_serial_number, 'imcbSerialNumber', 'IMcb Serial Number'
      prop :imcb_stid, 'imcbStid', 'IMcb STID'
      prop :imcb_tracking_code, 'imcbTrackingCode', 'IMcb Tracking Code'

      # Container-specific recipient CRID properties
      prop :recipient_crid_of_mid_on_container, 'recipientCridOfMidOnContainer', 'Recipient CRID of MID on Container'
      prop :recipient_crid_of_mid_on_container_delegator, 'recipientCridOfMidOnContainerDelegator',
           'Recipient CRID of MID on Container Delegator'
      prop :recipient_fast_scheduler_crid, 'recipientFASTSchedulerCrid', 'Recipient FAST Scheduler CRID'
      prop :recipient_fast_scheduler_delegator_crid, 'recipientFASTSchedulerDelegatorCrid',
           'Recipient FAST Scheduler Delegator CRID'

      # Parent references
      prop :parent_tray_edoc_container_id, 'parentTrayEdocContainerId', 'Parent Tray eDoc Container ID'
      prop :parent_tray_edoc_imtb, 'parentTrayEdocImtb', 'Parent Tray eDoc IMtb'

      # Postage statement properties
      prop :postage_statement_finalization_datetime, 'postageStatementFinalizationDatetime',
           'Postage Statement Finalization DateTime', type: :datetime
      prop :postage_statement_finalization_facility_name, 'postageStatementFinalizationFacilityName',
           'Postage Statement Finalization Facility Name'

      # Routing code
      prop :routing_code_imcb_matching_portion, 'routingCodeImcbMatchingPortion', 'Routing Code (IMcb Matching Portion)'
    end
  end
end
