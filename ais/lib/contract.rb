require 'fabric'
module FabricConnection
  class Contract
    def self.load_certs
      Rails.root.join('app', 'assets', 'images', 'logo.png')

      data_dir ='../fabric-samples/test-network/organizations' # aka test-network/organizations
      files = [
          # 'peerOrganizations/org1.example.com/ca/ca.org1.example.com-cert.pem',
          'peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt',
          'peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/keystore/priv_sk',
          'peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/signcerts/Admin@org1.example.com-cert.pem'
        ]
      files.map { |f| File.open(Rails.root.join(data_dir, f)).read }
    end

    def self.get_network
      # needed if you are connecting via a different dns name or IP address
      client_opts = {
        channel_args: {
          GRPC::Core::Channel::SSL_TARGET => 'peer0.org1.example.com'
        }
      }
      # optional, if you want to set deadlines to the individual calls (in seconds)
      default_call_options = {
        endorse_options: { deadline: GRPC::Core::TimeConsts.from_relative_time(5) },
        evaluate_options: { deadline: GRPC::Core::TimeConsts.from_relative_time(5) },
        submit_options: { deadline: GRPC::Core::TimeConsts.from_relative_time(5) },
        commit_status_options: { deadline: GRPC::Core::TimeConsts.from_relative_time(5) },
        chaincode_events_options: { deadline: GRPC::Core::TimeConsts.from_relative_time(60) }
      }
      creds = GRPC::Core::ChannelCredentials.new(load_certs[0])
      # client=Fabric::Client.new(host: 'localhost:7051', creds: creds)
      peer_host =  ENV.fetch("PEER_HOST") { "localhost:7051" }
      client=Fabric::Client.new(host: peer_host, creds: creds, **client_opts)
      # client=Fabric::Client.new(host: 'localhost:7051', creds: creds, default_call_options: default_call_options, **client_opts)

      # tmp_key = OpenSSL::PKey::EC.new(load_certs[1])

      identity = Fabric::Identity.new(
        msp_id: 'Org1MSP',
        private_key: Fabric::crypto_suite.key_from_pem(load_certs[1]),
        # private_key: tmp_key,
        certificate: load_certs[2]
      )

      gateway = identity.new_gateway(client)
      # network = gateway.new_network('mainchannel')
      gateway.new_network('uinjkt')
    end

    def self.main

      network = self.get_network
      contract = network.new_contract('contract')

      # Evaluate
      # puts contract.evaluate_transaction('PerkuliahanContract:getAttendance', "attendance.1.1")

      # Submit
      # puts contract.submit_transaction('CreateAsset', ['asset13', 'yellow', '5', 'Tom', '1300'])
      # puts contract.submit_transaction('UpdateAsset', %w[asset999 yellow 5 Tom 5555])

      # Chaincode Events - simple (blocking until deadline is reached or connection closed)
      contract.chaincode_events do |event|
        puts event
      end



    end

    def self.get_contract(contract_name)
      network = self.get_network
      network.new_contract(contract_name)
    end
    # Chaincode Events - advanced
    # chaincode events are blocking and run indefinitely, so this is probably the more typical use case to give 
    # more control over the connection

    # last_processed_block = nil # store this in something persistent 

    # op = contract.chaincode_events(start_block: last_processed_block, call_options: { return_op: true }) do |event|
    #   last_processed_block = event.block_number # update the last_processed_block so we can resume from this point
    #   puts event
    # end

    # t = Thread.new do
    #   call = op.execute
    # rescue GRPC::Cancelled => e
    #   puts 'We cancelled the operation outside of this thread.'
    # end

    # sleep 1 
    # op.status
    # op.cancelled?
    # op.cancel
  end
end