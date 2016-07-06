require 'action_view'

module Bff
  module ViewAdditions
    def bff(record, options={}, &block)
      Bff::Builder.new(self, options.merge(record: record)).render_template("bff/form_builder", &block)
    end
    alias better_form_for bff
  end
end

ActionView::Base.send :include, Bff::ViewAdditions
