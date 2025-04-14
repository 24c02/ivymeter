# frozen_string_literal: true

RSpec.describe IvyMeter::Event do
  let(:event) { described_class.new }
  let(:json_data) do
    {
      'edocJobId' => '123',
      'scanDatetime' => '2024-04-14T12:00:00Z',
      'scanEventCode' => '1234',
      'handlingEventType' => 'A'
    }
  end

  let(:csv_data) do
    {
      'eDoc Job ID' => '123',
      'Scan DateTime' => '2024-04-14T12:00:00Z',
      'Scan Event Code' => '1234',
      'Handling Event Type' => 'A'
    }
  end

  describe 'property mappings' do
    it 'defines properties with correct mappings' do
      expect(described_class.property_mappings[:edoc_job_id]).to eq(
        { json: 'edocJobId', csv: 'eDoc Job ID', type: nil }
      )
    end

    it 'inherits property mappings to subclasses' do
      subclass = Class.new(described_class)
      expect(subclass.property_mappings).to eq(described_class.property_mappings)
    end
  end

  describe '.from_json' do
    it 'creates an event with properties from JSON data' do
      event = described_class.from_json(json_data)
      expect(event.edoc_job_id).to eq('123')
      expect(event.scan_datetime).to be_a(DateTime)
      expect(event.scan_datetime&.iso8601).to eq('2024-04-14T12:00:00+00:00')
      expect(event.scan_event_code).to eq('1234')
      expect(event.handling_event_type).to eq('A')
    end

    it 'handles local timezone datetime format' do
      json_data['scanDatetime'] = '2024-04-14 12:00:00'
      event = described_class.from_json(json_data)
      expect(event.scan_datetime).to be_a(DateTime)
      expect(event.scan_datetime&.strftime('%Y-%m-%d %H:%M:%S')).to eq('2024-04-14 12:00:00')
    end
  end

  describe '.from_csv' do
    it 'creates an event with properties from CSV data' do
      event = described_class.from_csv(csv_data)
      expect(event.edoc_job_id).to eq('123')
      expect(event.scan_datetime).to be_a(DateTime)
      expect(event.scan_datetime&.iso8601).to eq('2024-04-14T12:00:00+00:00')
      expect(event.scan_event_code).to eq('1234')
      expect(event.handling_event_type).to eq('A')
    end

    it 'handles local timezone datetime format' do
      csv_data['Scan DateTime'] = '2024-04-14 12:00:00'
      event = described_class.from_csv(csv_data)
      expect(event.scan_datetime).to be_a(DateTime)
      expect(event.scan_datetime.strftime('%Y-%m-%d %H:%M:%S')).to eq('2024-04-14 12:00:00')
    end
  end

  describe '#to_json' do
    it 'converts event properties to JSON format' do
      event.edoc_job_id = '123'
      event.scan_datetime = DateTime.parse('2024-04-14T12:00:00Z')
      json = JSON.parse(event.to_json)
      expect(json['edocJobId']).to eq('123')
      expect(json['scanDatetime']).to eq('2024-04-14 12:00:00+0000')
    end

    it 'handles local timezone datetime format' do
      event.edoc_job_id = '123'
      event.scan_datetime = DateTime.parse('2024-04-14 12:00:00')
      json = JSON.parse(event.to_json)
      expect(json['edocJobId']).to eq('123')
      expect(json['scanDatetime']).to eq('2024-04-14 12:00:00+0000')
    end

    it 'omits nil values' do
      json = JSON.parse(event.to_json)
      expect(json).to be_empty
    end
  end

  describe 'event type predicates' do
    it 'correctly identifies actual events' do
      event.handling_event_type = 'A'
      expect(event.actual?).to be true
      expect(event.assumed?).to be false
    end

    it 'correctly identifies assumed actual events' do
      event.handling_event_type = 'AA'
      expect(event.assumed_actual?).to be true
      expect(event.assumed?).to be true
    end

    it 'correctly identifies logical events' do
      event.handling_event_type = 'L'
      expect(event.logical?).to be true
      expect(event.assumed?).to be false
    end

    it 'correctly identifies assumed logical events' do
      event.handling_event_type = 'AL'
      expect(event.assumed_logical?).to be true
      expect(event.assumed?).to be true
    end
  end

  describe 'opcode-related methods' do
    before do
      allow(IvyMeter::OpCode).to receive(:find).with('1234').and_return(
        double(
          stop_the_clock_scan?: true,
          unexpected?: false,
          clearance_cutoff_time: '18:00',
          mail_phase: 'Processing',
          process_description: 'Mail Processing'
        )
      )
      allow(IvyMeter::OpCode).to receive(:find).with(nil).and_return(
        nil
      )
      allow(IvyMeter::OpCode).to receive(:present?).and_return(true)
    end

    it 'finds and caches the opcode' do
      event.scan_event_code = '1234'
      expect(event.opcode).not_to be_nil
      expect(event.opcode).to eq(event.opcode)
    end

    it 'delegates opcode-related methods' do
      event.scan_event_code = '1234'
      expect(event.stop_the_clock_scan?).to be true
      expect(event.unexpected_opcode?).to be false
      expect(event.clearance_cutoff_time).to eq('18:00')
      expect(event.mail_phase).to eq('Processing')
      expect(event.process_description).to eq('Mail Processing')
    end

    it 'handles nil opcodes gracefully' do
      event.scan_event_code = nil
      expect(event.stop_the_clock_scan?).to be_nil
      expect(event.unexpected_opcode?).to be_nil
      expect(event.clearance_cutoff_time).to be_nil
      expect(event.mail_phase).to be_nil
      expect(event.process_description).to be_nil
    end
  end
end
