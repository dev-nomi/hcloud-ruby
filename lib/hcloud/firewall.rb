# frozen_string_literal: true

module Hcloud
  class Firewall
    require 'hcloud/firewall_resource'

    include EntryLoader

    schema(
      created: :time
    )

    protectable :delete
    updatable :name
    destructible

    has_actions

    def set_rules(rules:)
      prepare_request('actions/set_rules', j: { rules: rules })
    end
  end
end
