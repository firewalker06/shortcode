class Shortcode::TemplateBinding

  def initialize(name, attributes=[], content='', additional_attributes=nil)
    include_helper_modules
    presenter   = Shortcode::Presenter.new name, set_attributes(attributes), content, additional_attributes
    @name       = name
    @attributes = presenter.attributes
    @content    = presenter.content
  end

  # Expose private binding() method for use with erb templates
  def get_binding
    binding
  end

  private

    def set_attributes(attributes)
      hash = {}
      attributes.each { |o| hash[o[:key].to_sym] = o[:value] }
      hash
    end

    def include_helper_modules
      return unless Shortcode.configuration.helpers.any?
      class << self
        Shortcode.configuration.helpers.each do |helper|
          include helper
        end
      end
    end

end
