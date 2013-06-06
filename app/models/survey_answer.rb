class SurveyAnswer < ActiveRecord::Base
  belongs_to :survey_question
  belongs_to :user

  delegate :survey, to: :survey_question

  attr_accessible :survey_question_id, :value, :user_id
  serialize :value, Array

  PAGE = 1
  PER_PAGE = 50

  scope :includes_surveys, includes(survey_question: :survey)

  scope :includes_question, includes(:survey_question)

  scope :includes_user, includes(:user)

  scope :for_user, ->(user_id) { where(user_id: user_id) }

  scope :joins_surveys, joins(survey_question: :survey)

  scope :for_survey_with_joins, ->(survey_id){joins_surveys.where(["surveys.id = :survey_id", survey_id: survey_id])}

  scope :for_survey_with_inclusion, ->(survey_id){includes_surveys.where(["surveys.id = :survey_id", survey_id: survey_id])}

  scope :created_backwords, order("\"survey_answers\".created_at DESC")

  scope :uniq_users, ->(survey_id){for_survey(survey_id).pluck(:user_id).uniq}

  def self.uniq_shop_ids(user_id)
    for_user(user_id).includes_surveys.collect(&:survey_question).collect(&:survey).collect(&:shop_id).uniq
  end

  def self.persist(current_user, answers)
    SurveyAnswer.transaction do
      answers.each do |answer|
        answer.user_id = current_user.id
        answer.save!
      end
    end

  end

  def self.paginated_users(survey_id, page_number=PAGE, per_page=PER_PAGE)
    select("DISTINCT(survey_answers.user_id), survey_answers.created_at").for_survey_with_joins(survey_id).created_backwords.page(page_number).per(per_page)
  end


  def self.answers_arranged_by_users(survey_id, user_ids)
    answers = for_survey_with_inclusion(survey_id).for_user(user_ids).includes_user.created_backwords

    user_ids = answers.collect(&:user_id)
    users_hash = ActiveSupport::OrderedHash.new

    user_ids.each {|user_id| users_hash[user_id] = []}

    answers.each do |answer|
      users_hash[answer.user_id] << answer
    end
    users_hash
  end

  def question
    survey_question.label
  end

  def self.users(survey_id)
    cache_key = "users-for-survey-#{survey_id}"
    Rails.cache.fetch(cache_key, :expires_in => SiteConfig.ttls.dashboard_count) do
      select("DISTINCT(survey_answers.user_id), survey_answers.created_at").for_survey_with_joins(survey_id).created_backwords
    end
  end
end