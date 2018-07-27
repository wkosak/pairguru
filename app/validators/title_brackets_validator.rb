class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    value = record.title
    while value =~ /\(.+\)|{.+}|\[.+\]/
      value.gsub!(/\(([^()]+)\)/, '\1')
      value.gsub!(/\{([^{}]+)\}/, '\1')
      value.gsub!(/\[([^\[\]]+)\]/, '\1')
    end
    return unless value =~ /[{}()\[\]]/
    record.errors.add :title, 'title invalid'
  end
end