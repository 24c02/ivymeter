# frozen_string_literal: true

require_relative 'base'

module IvyMeter
  class Event
    class PieceEvent < Event
      # Delivery date properties
      prop :anticipated_delivery_date, 'anticipatedDeliveryDate', 'Anticipated Delivery Date', type: :date
      prop :expected_delivery_date, 'expectedDeliveryDate', 'Expected Delivery Date', type: :date
      prop :predicted_delivery_date, 'predictedDeliveryDate', 'Predicted Delivery Date', type: :date

      # IMb properties
      prop :imb, 'imb', 'IMb'
      prop :imb_mid, 'imbMid', 'IMb MID'
      prop :imb_routing_code, 'imbRoutingCode', 'IMb Routing Code'
      prop :imb_serial_number, 'imbSerialNumber', 'IMb Serial Number'
      prop :imb_stid, 'imbStid', 'IMb STID'
      prop :imb_tracking_code, 'imbTrackingCode', 'IMb Tracking Code'

      # IMpb properties
      prop :impb, 'impb', 'IMpb'

      # LDE properties
      prop :lde_delivery_mode, 'ldeDeliveryMode', 'LDE Delivery Mode'
      prop :lde_inventory_method, 'ldeInventoryMethod', 'LDE Inventory Method'
      prop :lde_trigger_method, 'ldeTriggerMethod', 'LDE Trigger Method'

      # Mail phase
      prop :mail_phase, 'mailPhase', 'Mail Phase'

      # Operational status
      prop :operational_status, 'operationalStatus', 'Operational Status'

      # Parent references
      prop :parent_container_edoc_container_id, 'parentContainerEdocContainerId', 'Parent Container eDoc Container ID'
      prop :parent_container_edoc_imtb, 'parentContainerEdocImtb', 'Parent Container eDoc IMcb'
      prop :parent_tray_edoc_container_id, 'parentTrayEdocContainerId', 'Parent Tray eDoc Container ID'
      prop :parent_tray_edoc_imtb, 'parentTrayEdocImtb', 'Parent Tray eDoc IMtb'

      # Piece identifier
      prop :piece_id, 'pieceId', 'Piece ID'

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
