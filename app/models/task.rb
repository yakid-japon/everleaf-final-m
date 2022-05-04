class Task < ApplicationRecord
    has_many :task_tags, dependent: :destroy
    has_many :tags, through: :task_tags, source: :tag
    validates :name, presence: true
    scope :order_by_deadline, -> {order(deadline: :desc)}
    scope :order_by_priority, -> {order(priority: :desc)}
    scope :search_by_status, -> (status){where(status: status)}
    # scope :search_by_tag, -> (tag){where(id: tag)}
    scope :search_by_name, -> (name){where("name LIKE ?", "%#{name}%")}
    scope :search_by_name_and_status, -> (name, status){where("name LIKE ? AND status LIKE ?", "%#{name}%", status)}
    enum priority: [ :low, :middle, :high ]
    belongs_to :user
end
