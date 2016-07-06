module Bff
  class Builder < Blocks::Builder
    attr_accessor :fields
    attr_accessor :form

    def initialize(*)
      self.fields = []
      super
    end

    def field(field_name, options={}, &block)
      if definition_mode == Blocks::Builder::DEFINITION_MODE_TEMPLATE_OVERRIDES
        fields << define(field_name, options, &block)
      else
        render(field_name, form, field_name, options, &block)
      end
    end

    def form_tag(record, options={}, &block)
      form_options = { html: options[:form_html] }
      form_options[:url] = options[:url] if options[:url]
      view.form_for record, form_options.deep_symbolize_keys do |form|
        @form = form
        view.capture(form, &block)
      end
    end

    def label_options(options)
      o = []
      o << options[:label] if options[:label]
      o << options[:label_html] if options[:label_html]
      o
    end
  end
end
