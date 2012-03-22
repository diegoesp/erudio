# Extends string class
class String

  # If the string contains digits, returns true
  #
  # @return [Boolean] true when the string contains a digit
  def is_number?
    true if Float(self) rescue false
  end

  # If the string contains "true" or "false", returns true
  #
  # @return [Boolean] true when the string contains "true" or "false"
  def is_boolean?
    true if self == "true"
    true if self == "false"
    false
  end

end