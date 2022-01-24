# Makes Grape API acronym via Zeitwerk autoloader
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym 'API'
end