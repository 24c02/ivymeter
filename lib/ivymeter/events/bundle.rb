# frozen_string_literal: true

require_relative 'base'

module IvyMeter
  class Event
    class BundleEvent < Event
      # Bundle-specific properties
      prop :bundle_id, 'bundleId', 'Bundle ID'
      prop :edoc_container_id, 'edocContainerId', 'eDoc Container ID'
      prop :edoc_container_zip, 'edocContainerZip', 'eDoc Container ZIP'
      prop :edoc_csa_agreement_id, 'edocCsaAgreementId', 'eDoc CSA Agreement ID'
      prop :edoc_customer_group_id, 'edocCustomerGroupId', 'eDoc Customer Group ID'
      prop :edoc_parent_container_id, 'edocParentContainerId', 'eDoc Parent Container ID'
      prop :edoc_sibling_container_id, 'edocSiblingContainerId', 'eDoc Sibling Container ID'
      prop :edoc_user_license_code, 'edocUserLicenseCode', 'eDoc User License Code'
      prop :piece_count, 'pieceCount', 'Piece Count'

      # Bundle IMb properties
      prop :imb, 'imb', 'IMb'
      prop :imb_mid, 'imbMid', 'IMb MID'
      prop :imb_routing_code, 'imbRoutingCode', 'IMb Routing Code'
      prop :imb_serial_number, 'imbSerialNumber', 'IMb Serial Number'
      prop :imb_stid, 'imbStid', 'IMb STID'
      prop :imb_tracking_code, 'imbTrackingCode', 'IMb Tracking Code'

      # Bundle-specific recipient CRID properties
      prop :recipient_crid_of_mid_on_bundle, 'recipientCridOfMidOnBundle', 'Recipient CRID of MID on Bundle'
      prop :recipient_crid_of_mid_on_bundle_delegator, 'recipientCridOfMidOnBundleDelegator',
           'Recipient CRID of MID on Bundle Delegator'

      # Postage statement properties
      prop :postage_statement_finalization_datetime, 'postageStatementFinalizationDatetime',
           'Postage Statement Finalization DateTime', type: :datetime
      prop :postage_statement_finalization_facility_name, 'postageStatementFinalizationFacilityName',
           'Postage Statement Finalization Facility Name'

      # Routing code
      prop :routing_code_imb_matching_portion, 'routingCodeImbMatchingPortion', 'Routing Code (IMb Matching Portion)'
    end
  end
end
