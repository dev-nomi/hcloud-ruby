# frozen_string_literal: true

module Hcloud
  class FirewallResource < AbstractResource
    filter_attributes :name

    bind_to Firewall

    def [](arg)
      case arg
      when Integer then find_by(id: arg)
      when String then find_by(name: arg)
      end
    end

    def create(name:, rules: nil, labels: nil, apply_to: nil)
      prepare_request(
        'firewalls', j: COLLECT_ARGS.call(__method__, binding),
                    expected_code: 201
      ) do |response|
        [
          response.parsed_json[:root_password],
          Firewall.new(client, response.parsed_json[:firewall]),
          response.parsed_json[:actions].map do |action|
            Action.new(client, action)
          end
        ]
      end
    end
  end
end