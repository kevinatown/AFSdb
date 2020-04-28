class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :validatable,
  devise :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable,  authentication_keys: [:username]


  belongs_to :staff, inverse_of: :user
  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :time_clocks, through: :staff

  after_create :create_profile

  validates_presence_of   :username #, if: :email_required?
  validates_uniqueness_of :username
  # , allow_blank: true, if: :email_changed?
  # validates_format_of     :username, allow_blank: true, if: :email_changed?

  validates_presence_of     :password #, if: :password_required?
  # validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: 6..128, allow_blank: true

  # [ ... ] The rest of your model stuff

    def get_time_clock
      TimeClock.where(staff: self.staff).order("created_at").last
    end

    def clocked_in?
      tc = TimeClock.where(staff: self.staff).order("created_at").last
      puts tc.present? and not tc.time_out.present?
      tc.present? and not tc.time_out.present?
    end

    def create_profile
    	Profile.create(:user_id => self.id)
    end

    def is_admin?
      return self.staff.is_admin
    end

     # protected

    # From Devise module Validatable
    # def password_required?
    #   !persisted? || !password.nil? || !password_confirmation.nil?
    # end

    # # From Devise module Validatable
    # def email_required?
    #   true
    # end
end
