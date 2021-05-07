module EndpointBase::Concerns
  module RailsResponder
    extend ActiveSupport::Concern

    included do
      if EndpointBase.rails?
        include Helpers
      elsif EndpointBase.sinatra?
        raise 'This Concern is only intended to be used with Rails.'
      end
    end

    module Helpers
      def result(code, summary)
        set_summary summary
        process_result code
      end

      def process_result(code)
        render "application/response", status: code
      end
    end
  end
end

