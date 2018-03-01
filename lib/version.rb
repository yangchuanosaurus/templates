module Template
  VERSION_INFO = [1, 0, 0, 'rc1'].freeze
  VERSION = VERSION_INFO.map(&:to_s).join('.').freeze

  def self.version
    VERSION
  end
end
