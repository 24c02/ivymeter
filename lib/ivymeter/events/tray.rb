# frozen_string_literal: true

require_relative 'base'

module IvyMeter
  class Event
    class TrayEvent < Event
      # Tray-specific properties
      prop :tray_id, 'trayId', 'Tray ID'
      prop :edoc_container_id, 'edocContainerId', 'eDoc Container ID'
      prop :edoc_container_zip, 'edocContainerZip', 'eDoc Container ZIP'
      prop :edoc_csa_agreement_id, 'edocCsaAgreementId', 'eDoc CSA Agreement ID'
      prop :edoc_customer_group_id, 'edocCustomerGroupId', 'eDoc Customer Group ID'
      prop :edoc_parent_container_id, 'edocParentContainerId', 'eDoc Parent Container ID'
      prop :edoc_sibling_container_id, 'edocSiblingContainerId', 'eDoc Sibling Container ID'
      prop :edoc_user_license_code, 'edocUserLicenseCode', 'eDoc User License Code'
      prop :piece_count, 'pieceCount', 'Piece Count'

      # Tray IMb properties
      prop :imtb, 'imtb', 'IMtb'
      prop :imtb_mid, 'imtbMid', 'IMtb MID'
      prop :imtb_routing_code, 'imtbRoutingCode', 'IMtb Routing Code'
      prop :imtb_serial_number, 'imtbSerialNumber', 'IMtb Serial Number'
      prop :imtb_stid, 'imtbStid', 'IMtb STID'
      prop :imtb_tracking_code, 'imtbTrackingCode', 'IMtb Tracking Code'

      # Tray-specific recipient CRID properties
      prop :recipient_crid_of_mid_on_tray, 'recipientCridOfMidOnTray', 'Recipient CRID of MID on Tray'
      prop :recipient_crid_of_mid_on_tray_delegator, 'recipientCridOfMidOnTrayDelegator',
           'Recipient CRID of MID on Tray Delegator'

      # Parent references
      prop :parent_bundle_edoc_container_id, 'parentBundleEdocContainerId', 'Parent Bundle eDoc Container ID'
      prop :parent_bundle_edoc_imb, 'parentBundleEdocImb', 'Parent Bundle eDoc IMb'

      # Postage statement properties
      prop :postage_statement_finalization_datetime, 'postageStatementFinalizationDatetime',
           'Postage Statement Finalization DateTime', type: :datetime
      prop :postage_statement_finalization_facility_name, 'postageStatementFinalizationFacilityName',
           'Postage Statement Finalization Facility Name'

      # Routing code
      prop :routing_code_imtb_matching_portion, 'routingCodeImtbMatchingPortion', 'Routing Code (IMtb Matching Portion)'
    end
  end
end
