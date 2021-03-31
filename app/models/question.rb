class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  # Active Record is known as an ORM, an Object Relational Mapper
  # We use objects to represent tables and data from our database.
  # This class "Question" represents the "questions" table.
  # Instances of the Question class represent a row of data in 
  # the "questions" table.

  # We generated this file when we ran the following command. 
  # Make sure that model is singular.
  # rails g model question title body:text

  # To read more on validations: https://guides.rubyonrails.org/active_record_validations.html
  validates(:title, presence: true, uniqueness: true)

  # To read an array of error messages after failling validation:
  # record.errors.full_messages
  validates(
    :body, 
    presence: { message: "must include a question" },
    length: { minimum: 10 },
  )

  #validates(:view_count, numericality: { greater_than_or_equal_to: 0 })

  # Custom validations
  # Use the "validate" (singluar) for custom validations
  validate(:no_monkey)
  validate(:no_title_in_body)

  # Create a scope with a class method. We can create a scope with
  # the "scope" method. The arguments are:
  # 1. The class method's name as a symbol
  # 2. A lambda. The return value is returned from the class method.
  scope(:recent_ten, ->{ order(created_at: :desc).limit(10) })
  # The above is equivalent to:
  # def self.recent_ten
  #   order(created_at: :desc).limit(10)
  # end

  scope(:search, ->(word){ where('title ILIKE ? OR body ILIKE ?', "%#{word}%", "%#{word}%") })
  # There exists many callbacks that run a code block at different 
  # stages of a record's lifecycle. List of callbacks found here:
  # https://guides.rubyonrails.org/active_record_callbacks.html#available-callbacks
  before_save do 
    # self is the record/instance
    # Immediately before saving to the database, captialize the title
    self.title = title.capitalize 
  end

  private

  def no_monkey
    # For each column/attribute, the attr_accessors are already defined
    # We can access each attribute for each instance e.g. "body", "title"

    # &. is a safe navigation operator. It's used like the "." to 
    # call methods on an object. If the method does not exist for 
    # the object, "nil" will be returned instead of raising an error.
    # Similar body && body.downcase
    if body&.downcase.include?("monkey")
      # To make a record invalid, add a validation error using the 
      # "add" method on the error object of the instance.
      # Its arguments are:
      # 1. Name of the invalid column as a symbol
      # 2. Error message as a string
      errors.add(:body, "must not include monkeys")
    end
  end

  def no_title_in_body
    if body&.downcase.include?(title.downcase)
      errors.add(:body, "must not include the title")
    end
  end
end