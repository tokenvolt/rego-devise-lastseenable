require 'rego-devise-lastseenable/hooks'

module Devise
  module Models
    module Lastseenable
      def stamp!
        interval = self.class.lastseenable_interval
        if self.last_seen_at.to_i < (Time.now - interval.minutes).to_i
          self.last_seen_at = DateTime.now
          self.save!
        end
      end

      module ClassMethods
        Devise::Models.config(self, :lastseenable_interval)
      end
    end
  end
end