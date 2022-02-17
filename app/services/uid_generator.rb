# frozen_string_literal: true

class UidGenerator
  def self.generate(prefix = 'AP')
    loop do
      uid = "%s%s" % [prefix.upcase, SecureRandom.hex(5).upcase]
      return uid if Applicant.where(uid: uid).empty?
    end
  end
end
