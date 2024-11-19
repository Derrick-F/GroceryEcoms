class Promotion < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :item, optional: true

  validates :promo_type, presence: true, inclusion: { in: %w[flat_fee percentage buy_x_get_y weight_threshold] }
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :start_time, presence: true
  validate :end_time_after_start_time

  # This validation is here so we can check if end time is present and if its after start time
  def end_time_after_start_time
    if end_time.present? && end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
