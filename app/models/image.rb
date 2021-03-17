class Image < ApplicationRecord
  validates :link, presence: true
  validates :link, format: { with: URI::DEFAULT_PARSER.make_regexp }
end
